# Ansible: LVM + Btrfs setup

This repository includes an Ansible playbook to:

- create an LVM logical volume
- format it as `btrfs`
- create subvolumes: `boot`, `nix`, `persist`
- mount everything under `/mnt` using filesystem UUID

## Playbook

- `create-lv-btrfs.yml`

## Requirements

Install required collections from `requirements.yml`:

```bash
ansible-galaxy collection install -r requirements.yml
```

## Usage

Minimum required variable is `lv_name`.
`vg_name` is optional and defaults to `nvme_vg`.

```bash
ansible-playbook create-lv-btrfs.yml -i inventory.ini -e lv_name=data
```

Override volume group and LV size if needed:

```bash
ansible-playbook create-lv-btrfs.yml -i inventory.ini -e lv_name=data -e vg_name=my_vg -e lv_size=20g
```
