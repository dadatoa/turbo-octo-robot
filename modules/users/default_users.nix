{ config, pkgs, ... }:
{
  users.users.operateur = {
    initialPassword = "*perateur"; ## dont lock myself out at first boot
    isNormalUser = true;
    uid = 1000;
    description = "main user";
    extraGroups = [
      "video"
      "wheel"
    ];
    # packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBA52LLKZPhszwrzrqOwLJ2a2spNzjAn/ls6krE9SM/i dadatoa@dadabook"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHnWrIExo7hWe04wTUUEn6smnx/LRfNtPtatR+NgQlfz SpaceK@dadabook"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF36sv0vHnOUCx8uMWCkwLwpQoBgWP0NzYRhd6+6vr8t deploy_app_to_server_github_actions"

    ];
  };
  users.users.root = {
    initialPassword = "*perateur"; ## dont lock myself out at first boot
  };
  security.sudo.wheelNeedsPassword = false;
}
