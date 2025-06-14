# homelab

## Thesis

To achieve operational excellence any solution relying on configuration at runtime as the main method (e.g. Ansible without anything else) is undesirable, because that leads to basic tasks such as delivering new PostgreSQL clusters to be slow, which leads to the time of the SREs being spent on tasks that can be summarised as toil [\[1\]](https://sre.google/sre-book/eliminating-toil/).

## Technology stack

1. [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html)
   - Supported by [Flox](https://flox.dev) to simplify Python setup.
2. [Flatcar Container Linux](https://www.flatcar.org)

## References

1. https://sre.google/sre-book/eliminating-toil/
