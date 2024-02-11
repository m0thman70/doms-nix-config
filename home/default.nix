{ pkgs, ... }: {
  home = rec {
    username = "dom";
    homedirectory = "/home/${username}";
    stateversion = "23.11";
  };
}
