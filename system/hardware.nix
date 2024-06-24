{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
        initrd = {
            availableKernelModules = [
                "nvme"
                "xhci_pci"
                "usbhid"
                "sd_mod"
                "rtsx_pci_sdmmc"
            ];

            kernelModules = [
                # add if needed
            ];
        };

        kernelModules = [
            "kvm_amd"
        ];

        extraModulePackages = [
            # add if needed
        ];
    };

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/b2237e94-7050-4977-8e8d-12ae3aad34e8";
        fsType = "btrfs";
        options = [
            "subvol=@"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-uuid/b2237e94-7050-4977-8e8d-12ae3aad34e8";
        fsType = "btrfs";
        options = [
            "subvol=@home"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/b2237e94-7050-4977-8e8d-12ae3aad34e8";
        fsType = "btrfs";
        options = [
            "subvol=@nix"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/steam" = {
        device = "/dev/disk/by-uuid/b2237e94-7050-4977-8e8d-12ae3aad34e8";
        fsType = "btrfs";
        options = [
            "subvol=@steam"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/447B-8B1E";
        fsType = "vfat";
        options = [
            "fmask=0077"
            "dmask=0077"
        ];
    };

    swapDevices = [
        { device = "/dev/disk/by-uuid/c161bb62-7ffe-42dd-ad32-78c54e339096"; }
    ];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}