# NixOS Packet Server

## NixOps Cheatsheet

```bash
nixops delete --all --force
nixops scp -d deployment server --from _ nixops/.
nixops ssh -d deployment server
nixops info -d deployment
nixops ssh-for-each -d deployment "ls"
```

## Existing server setup

```bash
scp -r root@${TARGET_HOST}:/etc/nixos/ nixops/server/
```

Set the `shell.nix` commit hash to the relevant Nix version.

## Environment Secrets

Edit `nixops/env.nix`.

## Deployment

```bash
nix-shell
nixops create nixops/default.nix -d deployment
nixops deploy -d deployment --include server --dry-activate
nixops deploy -d deployment --include server
```

## Quassel

### Add users

`sudo -u quassel quassel --add-user`

### Configure SSL

```bash
sudo -u quassel mkdir -p /home/quassel/.config/quassel-irc.org
sudo -u quassel openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /home/quassel/.config/quassel-irc.org/quasselCert.pem -out /home/quassel/.config/quassel-irc.org/quasselCert.pem
```
