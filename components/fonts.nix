{pkgs, ...}: {
  home.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    input-fonts
  ];
}
