# Software extra (não vem no RaspiOS padrão)

Inventário de **2026-08-29**. Imagem base: **Raspberry Pi OS** 64-bit, pi-gen **stage4** (desktop + apps recomendados), 2024-11-19.

O desktop (labwc, Chromium, VLC, CUPS…) **é da imagem**; só não sobe porque o boot é `multi-user.target`.

## Repositórios apt além do padrão

| Arquivo | Origem |
|---|---|
| `/etc/apt/sources.list.d/docker.list` | `https://download.docker.com/linux/debian` (stable) |
| `/etc/apt/sources.list.d/azlux.list` | `http://packages.azlux.fr/debian` |

Debian + `archive.raspberrypi.com` são o padrão. Não há NodeSource nem vscode.list da Microsoft.

## Apt de terceiro

| Pacote | Versão | Origem | Função |
|---|---|---|---|
| `docker-ce` | 29.7.2 | Docker | Engine |
| `docker-ce-cli` | 29.7.2 | Docker | CLI |
| `docker-ce-rootless-extras` | 29.7.2 | Docker | Rootless |
| `docker-compose-plugin` | 5.5.0 | Docker | `docker compose` |
| `docker-buildx-plugin` | 0.36.1 | Docker | Buildx |
| `containerd.io` | 2.3.4 | Docker | Runtime |
| `docker-ctop` | 0.7.7 | Azlux | TUI de containers |

## Apt extra (repos oficiais, não está no stage4)

| Pacote | Função |
|---|---|
| `code` 1.135 | VS Code (repo da Raspberry Pi Foundation) |
| `zram-tools` | Swap lz4 em RAM |
| `kmscon` | Console HDMI com TTF |
| `zsh` | Shell (padrão da imagem é bash) |
| `vim` / `vim-nox` | Vim completo (imagem traz `vim-tiny`) |
| `tmux`, `bat`, `lsd`, `zoxide`, `silversearcher-ag` | CLI |
| `terminator` | Terminal extra (`lxterminal` é o padrão gráfico) |
| `git-lfs` | Git LFS |
| `cmake`, `llvm-14-dev`, `checkinstall` + libs `-dev` | Build / Python via asdf |
| `orca` + `speech-dispatcher` | Leitor de tela (instalado depois; **desligado** no autostart) |

Provavelmente **já vinham** no stage4: `git`, `curl`, `htop`, `build-essential`, `python3-pip`/`venv`, Chromium, Firefox, VLC, labwc, lightdm, `rpi-connect`, kernel headers.

## Home / não-apt

| Nome | Onde | Função |
|---|---|---|
| Oh My Zsh + Powerlevel10k | `~/.oh-my-zsh`, `~/.p10k.zsh` | Prompt Nerd Font |
| zsh-autosuggestions, syntax-highlighting, zsh-256color | plugins OMZ | Qualidade de vida no zsh |
| UbuntuMono Nerd Font (TTF) | `~/.fonts/` e `/usr/share/fonts/truetype/ubuntumono-nerd/` | Ícones p10k / kmscon |
| nvm v0.40.2 + Node 18.20.7 / 22.14.0 / 23.9.0 | `~/.nvm` (~633 MiB) | JS; Yarn 1.22 |
| asdf v0.8.1 + Python 3.9.7 / 3.11.9 | `~/.asdf` (~533 MiB) | Python extra; bpytop no 3.11 |
| fzf 0.60.3 | `~/.fzf` | Fuzzy finder (sourced no bash, não no zsh) |
| Vim + Vundle (YCM, NERDTree, ale…) | `~/.vim` (~500 MiB) | Editor |
| VS Code Server + GitLens/Docker | `~/.vscode-server` (~227 MiB) | Remote |

Não há: snap, flatpak com apps, rustup, Go, pyenv, pipx.

## Serviços extras habilitados

| Unit | Notas |
|---|---|
| `docker.service` / `docker.socket` / `containerd` | Docker CE |
| `zramswap.service` | `dphys-swapfile` está disabled |
| `wifi-powersave-off.service` | Unidade nossa |
| `kmsconvt@tty1` | Console HDMI + autologin; substitui getty no tty1 |
| `wayvnc` / `wayvnc-control` | Ligados, mas **sem compositor** no boot CLI |
| `rpi-connect` (user) | Shell ok; tela falha sem Wayland |

Boot: **`multi-user.target`** (sem GUI). Autologin `luancomputacao` no tty1 via kmscon.

## Lixo / leftover (pode apagar)

- Docker: `nfe-worker:dev` **amd64** (`192.168.0.101:5000`), 5 imagens dangling arm64, `portainer/agent` untagged, volume `nfe-dev_minio_data_dev`
- `~/asdf` binário **amd64** (não roda nesta Pi) + `asdf-v0.16.5-linux-amd64.tar.gz`
- `~/get-docker.sh`
- `~/.electron/electron-v2.0.18-linux-arm64.zip`

## Voltar à GUI (se precisar)

```bash
sudo systemctl set-default graphical.target
sudo systemctl enable lightdm
sudo reboot
```
