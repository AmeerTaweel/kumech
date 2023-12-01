# Dirty Setup

## Install Raspberry PI OS Lite x64

```bash
sudo apt update
sudo apt upgrade
sudo apt install raspi-config
sudo raspi-config
```

Go to the Interface Option and then click Serial Port.

- Select No to disable serial login shell.
- Select Yes to enable the serial interface.
- Click Finish and restart the RPi.

Hotspot Name: phone002
Hotspot Password: ZeroNoGato

## Sixfab LTE Module

- [Getting Started with Sixfab Base HAT + Quectel Modules](https://docs.sixfab.com/docs/getting-started-with-base-hat-and-quectel-ec25-eg25-module)
- [Sixfab LTE Hat Tutorials](https://docs.sixfab.com/page/tutorials)
- [Setting up a data connection over QMI interface using libqmi](https://docs.sixfab.com/page/setting-up-a-data-connection-over-qmi-interface-using-libqmi)

```bash
sudo qmicli -d /dev/cdc-wdm0 --dms-get-operating-mode
sudo ip link set wwan0 down
echo 'Y' | sudo tee /sys/class/net/wwan0/qmi/raw_ip
sudo ip link set wwan0 up
sudo qmicli -d /dev/cdc-wdm0 --wda-get-data-format
sudo qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='internet',ip-type=4" --client-no-release-cid
sudo udhcpc -q -f -i wwan0
ifconfig wwan0
ping -I wwan0 -c 5 sixfab.com
```

## Rpanion Build

- [GitHub Repo](https://github.com/stephendade/Rpanion-server)
- [Home Page](https://www.docs.rpanion.com/software/rpanion-server)
- [0.10.0 User Manual](https://www.docs.rpanion.com/software/rpanion_server_v010)

```bash
cd ~/ && git clone --recursive https://github.com/stephendade/Rpanion-server.git
cd ./deploy && ./RasPi2-3-4-deploy.sh
```

## Rpanion Run

```bash
PORT=3000 npm run server
```

## Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

And on laptop:

```bash
sudo tailscale up
```
