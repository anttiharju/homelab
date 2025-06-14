# homelab

## Thesis

To achieve operational excellence any solution relying on configuration at runtime as the main method (e.g. Ansible) is undesirable, because that leads to basic tasks such as delivering new PostgreSQL clusters to be slow, which leads to the time of the SRE engineers being spent on tasks that can be summarised as toil [\[1\]](https://sre.google/sre-book/eliminating-toil/).

## Technology stack

1. [Flatcar Container Linux](https://www.flatcar.org)
2. [Ansible](https://www.redhat.com/en/ansible-collaborative)

## References

1. https://sre.google/sre-book/eliminating-toil/
