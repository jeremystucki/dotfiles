{ pkgs, ... }: {
  home.packages =
    with pkgs;
    [
      rustup
      gcc
    ]
    ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [ jetbrains.rust-rover ];
}
