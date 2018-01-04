clear
echo -e "\033[31m################################################################################################################\033[0m"
echo -e "\033[31m#                                                                                                              #\033[0m"
echo -e "\033[31m#                                                  !!! ACHTUNG !!!                                             #\033[0m"
echo -e "\033[31m#                                                                                                              #\033[0m"
echo -e "\033[31m# Die Installation dieser Software nimmt eine Veraenderung der Router-Firmware vor.                            #\033[0m"
echo -e "\033[31m# Wenn Sie fortfahren, installieren Sie nicht von TDT zertifizierte und herausgegebene Software auf dem Geraet #\033[0m"
echo -e "\033[31m# Dadurch verlieren Sie alle Ansprueche auf Support, Garantie und Gewaehrleistung fuer dieses Geraet           #\033[0m"
echo -e "\033[31m#                                                                                                              #\033[0m"
echo -e "\033[31m################################################################################################################\033[0m"

echo "Ich habe die Hinweise gelesen und akzeptiert."
read -p "Mit ENTER geht's weiter"
echo -en "\nMoechten Sie fortfahren \"Yes\" or \"No\" (Ja oder Nein)? "
read x
case $x in
[YyJj]* ) echo "Installation wird fortgefuehrt" ;;
[Nn]* ) echo "Installation wird abgebrochen";exit ;;
esac

sleep 2

# Holt und installiert alle notwendigen Pakete
echo -e "\033[31m Download und Installation der benoetigten Pakete\033[0m"

opkg list-installed | grep "libffi - 3.0.13-1" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/ffzncdux5ztoe2q/libffi.ipk?dl=1 -O /root/libffi.ipk
opkg install /root/libffi.ipk

fi

opkg list-installed | grep "libattr - 20150220-1" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/cok6g13j7kyrx9y/libattr.ipk?dl=1 -O /root/libattr.ipk
opkg install /root/libattr.ipk
fi

opkg list-installed | grep "glib2 - 2.43.4-1" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/42hqn18eisli9qj/glib2.ipk?dl=1 -O /root/glib2.ipk
opkg install /root/glib2.ipk
fi

opkg list-installed | grep "libblkid - 2.25.2-4" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/ecpi7xd276ltfrv/libblkid.ipk?dl=1 -O /root/libblkid.ipk
opkg install /root/libblkid.ipk
fi

opkg list-installed | grep "libmount - 2.25.2-4" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/p75ll2ijiezy5cn/libmount.ipk?dl=1 -O /root/libmount.ipk
opkg install /root/libmount.ipk
fi

opkg list-installed | grep "librpc - 2015-04-10-308e9964bfb623773dc0dcc99ef9d18d1551d6ae" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/9jlbb5d7i3fgcft/librpc.ipk?dl=1 -O /root/librpc.ipk
opkg install /root/librpc.ipk
fi

opkg list-installed | grep "mc - 4.8.14-1.3" >/dev/null && test=1||test=0
if [ "$test" = 0 ]
then
wget https://www.dropbox.com/s/wagxrgphrffvwc8/MidnightCommander.ipk?dl=1 -O /root/mc.ipk
opkg install /root/mc.ipk
fi

rm /root/*.ipk 2>/dev/null

echo -e "\033[31m Download und Installation der benoetigten Pakete und des Midnight Commanders abgeschlossen.\033[0m"