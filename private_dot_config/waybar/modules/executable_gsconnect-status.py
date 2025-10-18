#!/usr/bin/python3
from pydbus import SessionBus
import json

session_bus = SessionBus()
proxy_gsconnect = session_bus.get(
    'org.gnome.Shell.Extensions.GSConnect',
    '/org/gnome/Shell/Extensions/GSConnect')
gsconnect = proxy_gsconnect[
    'org.freedesktop.DBus.ObjectManager']

waybar = {'text': "", 'alt': "", "class": "", "types": ""}

icons = {'smartphone-symbolic': "󰄜","tablet-symbolic": "",
         'tv-symbolic': "", 'computer-symbolic': ""}

types = []
devices = gsconnect.GetManagedObjects()


for dev in devices:
    devinfo = devices[dev]['org.gnome.Shell.Extensions.GSConnect.Device']
    if devinfo['Connected']:
        if devinfo['Paired']:
            types.append(devinfo['Type'])
            waybar['text'] += icons[devinfo['IconName']] + ' '
            waybar['alt'] += icons[devinfo['IconName']]  + ' ' + devinfo['Name'] +'\n'
            waybar['class'] += "connected"
        if not devinfo['Paired']:
            types.append(devinfo['Type'])
            waybar['text'] += "No devices connected"
            waybar['alt'] += ""
            waybar['class'] += "disconnected"

waybar['types'] = '+'.join(types)


if not waybar['text'].strip():
    waybar['text'] = "No devices connected"  # Example placeholder icon (Font Awesome question mark)
    waybar['alt'] = ""
    waybar['types'] = ""
    waybar['class'] += "disconnected"

for key in waybar:
    waybar[key] = waybar[key].strip()

print(json.dumps(waybar))
