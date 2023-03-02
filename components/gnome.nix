{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wmctrl
  ];

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>Return";
      command = "sh -c 'wmctrl -a alacritty || alacritty'";
      name = "alacritty nix";
    };
  };
}
