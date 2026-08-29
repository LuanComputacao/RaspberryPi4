# Snapshot Raspberry Pi OS Bookworm (2026)

Configuração **atual** da placa em `192.168.1.10` (hostname `raspberrypi`), capturada em 2026-08-29.

Hardware: **Raspberry Pi 4 Model B Rev 1.2**, 4 GB, revisão `c03112`.

## Arquivos e destino na placa

| Arquivo neste repo | Destino na Pi |
|---|---|
| [boot/firmware/config.txt](./boot/firmware/config.txt) | `/boot/firmware/config.txt` |
| [boot/firmware/cmdline.txt](./boot/firmware/cmdline.txt) | `/boot/firmware/cmdline.txt` |
| [kanshi/config](./kanshi/config) | `~/.config/kanshi/config` |

O `cmdline.txt` contém `PARTUUID=5c94f38d-02` desta SD. **Não copie o cmdline inteiro** para outro cartão.

## HDMI 1080p (substitui o `hdmi_mode=82` de 2020)

Bookworm usa **full KMS** (`dtoverlay=vc4-kms-v3d`) + `disable_fw_kms_setup=1`.  
`hdmi_group` / `hdmi_mode` / `framebuffer_*` **não têm efeito**.

A TV é uma **LG** no conector **HDMI-A-2**. O kanshi antigo apontava para HDMI-A-1, então o kernel escolhia o modo preferido do EDID: `4096x2160@30` (4K cinema).

Perfis atuais: `1920x1080@60` em HDMI-A-1 e HDMI-A-2.

Para aplicar na sessão (já aplicado nesta placa):

```bash
export XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-0
wlr-randr --output HDMI-A-2 --mode 1920x1080@60.000000
```

Para voltar ao 4K:

```bash
wlr-randr --output HDMI-A-2 --mode 4096x2160@30.000000
```

## Clocks

- Governor: `ondemand`, 600–**1500** MHz (4 núcleos no mesmo domínio).
- `arm_boost=1` **não** libera 1,8 GHz nesta Rev 1.2.
- Sem overclock. `throttled=0x0` com fonte Xiaomi MDY-11-EQ (5 V / 3 A, USB-A).

## Energia

A fonte anterior gerava `throttled=0x50005` (undervoltage + throttle) mesmo ociosa, em 4K. Com a Xiaomi e 1080p: `throttled=0x0`.

Pi 4 Rev 1.2 tem o bug dos pinos CC do USB-C; fonte USB-A + cabo 3 A evita o problema de PD.

## Estado extra da sessão (não está nos arquivos de boot)

Já aplicado na placa, mas não é `config.txt`:

- Orca / leitor de tela desligado (`screen-reader-enabled=false`).
- `ModemManager`, `cups`, `cups-browsed`, `triggerhappy` disabled.
- Docker continua enabled (agent Portainer parado há meses).
- EEPROM do bootloader ainda em **29 Apr 2021**; há update para **11 Feb 2025** (`sudo rpi-eeprom-update -a` + reboot). **Não aplicado.**

## Cgroup de memória (opcional, ainda válido)

O firmware injeta `cgroup_disable=memory`. Docker sobe, mas não aplica limite de RAM.

Se quiser limits, acrescente no **final** de `/boot/firmware/cmdline.txt` (mesmo fragmento de 2020):

```
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
```

Depois reboot. Não está ligado nesta captura.
