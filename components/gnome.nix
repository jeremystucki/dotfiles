{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wmctrl
  ];

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "sh -c 'wmctrl -xa alacritty || alacritty'";
      name = "alacritty nix";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>E";
      command = "sh -c 'wmctrl -xa nautilus || nautilus /home/jeremy'";
      name = "nautilus nix";
    };
  };
}
