
adb_connect() {

    IP=$(adb shell ip -f inet addr | grep -oP '(?<=inet\s)10\.\d+\.\d+\.\d+')
    if [[ -z $IP ]]; then
        echo "No device found with IP matching 10.*.*.*. Make sure the device is connected via USB and adb debugging is enabled."
        return 1
    fi
    echo "Device IP: $IP"
    adb tcpip 5555
    adb connect "$IP"
}