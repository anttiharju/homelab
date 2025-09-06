# Ansible

The setup here is very basic and is only meant for:

- Initialisation
- Updating config

## SSH config

Import at the bottom of `~/.ssh/config`:

```
Host *
  IdentityFile ~/.ssh/keys/homelab-auth
  UserKnownHostsFile ~/anttiharju/homelab/ansible/files/ssh/known_hosts
Include ~/anttiharju/homelab/ansible/files/ssh/config
```

## Commands

You must have the ansible environment activated via `flox activate` before any commands.

```sh
ansible -m ping -i ansible/inventory.ini homelab
```
