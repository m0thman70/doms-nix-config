{ pkgs, ... }: {
  home = rec {
    username = "dom";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.neovim.enable = true;
  programs.vscode.enable = true;
  programs.rofi.enable = true;
  programs.git.enable = true;

  programs.wezterm = {
   enable = true;
   extraConfig = builtins.readFile ./wezterm.lua;
  };
}
