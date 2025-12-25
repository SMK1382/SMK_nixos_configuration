{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
  ];

  environment.etc."xdg/alacritty/alacritty.yml".text = ''
  env:
  TERM: xterm-256color

window:
  padding:
    x: 12
    y: 12
  decorations: full
  startup_mode: Windowed
  opacity: 0.98

font:
  size: 16.0
  normal:
    family: "DejaVu Sans Mono"

colors:
  primary:
    background: '#000000'
    foreground: '#ffffff'
  normal:
    black:   '#2e3436'
    red:     '#cc0000'
    green:   '#4e9a06'
    yellow:  '#c4a000'
    blue:    '#3465a4'
    magenta: '#75507b'
    cyan:    '#06989a'
    white:   '#d3d7cf'
  bright:
    black:   '#555753'
    red:     '#ef2929'
    green:   '#8ae234'
    yellow:  '#fce94f'
    blue:    '#729fcf'
    magenta: '#ad7fa8'
    cyan:    '#34e2e2'
    white:   '#eeeeec'

keyboard:
  bindings:
    - { key: Equals,   mods: Control, action: IncreaseFontSize }
    - { key: Minus,    mods: Control, action: DecreaseFontSize }
    - { key: Key0,     mods: Control, action: ResetFontSize }
    - { key: V,        mods: Control|Shift, action: Paste }
    - { key: C,        mods: Control|Shift, action: Copy }
'';
}
