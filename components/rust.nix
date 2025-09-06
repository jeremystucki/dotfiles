{pkgs, ...}: {
  home.packages = with pkgs; [rustup] ++ lib.optionals (!stdenv.isDarwin) [jetbrains.rust-rover];
}
