# Senhas do kit (esta placa)

As senhas **não** entram no git. Na Pi elas estão em `/opt/stacks/`, modo `600`.

Ler o que o kit gerou:

```bash
ssh raspberry
cat /opt/stacks/.credentials
```

Esse arquivo vale para **Dozzle** e **WUD**. Dockge e Beszel são contas que você criou no browser.

## Onde está cada uma

| Serviço | URL | Usuário | Como ver / lembrar |
|---|---|---|---|
| **Caddy** | http://192.168.1.100/kit/ | — | Sem login; só encaminha. |
| **Dozzle** | http://192.168.1.100/dozzle/ | `luancomputacao` | `cat /opt/stacks/.credentials` (campos `usuario` e `senha`). Hash bcrypt em `/opt/stacks/dozzle/data/users.yml` — o hash **não** é a senha. |
| **WUD** | http://192.168.1.100:3000/ | o mesmo do Dozzle | O mesmo `.credentials`. Hash apr1 em `/opt/stacks/wud/admin.hash`. |
| **Dockge** | http://192.168.1.100/ | o que você cadastrou no 1º acesso | **Não** está no `.credentials`. Só você tem. Fica hasheada em `/opt/stacks/dockge/dockge-data/dockge.db`. |
| **Beszel** | http://192.168.1.100/beszel/ | o e-mail do 1º acesso | **Não** está no `.credentials`. Só você tem. |

SSH da placa: usuário `luancomputacao`, chave em `authorized_keys` (Host `raspberry` no notebook).

## Trocar a senha do Dozzle / WUD

Gera outra, regrava o `.credentials`, o `users.yml` e o hash do WUD, recria os dois containers:

```bash
PASS='nova-senha-aqui'
printf 'usuario=luancomputacao\nsenha=%s\nuso=Dozzle e WUD (basic auth)\n' "$PASS" > /opt/stacks/.credentials
chmod 600 /opt/stacks/.credentials

docker run --rm amir20/dozzle:latest generate luancomputacao --password "$PASS" --name Luan \
  > /opt/stacks/dozzle/data/users.yml
chmod 600 /opt/stacks/dozzle/data/users.yml
docker compose -f /opt/stacks/dozzle/compose.yaml --project-directory /opt/stacks/dozzle up -d --force-recreate

openssl passwd -apr1 "$PASS" | sudo tee /opt/stacks/wud/admin.hash >/dev/null
chmod 600 /opt/stacks/wud/admin.hash
docker compose -f /opt/stacks/wud/compose.yaml --project-directory /opt/stacks/wud up -d --force-recreate
```

## Esqueci o Dockge

Não há “esqueci minha senha”. Recria o admin (apaga só o banco do Dockge; os compose em `/opt/stacks` ficam):

```bash
docker compose -f /opt/stacks/dockge/compose.yaml --project-directory /opt/stacks/dockge stop
sudo rm -f /opt/stacks/dockge/dockge-data/dockge.db /opt/stacks/dockge/dockge-data/dockge.db-*
docker compose -f /opt/stacks/dockge/compose.yaml --project-directory /opt/stacks/dockge up -d
```

Abre http://192.168.1.100/ e cadastra de novo.

## Esqueci o Beszel

SMTP desligado; o hub não manda e-mail de reset. A conta é a do primeiro acesso no browser.

Opção destrutiva (perde histórico de métricas, o agent reconecta com o TOKEN do `.env`):

```bash
docker compose --env-file /opt/stacks/.env \
  -f /opt/stacks/beszel/compose.yaml --project-directory /opt/stacks/beszel stop
sudo rm -rf /opt/stacks/beszel/beszel_data
docker compose --env-file /opt/stacks/.env \
  -f /opt/stacks/beszel/compose.yaml --project-directory /opt/stacks/beszel up -d
```

Abre http://192.168.1.100/beszel/ e cria o admin de novo. Se o sistema `raspberry` não voltar, o TOKEN/KEY em `/opt/stacks/.env` ainda valem para o agent.

## O que nunca copiar para o git

`/opt/stacks/.credentials`, `/opt/stacks/.env`, `/opt/stacks/wud/admin.hash`, `/opt/stacks/dozzle/data/users.yml`, bancos em `*-data/`.
