{ config, lib, pkgs, ... }:

{
    # imports
    imports = [
        ./hardware.nix
    ];

    # bootloader
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_zen;
    };

    # networking
    networking = {
        hostName = "victus";
        networkmanager.enable = true;
    };

    # time zone
    time.timeZone = "America/New_York";

    # virtualization
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # users
    users.users = {
        exolotyll = {
            isNormalUser = true;
            extraGroups = [
                "wheel"
                "networkmanager"
                "libvirtd"
            ];
            packages = with pkgs; [
                firefox
                kate
            ];
        };
    };

    # desktop
    services = {
        xserver = {
            enable = true;
            videoDrivers = [
                "nvidia"
            ];
        };

        displayManager.sddm.enable = true;
        desktopManager.plasma6.enable = true;
    };

    # audio
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };

    # video
    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };

        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            
            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };

                amdgpuBusId = "PCI:6:0:0";
                nvidiaBusId = "PCI:1:0:0";
            };

            package = config.boot.kernelPackages.nvidiaPackages.production;
        };
    };

    # environment
    environment = {
        systemPackages = with pkgs; [
            wget
            neofetch
        ];
    };

    # nix
    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };

    nix = {
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05";
}