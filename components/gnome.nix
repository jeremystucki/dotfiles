{ pkgs, hostConfiguration, ... }:

{
  home.packages = with pkgs; [ wmctrl ];

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/firefox/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/telegram/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty" = {
      binding = "<Super>Return";
      command = "sh -c 'wmctrl -xa alacritty || alacritty'";
      name = "alacritty nix";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/firefox" = {
      binding = "<Super>F";
      command = "sh -c 'wmctrl -xa firefox || firefox'";
      name = "firefox nix";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus" = {
      binding = "<Super>E";
      command = "sh -c 'wmctrl -xa nautilus || nautilus /home/${hostConfiguration.username}'";
      name = "nautilus nix";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/telegram" = {
      binding = "<Super>T";
      command = "sh -c 'wmctrl -xa telegram-desktop || telegram-desktop'";
      name = "telegram nix";
    };
  };
}
