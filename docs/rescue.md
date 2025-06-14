# Rescue system

Setup ssh server on a live-bootable Alpine Linux Extended [\[1\]](https://alpinelinux.org/downloads/) usb stick by completing part 1 of Christian Hascheks's blog post [\[2\]](https://blog.haschek.at/2020/the-perfect-file-server.html). Having a rudimentary rescue system – similar to Hetzner rescue system [\[3\]](https://docs.hetzner.com/robot/dedicated-server/troubleshooting/hetzner-rescue-system/) – enables installation via takeover [\[4\]](https://kairos.io/docs/installation/takeover/) which became a pressing issue when setting up Flatcar Container Linux [\[5\]](https://www.flatcar.org).

My notes on the usb stick creation process can be found in this [\[6\]](https://bsky.app/profile/anttiharju.dev/post/3lrlhtumqd22m) Bluesky post thread (@anttiharju.dev).

To simplify (and better adhere to IaC) also install python3 so that the takeovers can be done via Ansible.

## References

1. https://alpinelinux.org/downloads/
2. https://blog.haschek.at/2020/the-perfect-file-server.html
3. https://docs.hetzner.com/robot/dedicated-server/troubleshooting/hetzner-rescue-system/
4. https://kairos.io/docs/installation/takeover/
5. https://www.flatcar.org
6. https://bsky.app/profile/anttiharju.dev/post/3lrlhtumqd22m
