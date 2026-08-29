# Snapshot Raspberry Pi OS Bookworm (2026-08-29)

Placa: **Raspberry Pi 4 Model B Rev 1.2**, 4 GB (`c03112`).  
Rede: **`192.168.1.100/24`** estático no Wi‑Fi (`ExampleNetwork_5G`).  
Acesso: `ssh raspberry` (chave em `authorized_keys`).

## Arquivos e destino na placa

| Neste repo | Destino |
|---|---|
| [boot/firmware/config.txt](./boot/firmware/config.txt) | `/boot/firmware/config.txt` |
| [boot/firmware/cmdline.txt](./boot/firmware/cmdline.txt) | `/boot/firmware/cmdline.txt` |
| [kanshi/config](./kanshi/config) | `~/.config/kanshi/config` |
| [autostart/orca-autostart.desktop](./autostart/orca-autostart.desktop) | `~/.config/autostart/orca-autostart.desktop` |
| [docker/daemon.json](./docker/daemon.json) | `/etc/docker/daemon.json` |
| [zram/zramswap](./zram/zramswap) | `/etc/default/zramswap` |
| [nm/99-wifi-powersave-off.conf](./nm/99-wifi-powersave-off.conf) | `/etc/NetworkManager/conf.d/99-wifi-powersave-off.conf` |
| [nm/99-wifi-powersave-off.dispatcher](./nm/99-wifi-powersave-off.dispatcher) | `/etc/NetworkManager/dispatcher.d/99-wifi-powersave-off` (exec) |
| [nm/wifi-connection.txt](./nm/wifi-connection.txt) | referência NM (IPv4 manual; sem PSK) |
| [systemd/wifi-powersave-off.service](./systemd/wifi-powersave-off.service) | `/etc/systemd/system/wifi-powersave-off.service` |

O `cmdline.txt` tem `PARTUUID=5c94f38d-02` **desta** SD. Não copie o arquivo inteiro para outro cartão; preserve o `PARTUUID` local e só acrescente `cgroup_enable=memory cgroup_memory=1`.

## HDMI

Full KMS (`dtoverlay=vc4-kms-v3d`) + `disable_fw_kms_setup=1`.  
`hdmi_group` / `hdmi_mode` / `framebuffer_*` **não têm efeito**.

TV **LG** em HDMI-A-2. Kanshi força **1920×1080@60** nos dois HDMI (o EDID preferia 4096×2160@30).

## Clocks

- `arm_freq=1800`, `over_voltage=4` (overclock; stock desta rev é 1500).
- `arm_boost=1` sozinho **não** sobe para 1,8 GHz na Rev 1.2.
- Governor `ondemand`, 600–1800 MHz.
- Cooler **2 fios nos pinos 4 (5 V) e 6 (GND)** — sempre ligado. Sem overlay `gpio-fan` (GPIO 14 / pino 8 livre).
- Backup do `config.txt` na placa: `/boot/firmware/config.txt.bak-before-oc`.

## Energia / Wi‑Fi

Fonte Xiaomi MDY-11-EQ 5 V/3 A USB-A. Sem undervoltage com 1080p.

Power save IEEE **desligado**: NM `wifi.powersave=2`, dispatcher no `up` do `wlan0`, oneshot `wifi-powersave-off.service`. Sem isso o SSH inbound some até a Pi transmitir.

## Docker

- `docker-ce` **29.7.2**, Compose plugin **v5.5.0**, `overlay2`, cgroup systemd, logs 10m×3, `userland-proxy=false`, BuildKit.
- Swarm **inativo** (certificado antigo expirado; agent Portainer removido).
- Cgroup memory **habilitado** no cmdline.

## Swap

`zram-tools`: lz4, **25% da RAM** (~949 MiB), prio 100.  
`dphys-swapfile` **disabled**; sem `/var/swap` no SD.

## Orca

Override de usuário com `Hidden=true`. Pacote permanece instalado; não inicia no login.

## Serviços desligados nesta placa (não versionados como unit files)

`ModemManager`, `cups`, `cups-browsed`, `triggerhappy`.
