#include <gtk/gtk.h>
#include <gtk4-layer-shell.h>
#include <math.h>

/* Fade callback */
static gboolean fade_step(gpointer data) {
    static double alpha = 0.0;
    GtkCssProvider *css = data;

    if (alpha >= 1.0) return G_SOURCE_REMOVE;

    alpha += 0.01;
    if (alpha > 1.0) alpha = 1.0;

    char css_str[64];
    snprintf(css_str, sizeof(css_str),
             "window { background-color: rgba(0,0,0,%.2f); }", alpha);
    gtk_css_provider_load_from_string(css, css_str);

    return G_SOURCE_CONTINUE;
}

/* Quit on any mouse/touch event */
static gboolean on_any_event(GtkEventController *controller,
                             GdkEvent *event,
                             gpointer user_data) {
    GtkApplication *app = GTK_APPLICATION(user_data);
    GdkEventType type = gdk_event_get_event_type(event);

    switch (type) {
        case GDK_BUTTON_PRESS:
        case GDK_SCROLL:
        case GDK_MOTION_NOTIFY:
        case GDK_TOUCH_BEGIN:
            g_application_quit(G_APPLICATION(app));
            return GDK_EVENT_STOP;
        default:
            return GDK_EVENT_PROPAGATE;
    }
}

/* Activate callback */
static void activate(GtkApplication *app, gpointer user_data) {
    GtkWidget *window = gtk_application_window_new(app);
    gtk_window_set_decorated(GTK_WINDOW(window), FALSE);

    // Layer Shell
    gtk_layer_init_for_window(GTK_WINDOW(window));
    gtk_layer_set_layer(GTK_WINDOW(window), GTK_LAYER_SHELL_LAYER_OVERLAY);
    gtk_layer_set_keyboard_mode(GTK_WINDOW(window), GTK_LAYER_SHELL_KEYBOARD_MODE_EXCLUSIVE);
    //    gtk_layer_auto_exclusive_zone_enable(GTK_WINDOW(window));
    gtk_layer_set_anchor(GTK_WINDOW(window), GTK_LAYER_SHELL_EDGE_TOP, TRUE);
    gtk_layer_set_anchor(GTK_WINDOW(window), GTK_LAYER_SHELL_EDGE_BOTTOM, TRUE);
    gtk_layer_set_anchor(GTK_WINDOW(window), GTK_LAYER_SHELL_EDGE_LEFT, TRUE);
    gtk_layer_set_anchor(GTK_WINDOW(window), GTK_LAYER_SHELL_EDGE_RIGHT, TRUE);

    // Transparent background
    GtkCssProvider *css = gtk_css_provider_new();
    gtk_css_provider_load_from_string(css, "window { background-color: rgba(0,0,0,0); }");
    gtk_style_context_add_provider_for_display(gdk_display_get_default(),
                                               GTK_STYLE_PROVIDER(css),
                                               GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);

    // Add a dummy box for pointer events
    GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
    gtk_widget_set_hexpand(box, TRUE);
    gtk_widget_set_vexpand(box, TRUE);
    gtk_window_set_child(GTK_WINDOW(window), box);

    // Event controller for mouse/touch
    GtkEventController *legacy = gtk_event_controller_legacy_new();
    g_signal_connect(legacy, "event", G_CALLBACK(on_any_event), app);
    gtk_widget_add_controller(box, legacy);

    gtk_window_present(GTK_WINDOW(window));

    // Fade animation
    g_timeout_add(50, fade_step, css);
}

int main(int argc, char **argv) {
    GtkApplication *app = gtk_application_new("org.example.FadeBlack", G_APPLICATION_DEFAULT_FLAGS);
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);
    return g_application_run(G_APPLICATION(app), argc, argv);
}

