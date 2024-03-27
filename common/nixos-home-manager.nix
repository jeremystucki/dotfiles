{ pkgs, ... }:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9keparNqpev2qrDO3cAiDzyTUsAAN9Mh+JLbOsdiZs";
in
{
  imports = map (x: ../components + x) [
    /android.nix
    /databases.nix
    /web.nix
  ];

  programs.git.extraConfig = {
    commit.gpgsign = true;
    user.signingkey = publicKey;
    "gpg \"ssh\"".program = "${pkgs._1password-gui}/bin/op-ssh-sign";

    gpg = {
      format = "ssh";
      ssh.allowedSignersFile = builtins.toFile "allowed_signers" ''
        dev@jeremystucki.ch ${publicKey}
        jeremy.stucki@valora.com ${publicKey}
        jeremy.stucki@ost.ch ${publicKey}
      '';
    };
  };
}
