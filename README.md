# RaspberryPi4

Configs da **Raspberry Pi 4 Model B Rev 1.2** (4 GB).

Duas gerações, isoladas. Não misture os arquivos.

| Pasta | Quando | O quê |
|---|---|---|
| [`configs/kali-2020/`](configs/kali-2020/) | 2020 | Kali ARM64 (arquivo histórico) |
| [`configs/raspios/`](configs/raspios/) | 2026 | **Esta placa** — Raspberry Pi OS, sem GUI no boot |

Acesso atual: `ssh raspberry` → **`192.168.1.100`**.

## Qual usar

- **Esta placa:** [`configs/raspios/`](configs/raspios/). Destinos no README dessa pasta.
  - **Não** copie o `cmdline.txt` inteiro para outro cartão (`PARTUUID` é desta SD).
- **Kali 2020:** [`configs/kali-2020/`](configs/kali-2020/). Não aplicar no RaspiOS — `kernel=kernel8l-alt.img` impede o boot.

Inventário do que **não vem na imagem padrão:** [configs/raspios/SOFTWARE.md](configs/raspios/SOFTWARE.md).

## Esta placa (2026-08-29)

- Kernel **6.12.96**, EEPROM 2026-05-17.
- Overclock **`arm_freq=1800`** + `over_voltage=4` (nesta rev o `arm_boost=1` sozinho **não** sobe para 1,8 GHz).
- Fonte Xiaomi **MDY-11-EQ** 5 V/3 A USB-A.
- HDMI LG **1920×1080@60** (kanshi); console na TV via **kmscon** + UbuntuMono Nerd Font Mono.
- IPv4 **estático 192.168.1.100/24**, Wi‑Fi power save **off**.
- Docker **29.7.2** + Compose **v5.5.0**; Swarm inativo.
- Swap **zram lz4 ~949 MiB**; cgroup memory no cmdline.
- Cooler 2 fios nos pinos **4 (5 V) e 6 (GND)**, sempre ligado. GPIO 14 livre.
- Boot **`multi-user.target`** (sem LightDM).

## Kali 2020 vs RaspiOS atual

| Ideia (2020) | Kali | Esta placa |
|---|---|---|
| 1080p60 | `hdmi_mode=82` | [kanshi](configs/raspios/kanshi/config) (KMS ignora `hdmi_mode`) |
| Kernel Kali | `kernel8l-alt.img` | **Não boota** |
| Cgroup Docker | sufixo cmdline | `cgroup_enable=memory cgroup_memory=1` |
| Docker | apt-key + Buster | `docker-ce` oficial |

## Referências

- [config.txt oficial](https://www.raspberrypi.com/documentation/computers/config_txt.html)
- Kali original: [configs/kali-2020/README.original.md](configs/kali-2020/README.original.md)
