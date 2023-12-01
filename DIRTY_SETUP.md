# Dirty Setup

## First Time Setup

### Install Using RPI Imager

- OS: Raspberry PI Lite x64
- Hotspot Name: phone002
- Hotspot Password: ZeroNoGato
- Enable SSH with password login

### SSH

- Be on the same hotspot.
- Run `ifconfig`.
- Get the IP.
- Run: `sudo nmap -sS -p 22 $IP/24`

### Update System

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

```bash
sudo apt install git
sudo apt install vim
sudo apt install tmux
```

### Sixfab LTE Module

- [Getting Started with Sixfab Base HAT + Quectel Modules](https://docs.sixfab.com/docs/getting-started-with-base-hat-and-quectel-ec25-eg25-module)
- [Sixfab LTE Hat Tutorials](https://docs.sixfab.com/page/tutorials)
- [QMI Interface Internet Connection Setup Using Sixfab Shield/HAT](https://docs.sixfab.com/page/qmi-interface-internet-connection-setup-using-sixfab-shield-hat)
- [Setting up a data connection over QMI interface using libqmi](https://docs.sixfab.com/page/setting-up-a-data-connection-over-qmi-interface-using-libqmi)

```bash
wget https://raw.githubusercontent.com/sixfab/Sixfab_QMI_Installer/main/qmi_install.sh
sudo chmod +x qmi_install.sh
sudo ./qmi_install.sh
```

```bash
sudo apt install libqmi-utils udhcpc
```

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

### Rpanion Build

- [GitHub Repo](https://github.com/stephendade/Rpanion-server)
- [Home Page](https://www.docs.rpanion.com/software/rpanion-server)
- [0.10.0 User Manual](https://www.docs.rpanion.com/software/rpanion_server_v010)

```bash
cd ~/ && git clone --recursive https://github.com/stephendade/Rpanion-server.git
cd Rpanion-server
cd ./deploy && ./RasPi2-3-4-deploy.sh
```

### Rpanion Run

```bash
PORT=3000 npm run server
```

### Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

And on laptop:

```bash
sudo tailscale up
```

## Each Time

### SSH

- Be on the same hotspot.
- Run `ifconfig`.
- Get the IP.
- Run: `sudo nmap -sS -p 22 $IP/24`

### Sixfab LTE Module

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

### Rpanion Run

```bash
PORT=3000 npm run server
```

### Tailscale

Both Raspberry Pi and Laptop:

```bash
sudo tailscale up
```

Now you can ssh through Tailscale, and have live video as well.
