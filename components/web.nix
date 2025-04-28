{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    yarn
    nodePackages.pnpm
    jetbrains.webstorm
  ];
}
