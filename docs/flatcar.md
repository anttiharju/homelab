# Flatcar Container Linux

Flatcar Container Linux [1] is being pursued to.

1. Simplify reprovisionability (vs. doing everything at runtime via Ansible)
2. It's not AWS-centric and supports arm64, unlike Bottlerocket
3. It's a CNCF project unlike Fedora CoreOS
   - Even though it is an incubating project, it's a direct fork of CoreOS from days of yore, even if Fedora's naming would suggest otherwise.

## Configuration

Read https://www.flatcar.org/docs/latest/provisioning/config-transpiler/

```sh
docker run --rm -i quay.io/coreos/butane:latest < flatcar/butane/n1.yml > flatcar/ignition/n1.json
```

## Provisioning

1. Boot server into rescue mode.
2. Run `ansible-playbook ansible/flatcar.yml --limit n2`
3. Server will automatically reboot into Flatcar Container Linux.
4. Unplug the rescue system usb drive to ensure subsequent reboots boot into Flatcar Container Linux.

## References

1. https://www.flatcar.org
