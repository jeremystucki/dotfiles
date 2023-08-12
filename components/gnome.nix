{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wmctrl
  ];

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty" = {
      binding = "<Super>Return";
      command = "sh -c 'wmctrl -xa alacritty || alacritty'";
      name = "alacritty nix";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus" = {
      binding = "<Super>E";
      command = "sh -c 'wmctrl -xa nautilus || nautilus /home/jeremy'";
      name = "nautilus nix";
    };
  };
}
