# Rescue system

Setup ssh server on a live-bootable Alpine Linux Extended [\[1\]](https://alpinelinux.org/downloads/) usb stick by completing part 1 of Christian Hascheks's blog post [\[2\]](https://blog.haschek.at/2020/the-perfect-file-server.html). Having a rudimentary rescue system – similar to Hetzner rescue system [\[3\]](https://docs.hetzner.com/robot/dedicated-server/troubleshooting/hetzner-rescue-system/) – enables installation via takeover [\[4\]](https://kairos.io/docs/installation/takeover/).

My notes on the usb stick creation process can be found in this [\[6\]](https://bsky.app/profile/anttiharju.dev/post/3lrlhtumqd22m) Bluesky post thread (@anttiharju.dev).

## Ansible compatibility

- `apk add python3` # to be able to use ansible at all
- `apk add doas` # become method

### Passwordless become method

Just to simplify running playbooks with become (required for doing `apk add` for dependencies). One still cannot ssh in without a private key or a password.

```sh
mkdir -p /etc/doas.d
echo "permit nopass YOUR_USERNAME as root" > /etc/doas.d/passwordless.conf
chmod 600 /etc/doas.d/passwordless.conf
```

## How to connect

```sh
ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" HOSTNAME
```

## How to persist changes

```sh
su -
lbu commit -d
```

## References

1. https://alpinelinux.org/downloads/
2. https://blog.haschek.at/2020/the-perfect-file-server.html
3. https://docs.hetzner.com/robot/dedicated-server/troubleshooting/hetzner-rescue-system/
4. https://kairos.io/docs/installation/takeover/
5. https://bsky.app/profile/anttiharju.dev/post/3lrlhtumqd22m
