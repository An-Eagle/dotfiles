import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { With, createState } from "ags"
import GObject, { register, property } from "ags/gobject"

import Sliders from "./quicksettings/Sliders"
import QuickToggles from "./quicksettings/QuickToggles"
import TopButton from "./quicksettings/Topbutton"
import Notifications from "./quicksettings/Notifications"

import PowerPage from "./pages/Power"
import WifiPage from "./pages/Wifi"
import BluetoothPage from "./pages/Bluetooth"

export default function QuickSettings() {
  const [OverlayView, setOverlayView] = createState(false)
  const [PowerMenuView, setPowerMenuView] = createState(false)
  const [WifiView, setWifiView] = createState(false)
  const [BluetoothView, setBluetoothView] = createState(false)
  let popoverRef: Gtk.Popover;
  return (
    <popover $={(p) => (popoverRef = p)} name="quicksettings" class="quicksettings">
      <overlay>
        <box orientation={Gtk.Orientation.VERTICAL} >
	  <TopButton getPopoverRef={() => popoverRef} PowerMenuView={PowerMenuView} setPowerMenuView={setPowerMenuView} />
  	  <Sliders/>
	  <QuickToggles WifiView={WifiView} setWifiView={setWifiView} BluetoothView={BluetoothView} setBluetoothView={setBluetoothView} />
	  <Notifications OverlayView={OverlayView} setOverlayView={setOverlayView} />
      	</box>
	<box $type="overlay" visible = {PowerMenuView}>
	  <PowerPage PowerMenuView={PowerMenuView} setPowerMenuView={setPowerMenuView}/>
	</box>
	<box $type="overlay" visible = {WifiView}>
	  <WifiPage WifiView={WifiView} setWifiView={setWifiView}/>
	</box>
	<box $type="overlay" visible = {BluetoothView}>
	  <BluetoothPage BluetoothView={BluetoothView} setBluetoothView={setBluetoothView}/>
	</box>
      </overlay>
    </popover>
  )
}
