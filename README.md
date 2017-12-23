# VR2020_Alarm
Alarm LEDs bei Verbindungswegfall beim TDT VR2020-D/LD

Um bei dem VR2020 eine etwas „feinere“ Art der ALARM-LED
zu realisieren, wird folgendes Script unter /etc/hotplug.d/iface/
angelegt (z.B. 99-alarm) und mit chmod +x /etc/hotplug.d/iface/99-alarm
ausführbar gemacht:

ACHTUNG AUCH HIER GILT:

DIE INSTALLATION ERFOLGT AUF EIGENE GEFAHR –
KEINE GARANTIE, GEWÄHRLEISUNG ODER SUPPORT SEITENS DES HERSTELLERS!


#!/bin/sh
#
# Copyright (C) 2017 TDT GmbH
#
# This is free software, licensed under the GNU General Public License v2.
# See https://www.gnu.org/licenses/gpl-2.0.txt for more information.
#
########################################################################

. /lib/functions.sh
. /lib/functions/network.sh
. /usr/share/libubox/jshn.sh

log() {
logger -p daemon.debug -t "Skript" "$1"
}

# Einlesen der Alarmstates
alarmstate_wan=$(uci_get_state network wan alarmstate 0)
alarmstate_wwan=$(uci_get_state network wwan alarmstate 0)
alarmstate_xdsl=$(uci_get_state network xdsl alarmstate 0)


### WAN - Events bei WAN up & down ####################################
if [ "${ACTION}" = "ifup" ] && [ "${INTERFACE}" = "wan" ]
then
 if [ "$alarmstate_wwan" = 0 ] && [ "$alarmstate_xdsl" = 0 ] && [ "$alarmstate_wan" = 1 ]
 then
 uci_toggle_state network wan alarmstate 0
 /etc/init.d/./wwan_leds start
 /etc/init.d/./led reload
 log "WAN UP-TEST"
 log "WAN ALARM LED OFF"
 log "KEINE VERBINDUNGSFEHLER MEHR VORHANDEN!"
 else
 uci_toggle_state network wan alarmstate 0
 echo '0' > /sys/class/leds/led1/brightness
 log "WAN UP-TEST"
 log "WAN ALARM LED OFF"
 log "ES SIND NOCH VERBINDUNGSFEHLER VORHANDEN!"
 fi
fi


if [ "${ACTION}" = "ifdown" ] && [ "${INTERFACE}" = "wan" ]
then
 if [ "$alarmstate_wwan" = 0 ] && [ "$alarmstate_xdsl" = 0 ] && [ "$alarmstate_wan" = 0 ]
 then
 uci_toggle_state alarmstate wan 1
 /etc/init.d/./wwan_leds stop
 sleep 5s
 echo '0' > /sys/class/leds/led0/brightness
 echo '255' > /sys/class/leds/led1/brightness
 echo '0' > /sys/class/leds/led2/brightness
 echo '0' > /sys/class/leds/led3/brightness
 echo '0' > /sys/class/leds/led4/brightness
 echo '0' > /sys/class/leds/led5/brightness
 echo '0' > /sys/class/leds/led6/brightness
 echo '255' > /sys/class/leds/led7/brightness
 echo '0' > /sys/class/leds/led8/brightness
 else
 uci_toggle_state alarmstate wan 1
 echo '255' > /sys/class/leds/led1/brightness
 fi
 log "WAN DOWN-TEST"
 log "WAN ALARM LED OFF"
fi
#-----------------------------------------------------------------------

### XDSL - Events bei xDSL up & down ####################################
if [ "${ACTION}" = "ifup" ] && [ "${INTERFACE}" = "xdsl" ]
then
 if [ "$alarmstate_wwan" = 0 ] && [ "$alarmstate_xdsl" = 1 ] && [ "$alarmstate_wan" = 0 ]
 then
 uci_toggle_state network xdsl alarmstate 0
 /etc/init.d/./wwan_leds start
 /etc/init.d/./led reload
 log "xDSL UP-TEST"
 log "xDSL ALARM LED OFF"
 log "KEINE VERBINDUNGSFEHLER MEHR VORHANDEN!"
 else
 uci_toggle_state network xdsl alarmstate 0
 echo '0' > /sys/class/leds/led8/brightness
 log "xDSL UP-TEST"
 log "xDSL ALARM LED OFF"
 log "ES SIND NOCH VERBINDUNGSFEHLER VORHANDEN!"
 fi
fi


if [ "${ACTION}" = "ifdown" ] && [ "${INTERFACE}" = "xdsl" ]
then
 if [ "$alarmstate_wwan" = 0 ] && [ "$alarmstate_xdsl" = 0 ] && [ "$alarmstate_wan" = 0 ]
 then
 uci_toggle_state network xdsl alarmstate 1
 /etc/init.d/./wwan_leds stop
 sleep 5s
 echo '0' > /sys/class/leds/led0/brightness
 echo '0' > /sys/class/leds/led1/brightness
 echo '0' > /sys/class/leds/led2/brightness
 echo '0' > /sys/class/leds/led3/brightness
 echo '0' > /sys/class/leds/led4/brightness
 echo '0' > /sys/class/leds/led5/brightness
 echo '0' > /sys/class/leds/led6/brightness
 echo '255' > /sys/class/leds/led7/brightness
 echo '255' > /sys/class/leds/led8/brightness
 else
 uci_toggle_state network xdsl alarmstate 1
 echo '255' > /sys/class/leds/led8/brightness
 fi
 log "xDSL DOWN-TEST"
 log "xDSL ALARM LED ON"
fi
#-----------------------------------------------------------------------

### WWAN - Events bei WWAN (LTE) up & down ####################################
if [ "${ACTION}" = "ifup" ] && [ "${INTERFACE}" = "wwan" ]
then
 if [ "$alarmstate_wwan" = 1 ] && [ "$alarmstate_xdsl" = 0 ] && [ "$alarmstate_wan" = 0 ]
 then
 uci_toggle_state network wwan alarmstate 0 
 /etc/init.d/./wwan_leds start
 /etc/init.d/./led reload
 log "WWAN UP-TEST"
 log "WWAN ALARM LED OFF"
 log "KEINE VERBINDUNGSFEHLER MEHR VORHANDEN!"
 else
 uci_toggle_state network wwan alarmstate 0
 echo '0' > /sys/class/leds/led3/brightness
 log "WWAN UP-TEST"
 log "WWAN ALARM LED OFF"
 log "ES SIND NOCH VERBINDUNGSFEHLER VORHANDEN!"
 fi
fi

if [ "${ACTION}" = "ifdown" ] && [ "${INTERFACE}" = "wwan" ]
then
 if [ "$alamrstate_wwan" = 0 ] && [ "$alarmstate_xdsl" = 0 ] && [ "$alarmstate_wan" = 0 ]
 then
 uci_toggle_state network wwan alarmstate 1
 /etc/init.d/./wwan_leds stop
 sleep 5s
 echo '0' > /sys/class/leds/led0/brightness
 echo '0' > /sys/class/leds/led1/brightness
 echo '0' > /sys/class/leds/led2/brightness
 echo '255' > /sys/class/leds/led3/brightness
 echo '0' > /sys/class/leds/led4/brightness
 echo '0' > /sys/class/leds/led5/brightness
 echo '0' > /sys/class/leds/led6/brightness
 echo '255' > /sys/class/leds/led7/brightness
 echo '0' > /sys/class/leds/led8/brightness
 else
 uci_toggle_state network wwan alarmstate 1
 echo '255' > /sys/class/leds/led3/brightness
 fi
 log "WWAN DOWN-TEST"
 log "WWAN ALARM LED ON"
fi
#-----------------------------------------------------------------------

Somit werden die Alarmstates vorne über die LEDs angezeigt.

Um diese bei Bedarf manuell wieder zurücksetzen zu können,
wird im Ordner /usr/sbin noch das folgende Script alarmstate erstellt und mit
chmod +x alarmstate ausführbar gemacht:

#!/bin/sh
#
# Copyright (C) 2017 TDT GmbH
#
# This is free software, licensed under the GNU General Public License v2.
# See https://www.gnu.org/licenses/gpl-2.0.txt for more information.
#
########################################################################

. /lib/functions.sh
. /lib/functions/network.sh
. /usr/share/libubox/jshn.sh

log() {
logger -p daemon.debug -t "Skript" "$1"
}

# Einlesen der Alarmstates
alarmstate_wan=$(uci_get_state network wan alarmstate 0)
alarmstate_wwan=$(uci_get_state network wwan alarmstate 0)
alarmstate_xdsl=$(uci_get_state network xdsl alarmstate 0)


case $1 in
 reset)
 uci_toggle_state network wan alarmstate 0
 uci_toggle_state network xdsl alarmstate 0 
 uci_toggle_state network wwan alarmstate 0
 /etc/init.d/./wwan_leds start
 /etc/init.d/./led reload
 log "ALARMSTATES MANUELL ZURUECKGESETZT!"
 ;;
 status)
 echo "Alarmstatus WAN:" $alarmstate_wan
 echo "Alarmstatus WWAN:" $alarmstate_wwan
 echo "Alarmstatus DSL:" $alarmstate_xdsl
 ;;
esac


Damit kann der Status jederzeit mit alarmstate reset wieder auf 0 zurückgesetzt werden.
Mit alarmstate status wird der momentane Alarmstatus der Interfaces angezeigt.
