# Snapshot da placa — 2026-08-29 (pós-reboot, OC 1800)

Valores lidos na Pi no commit deste snapshot.

```
Hardware
  Raspberry Pi 4 Model B Rev 1.2
  Revision  c03112
  Serial    100000002a428ae8
  RAM       3.7 GiB visível (4 GB)
  SD        mmcblk0 119.1G (SD128, 01/2021)

OS
  Debian GNU/Linux 12 (bookworm) — Raspberry Pi OS
  Linux raspberrypi 6.12.96+rpt-rpi-v8 aarch64
  Firmware VideoCore  May 21 2026
  EEPROM              2026-05-17

Energia / clocks
  arm_freq=1800  over_voltage=4
  governor=ondemand  600000–1800000
  fonte: Xiaomi MDY-11-EQ (USB-A, 5 V/3 A)
  throttled histórico após bench: 0x80000 (soft temp limit; NÃO undervoltage)
  temp ociosa ~54 °C; 7-Zip 4T ~61–84 °C

HDMI
  HDMI-A-2 connected  LG Electronics LG TV SSCR2
  1920x1080@60

Rede
  wlan0 192.168.1.100/24 manual
  gateway 192.168.1.1
  DNS 192.168.1.1, 1.1.1.1
  wifi.powersave=disable
  eth0 unavailable

Swap
  /dev/zram0 lz4 949.2M prio 100

Docker
  29.7.2  compose v5.5.0  swarm inactive

Bench (2026-08-29, ainda a 1500 MHz, para referência)
  SHA-256×4 ~564 MB/s   7-Zip tot 5530 MIPS
  SHA-256×4 a 1800 MHz ~641 MB/s   7-Zip tot 6377 MIPS
  SD seq ~18 MB/s   rand 4k ~580 IOPS
```
