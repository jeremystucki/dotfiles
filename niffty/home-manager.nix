{pkgs, ...}: let
  steam-bigpicture-tv-check = pkgs.writeShellScript "steam-bigpicture-tv-check" ''
    sleep 10

    # Count connected displays via DRM sysfs
    connected_count=0
    for status_file in /sys/class/drm/card*-*/status; do
      if [ -f "$status_file" ] && [ "$(cat "$status_file")" = "connected" ]; then
        connected_count=$((connected_count + 1))
      fi
    done

    # Check for 4K resolution using GNOME's DBus API
    has_4k=$(${pkgs.glib}/bin/gdbus call --session \
      --dest org.gnome.Mutter.DisplayConfig \
      --object-path /org/gnome/Mutter/DisplayConfig \
      --method org.gnome.Mutter.DisplayConfig.GetCurrentState 2>/dev/null \
      | grep -E "3840x2160|4096x2160" || true)

    if [ "$connected_count" -eq 1 ] && [ -n "$has_4k" ]; then
      steam -bigpicture &
    fi
  '';
in {
  home.packages = [
    pkgs.gnomeExtensions.no-overview
  ];

  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        pkgs.gnomeExtensions.no-overview.extensionUuid
      ];
    };
  };

  xdg.configFile."autostart/steam-bigpicture-tv.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Steam Big Picture TV
    Exec=${steam-bigpicture-tv-check}
    X-GNOME-Autostart-enabled=true
  '';
}
