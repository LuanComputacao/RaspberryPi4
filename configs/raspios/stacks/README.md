# Kit Compose (esta placa)

Caddy na frente. Dozzle, Beszel, WUD, Dockge atrás.

Caddy escuta **80** e **3000** em todas as interfaces da placa (LAN `192.168.1.100` e, depois, Tailscale). Os backends **não** publicam porta na LAN — só o Caddy. Beszel hub extra em `127.0.0.1:8090` (agent).

| Peça | Função | URL |
|---|---|---|
| **Caddy** | proxy | `:80` e `:3000` |
| **Dockge** | UI dos `compose.yaml` | `/` |
| **Dozzle** | logs | `/dozzle/` |
| **Beszel** | CPU / RAM / disco | `/beszel/` |
| **WUD** | avisa update; **não aplica** | `:3000` (sem subpath) |
| **Tailscale** | fora da casa, no **host** | `tailscale up` |

Live: `/opt/stacks/`. Rede Docker `edge`.

## Por que assim

- **Caddy**, não Traefik: poucos serviços, Caddyfile no git, menos RAM.
- **Beszel**, não Glances: hub+agent, ~40–90 MiB.
- **WUD**, não Watchtower: cron a cada 6 h, sem trigger `docker`/`dockercompose`.
- **Tailscale no host**, não sidecar: um nó na tailnet.

WUD e Dockge **não** suportam base path. Dockge em `/`, WUD na porta 3000.

## Destino na placa

| Neste repo | Na placa |
|---|---|
| `caddy/` `dozzle/` `beszel/` `wud/` `dockge/` | `/opt/stacks/<nome>/` |
| `.env.example` | `/opt/stacks/.env` (não versionar) |
| `up.sh` | `/opt/stacks/up.sh` |

```bash
/opt/stacks/up.sh
```

## Acesso de outras máquinas

IP fixo **192.168.1.100**. Sem port-forward no roteador.

Na LAN (qualquer PC/celular na mesma Wi‑Fi):

| URL | Serviço |
|---|---|
| http://192.168.1.100/kit/ | índice |
| http://192.168.1.100/ | Dockge |
| http://192.168.1.100/dozzle/ | logs |
| http://192.168.1.100/beszel/ | métricas |
| http://192.168.1.100:3000/ | WUD |

Se o mDNS estiver no ar: `http://raspberrypi.local/…`.

Fora de casa, no host da Pi:

```bash
sudo tailscale up
```

Outras máquinas com Tailscale usam o IP `100.x` da placa nas mesmas portas **80** e **3000**. HTTPS opcional:

```bash
sudo tailscale serve --bg --yes 80
sudo tailscale serve --bg --yes --https=8443 3000
```

## Primeiro uso

1. **Dockge** — cria a senha no primeiro acesso. Stacks = pastas em `/opt/stacks`.
2. **Dozzle** — usuário `luancomputacao`. Senha em `/opt/stacks/.credentials` (600). Hash do WUD em `/opt/stacks/wud/admin.hash`.
3. **Beszel** — cria o admin no browser. Settings → Add system. Host/IP: `/beszel_socket/beszel.sock`. Copia KEY e TOKEN para `/opt/stacks/.env` (`BESZEL_KEY`, `BESZEL_TOKEN`). Depois:

   ```bash
   docker compose --env-file /opt/stacks/.env \
     -f /opt/stacks/beszel/compose.yaml --profile agent up -d
   ```

4. **WUD** — basic auth, mesmas credenciais do `.credentials`. Só lista updates. Aplicar = Dockge / `docker compose pull && up`.

## RAM (limites no compose)

Caddy 64m, Dozzle 96m, Beszel 128m, agent 64m, WUD 384m, Dockge 256m. Teto ~1 GiB; ocioso bem menos.

## O que não fazer

- Abrir 80/3000 no roteador para a internet.
- Ligar trigger de update automático no WUD.
- Ligar `DOZZLE_ENABLE_SHELL` / `ACTIONS` sem socket-proxy.
- Copiar `/opt/stacks/.env` ou `.credentials` para o git.
- Publicar Beszel `:8090` na LAN (fica em `127.0.0.1`).
