# Ansible: LVM + Btrfs + NixOS setup

This repository contains Ansible playbooks to:

- create an LVM logical volume
- format it as `btrfs`
- create subvolumes: `boot`, `nix`, `persist`
- mount everything under `/mnt` using filesystem UUID
- generate a Xen `xl` DomU config file
- install NixOS from a GitHub-hosted flake

## Playbooks

- `create-lv-btrfs.yml` — provision the LV, filesystem, subvolumes, and Xen config
- `install-nixos-from-github-flake.yml` — install NixOS onto the prepared `/mnt` target

## Requirements

Install required collections from `requirements.yml`:

```bash
ansible-galaxy collection install -r requirements.yml
```

## Usage

### 1. Provision LV, Btrfs and Xen config

Minimum required variable is `lv_name`. `vg_name` is optional and defaults to `nvme_vg`.

```bash
ansible-playbook create-lv-btrfs.yml -i inventory.ini -e lv_name=data
```

Override volume group, LV size and Xen defaults:

```bash
ansible-playbook create-lv-btrfs.yml -i inventory.ini \
  -e lv_name=data \
  -e vg_name=my_vg \
  -e lv_size=20g \
  -e xen_bridge=xenbr0 \
  -e xen_mac=02:ab:cd:ef:12:34
```

### 2. Install NixOS from GitHub flake

Run after the LV is provisioned and `/mnt` is mounted.
Installs `nixdomu` from `github:dadatoa/turbo-octo-robot` by default.

```bash
ansible-playbook install-nixos-from-github-flake.yml -i inventory.ini
```

Override flake reference or host config:

```bash
ansible-playbook install-nixos-from-github-flake.yml -i inventory.ini \
  -e flake_ref=github:dadatoa/turbo-octo-robot \
  -e flake_host=nixdomu
```
