{ config, pkgs, ... }:

{
  home.username = "niki";
  home.homeDirectory = "/home/niki";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.hello
    pkgs.source-code-pro
    pkgs.kitty-themes
    pkgs.gimp
    pkgs.nasm
    pkgs.neofetch
    pkgs.ranger
    pkgs.clang
    pkgs.clang-tools
    pkgs.fzf
  ];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$PATH:clangd";
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Source Code Pro";
      size = 15;
      package = pkgs.source-code-pro;
    };
    theme = "Bluloco Dark";

    shellIntegration = {
      enableZshIntegration = true;
    };

    extraConfig = "
      confirm_os_window_close 0
    ";
  };

  programs.tofi = {
    enable = true;

    settings = {
      # https://github.com/philj56/tofi/blob/master/themes/dmenu
      
      anchor = "center";
      width = "100%";
      height = 30;
      horizontal = true;
      font-size = 14;
      prompt-text = " run: ";
      font = "monospace";
      outline-width = 0;
      border-width = 0;
      background-color = "#000000";
      min-input-width = 120;
      result-spacing = 15;
      padding-top = 0;
      padding-bottom = 0;
      padding-left = 0;
      padding-right = 0;
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };


  programs.home-manager.enable = true;
}
