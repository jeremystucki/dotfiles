{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    yarn
    pnpm
    jetbrains.webstorm
  ];
}
