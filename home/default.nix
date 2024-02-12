{ pkgs, ... }: {
  home = rec {
    username = "dom";
    homedirectory = "/home/${username}";
    stateversion = "23.11";
  };

  programs.neovim.enable = true;
  programs.vscode.enable = true;

  programs.wezterm = {
   enable = true;
   extraConfig = builtins.readFile ./wezterm.lua;
  };
}
