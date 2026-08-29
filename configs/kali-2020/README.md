# Snapshot Kali Linux ARM64 (2020)

Configurações publicadas em março/abril de 2020 para **Kali Linux ARM64 (Debian Buster)** no Raspberry Pi 4.

O README original está em [README.original.md](./README.original.md).

## O que este snapshot faz

| Arquivo | Destino na Kali 2020 | Efeito |
|---|---|---|
| [boot/config.txt](./boot/config.txt) | `/boot/config.txt` | Força HDMI **1080p60** no firmware legado (`hdmi_group=2`, `hdmi_mode=82`) |
| [cmdline-additions.txt](./cmdline-additions.txt) | sufixo de `/boot/cmdline.txt` | Liga cgroup de memória para o Docker |

Não há overclock. O `arm_freq=800` comentado é o comentário padrão de Pi 1, não uma receita de Pi 4.

## Não use no Raspberry Pi OS desta placa

Copiar `boot/config.txt` para a Pi atual é incompatível:

- `hdmi_group` / `hdmi_mode` / `framebuffer_*` são **ignorados** com `dtoverlay=vc4-kms-v3d` (KMS cheio).
- `kernel=kernel8l-alt.img` aponta para o kernel da **Kali 2020**. No RaspiOS esse arquivo não existe → **não boota**.
- `dtoverlay=vc4-fkms-v3d` (comentado aqui) seria um *downgrade* e quebra o labwc/Wayland.
- O caminho de boot atual é `/boot/firmware/config.txt`, não `/boot/config.txt`.

O equivalente moderno do 1080p está em [`../raspios/`](../raspios/) (kanshi, não firmware HDMI).

O equivalente moderno do cgroup de memória está no cmdline do snapshot [raspios](../raspios/).

## Docker do README original

O guia usa `apt-key` e o repositório Debian **buster**. Não siga isso no RaspiOS: o Docker já está instalado na Pi atual (`docker-ce` oficial).
