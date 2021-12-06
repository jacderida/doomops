# doomops

Simple automated configuration for running Odamex servers on different cloud providers. So far, only AWS is supported.

## Setup

Running the automation will require installations of the following:

* GNU Make for simple coordination.
* [Terraform](https://www.terraform.io/) for infrastructure creation.
* [Ansible](https://docs.ansible.com/ansible-core/devel/index.html) for infrastructure provisioning. I always prefer to run Ansible from a virtualenv.

Since Ansible is used, the process needs to be run from either a Linux machine, or WSL on Windows.

## AWS

The AWS setup just uses a single VM in a public subnet in its own VPC, with UDP open on 10666. The machine type isn't optimised yet for what's required to run an Odamex server. This will follow shortly.

To build the server on AWS, just run `make odamex-server-aws`.
