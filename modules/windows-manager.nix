{
  ## فعال‌سازی session
  xsession.enable = true;

  ## i3 فقط enable — هیچ extraPackages اینجا وجود ندارد
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = null;
  };

  ## تمام پکیج‌ها اینجا
  home.packages = with pkgs; [
    i3lock
    i3status
    i3status-rust
    rofi
    dex
    xss-lock
    networkmanagerapplet
    brightnessctl
    flameshot
    dunst
    blueman
    pasystray
    alacritty
  ];
  

  ## فایل کانفیگ i3 دقیقاً همان چیزی که دادی
  xdg.configFile."i3/config".text = ''
    set $mod Mod4
    font pango:monospace 8

    exec --no-startup-id dex --autostart --environment i3
    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
    exec --no-startup-id ${pkgs.networkmanagerapplet}/bin/nm-applet

    set $refresh_i3status killall -SIGUSR1 i3status

    bindsym XF86MonBrightnessUp exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%
    bindsym XF86MonBrightnessDown exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-
    bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
    bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
    bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

    floating_modifier $mod

    bindsym $mod+Return exec alacritty
    bindsym $mod+Shift+q kill

    bindsym $mod+d exec rofi -show run
    bindsym $mod+n exec rofi -show

    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    bindsym $mod+o split h
    bindsym $mod+v split v
    bindsym $mod+f fullscreen toggle

    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    bindsym $mod+Shift+z floating toggle
    bindsym $mod+z focus mode_toggle
    bindsym $mod+a focus parent

    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6" set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"

    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10

    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5

    bindsym $mod+Shift+c reload
    bindsym $mod+Shift+r restart
    bindsym $mod+Shift+e exec "i3-msg exit"

    mode "resize" {
      bindsym h resize shrink width 10 px or 10 ppt
      bindsym j resize grow height 10 px or 10 ppt
      bindsym k resize shrink height 10 px or 10 ppt
      bindsym l resize grow width 10 px or 10 ppt
      bindsym Return mode "default"
      bindsym Escape mode "default"
      bindsym $mod+r mode "default"
    }
    bindsym $mod+r mode "resize"

    bar {
      mode hide
      status_command ${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml
    }

    hide_edge_borders smart
    workspace_layout default
    gaps inner 5
    gaps outer 5
    smart_gaps on

    bindsym Print exec ${pkgs.flameshot}/bin/flameshot gui

    exec --no-startup-id ${pkgs.blueman}/bin/blueman-applet
    exec --no-startup-id ${pkgs.pasystray}/bin/pasystray

    for_window [class="^.*"] border pixel 1
  '';
}

