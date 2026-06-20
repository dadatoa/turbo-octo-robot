{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=25%" "mode=755" ]; # mode=755 so only root can write to those files
    };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/xvdb";
    fsType = "btrfs";
    mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
  };
  fileSystems."/persistent" = {
    neededForBoot = true;
    device = "/dev/xvdb";
    fsType = "btrfs";
    mountOptions = ["subvol=persistent" "compress=zstd" "noatime"];
  };
  fileSystems."/boot" = {
    neededForBoot = true;
    device = "/dev/xvdb";
    fsType = "btrfs";
    mountOptions = ["subvol=boot" "noatime"];
  };

  swapDevices = [{ 
    device = "/swap/swapfile"; 
    size = 4*1024; # Creates an 4GB swap file 
  }];
}

