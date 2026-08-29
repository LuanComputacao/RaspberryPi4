# RaspberryPi4

Notas e configs da **Raspberry Pi 4 Model B Rev 1.2** (4 GB).

Há **duas gerações**, isoladas. Não misture os arquivos.

| Pasta | Quando | Sistema | HDMI |
|---|---|---|---|
| [`configs/kali-2020/`](configs/kali-2020/) | mar/abr 2020 | Kali Linux ARM64 (Buster) | firmware legado (`hdmi_mode=82`) |
| [`configs/bookworm/`](configs/bookworm/) | ago 2026 | Raspberry Pi OS Bookworm 64-bit | KMS + kanshi 1080p60 |

A Pi atual (`ssh raspberry` → **`192.168.1.100`**) roda o snapshot **bookworm**.

## Qual usar

- **Bookworm (esta placa):** [`configs/bookworm/`](configs/bookworm/). Destinos estão no README dessa pasta.
  - **Não** copie o `cmdline.txt` inteiro para outro cartão (`PARTUUID` é desta SD).
- **Kali 2020 (arquivo histórico):** [`configs/kali-2020/`](configs/kali-2020/). Não aplicar em Bookworm — o `kernel=kernel8l-alt.img` impede o boot.

## Placa atual (2026-08-29)

- Raspberry Pi 4 Model B **Rev 1.2** (`c03112`), 4 GB, kernel **6.12.96**.
- Overclock **`arm_freq=1800`** + `over_voltage=4` (nesta revisão o `arm_boost=1` **não** libera 1,8 GHz sozinho).
- Fonte Xiaomi **MDY-11-EQ** 5 V/3 A (USB-A). Sem undervoltage; sob carga pesada pode aparecer limite térmico suave (`0x80000`).
- HDMI: LG em **HDMI-A-2**, **1920×1080@60** (kanshi).
- IPv4 **estático 192.168.1.100/24**, Wi‑Fi power save **off**.
- Docker **29.7.2** + Compose **v5.5.0**; Swarm inativo.
- Swap: **zram lz4 ~949 MiB**; sem arquivo no SD.
- Cgroup **memory** ligado no cmdline (Docker consegue limitar RAM).
- EEPROM bootloader: **2026-05-17**.
- Cooler 2 fios nos pinos **4 (5 V) e 6 (GND)**, sempre ligado. GPIO 14 livre.

## Compatibilidade Kali 2020 vs Bookworm

| Ideia (2020) | Na Kali | No Bookworm desta Pi |
|---|---|---|
| Forçar 1080p60 | `hdmi_group=2` + `hdmi_mode=82` | Ignorado no KMS. Usar [kanshi](configs/bookworm/kanshi/config) |
| Kernel 64-bit Kali | `kernel=kernel8l-alt.img` | **Não boota** |
| Fake KMS | `vc4-fkms-v3d` | Full KMS `vc4-kms-v3d` |
| Cgroup p/ Docker | sufixo no cmdline | Aplicado: `cgroup_enable=memory cgroup_memory=1` |
| Docker | `apt-key` + repo Buster | `docker-ce` oficial Bookworm arm64 |

## Referências

- [config.txt oficial](https://www.raspberrypi.com/documentation/computers/config_txt.html)
- Snapshot Kali original: [configs/kali-2020/README.original.md](configs/kali-2020/README.original.md)
