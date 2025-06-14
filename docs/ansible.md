# Ansible

The setup here is very basic and is only meant for:

- Initialisation
- Updating config

## SSH config

Managed outside the repository, the setup here is small so for now this is how it is.

## Commands

You must have the ansible environment activated via `flox activate` before any commands.

```sh
ansible -m ping -i ansible/inventory.ini 'n1:&rescue'
```
