# Ansible: LVM + Btrfs + NixOS setup

This repository contains Ansible playbooks to:

- create an LVM logical volume
- format it as `btrfs`
- create subvolumes: `boot`, `nix`, `persist`
- mount everything under `/mnt` using filesystem UUID
- generate a Xen `xl` DomU config file
- install NixOS from a GitHub-hosted flake
- provision post-install secrets on the target host

## Playbooks

All playbooks are located in the `ansible/` directory.

| Playbook | Description |
|---|---|
| `create-lv-btrfs.yml` | Provision the LV, Btrfs filesystem, subvolumes, and Xen config |
| `install-nixos-from-github-flake.yml` | Install NixOS onto the prepared `/mnt` target |
| `post-install.yml` | Copy secrets (Tailscale key, root password) onto the installed system |

## Requirements

Install required collections from `ansible/requirements.yml`:

```bash
ansible-galaxy collection install -r ansible/requirements.yml
```

## Secrets

The `post-install.yml` playbook reads secrets from `ansible/secrets.yml` (git-ignored).
Create it from the provided example and encrypt it with ansible-vault:

```bash
cp ansible/secrets.yml.example ansible/secrets.yml
# Fill in tskey and rootpassword, then encrypt:
ansible-vault encrypt ansible/secrets.yml
```

## Inventory

The inventory is located at `ansible/inventory.ini`.

| Group | Host | Description |
|---|---|---|
| `xen` | `10.10.10.175` | Dom0 — target for provisioning and NixOS install |
| `vms` | `nixos-vm.local` | DomU — target for post-install secrets |

## Usage

### 1. Provision LV, Btrfs and Xen config

Runs on the `xen` group (Dom0). Minimum required variable is `lv_name`.
`vg_name` is optional and defaults to `nvme_vg`.

```bash
ansible-playbook ansible/create-lv-btrfs.yml -i ansible/inventory.ini -l xen -e lv_name=data
```

Override volume group, LV size and Xen defaults:

```bash
ansible-playbook ansible/create-lv-btrfs.yml -i ansible/inventory.ini -l xen \
  -e lv_name=data \
  -e vg_name=my_vg \
  -e lv_size=20g \
  -e xen_bridge=xenbr0 \
  -e xen_mac=02:ab:cd:ef:12:34
```

### 2. Install NixOS from GitHub flake

Runs on the `xen` group (Dom0), after the LV is provisioned and `/mnt` is mounted.
Installs `nixdomu` from `github:dadatoa/turbo-octo-robot` by default.

```bash
ansible-playbook ansible/install-nixos-from-github-flake.yml -i ansible/inventory.ini -l xen
```

Override flake reference or host config:

```bash
ansible-playbook ansible/install-nixos-from-github-flake.yml -i ansible/inventory.ini -l xen \
  -e flake_ref=github:dadatoa/turbo-octo-robot \
  -e flake_host=nixdomu
```

### 3. Post-install secrets provisioning

Runs on the `vms` group (DomU), after NixOS is installed and booted.
Requires the encrypted `ansible/secrets.yml`.

```bash
ansible-playbook ansible/post-install.yml -i ansible/inventory.ini -l vms --ask-vault-pass
```
