{ config, pkgs, ... }:

{
    home.username = "exolotyll";
    home.homeDirectory = "/home/exolotyll";

    home.packages = with pkgs; [
        
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}