# RaspberryPi4

Notas e configs da **Raspberry Pi 4 Model B Rev 1.2** (4 GB).

Há **duas gerações**, isoladas. Não misture os arquivos.

| Pasta | Quando | Sistema | HDMI |
|---|---|---|---|
| [`configs/kali-2020/`](configs/kali-2020/) | mar/abr 2020 | Kali Linux ARM64 (Buster) | firmware legado (`hdmi_mode=82`) |
| [`configs/bookworm/`](configs/bookworm/) | ago 2026 | Raspberry Pi OS Bookworm 64-bit | KMS + kanshi 1080p60 |

A Pi atual (`raspberry` / `192.168.1.10`) roda o snapshot **bookworm**.

## Qual usar

- **Bookworm (esta placa):** copie só o que está em `configs/bookworm/`. Destinos:
  - `boot/firmware/config.txt` → `/boot/firmware/config.txt`
  - `kanshi/config` → `~/.config/kanshi/config`
  - **não** copie o `cmdline.txt` inteiro para outro cartão (`PARTUUID` é desta SD).
- **Kali 2020 (arquivo histórico):** `configs/kali-2020/`. Não aplicar em Bookworm — o `kernel=kernel8l-alt.img` impede o boot.

## Compatibilidade resumida

O `config.txt` de 2020 **não reproduz** o efeito de 2020 nesta Bookworm:

| Ideia (2020) | Na Kali | No Bookworm desta Pi |
|---|---|---|
| Forçar 1080p60 | `hdmi_group=2` + `hdmi_mode=82` | **Ignorado** no KMS. Usar kanshi |
| Framebuffer 1920×1080 | `framebuffer_*` | Ignorado |
| Kernel 64-bit Kali | `kernel=kernel8l-alt.img` | Arquivo inexistente → **não boota** |
| Fake KMS | `vc4-fkms-v3d` (comentado) | Padrão é **full KMS** `vc4-kms-v3d` |
| Áudio / 64-bit | `dtparam=audio=on`, `arm_64bit=1` | Já presente, redundante |
| Cgroup p/ Docker | sufixo no cmdline | **Ainda válido**, opcional; não está ligado |
| Instalar Docker | `apt-key` + repo **buster** | Docker já instalado; não seguir o guia antigo |

Detalhe por arquivo: [configs/kali-2020/README.md](configs/kali-2020/README.md) e [configs/bookworm/README.md](configs/bookworm/README.md).

## Placa atual (ago 2026)

- Raspberry Pi 4 Model B **Rev 1.2** — `arm_boost=1` **não** chega a 1,8 GHz (teto 1,5 GHz, governor `ondemand`).
- Fonte: Xiaomi **MDY-11-EQ** 5 V/3 A (USB-A). A anterior gerava undervoltage (`throttled=0x50005`) com a TV em 4K.
- HDMI: TV LG em **HDMI-A-2**, **1920×1080@60** via kanshi (o EDID preferia 4096×2160@30).
- EEPROM do bootloader ainda em 2021; update 2025 **não** aplicado.
- Sem câmera (`camera_auto_detect=0`). Cooler GPIO 14 @ 80 °C.

## Referências

- [config.txt oficial](https://www.raspberrypi.com/documentation/computers/config_txt.html) (`rptl.io/configtxt`)
- Snapshot Kali original: [configs/kali-2020/README.original.md](configs/kali-2020/README.original.md)
