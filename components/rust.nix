{pkgs, ...}: {
  home.packages = with pkgs; [rustup gcc] ++ lib.optionals (!stdenv.isDarwin) [jetbrains.rust-rover];
}
