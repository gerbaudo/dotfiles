#!/usr/bin/env python
# -*- coding: utf-8 -*-

from libqtile import bar, hook, layout, widget
from libqtile.command import lazy
from libqtile.config import Drag, Click, Group, Key, Match, Screen


# Theme defaults
bar_defaults = dict(
    size=28,
    background=['#222222', '#111111'],
)

layout_defaults = dict(
    border_width=1,
    margin=0,
    border_focus='#ff0000',
    border_normal='#333333',
)

widget_defaults = dict(
    font='Ubuntu',
    fontsize=12,
    padding=5,
    background=bar_defaults['background'],
    foreground=['#ffffff', '#ffffff', '#999999'],
    fontshadow='#000000',
)


class Widget(object):
    ''' Container for individual widget style options '''

    graph = dict(
        background='#000000',
        border_width=0,
        border_color='#000000',
        line_width=1,
        margin_x=0,
        margin_y=0,
        width=50,
    )

    groupbox = dict(
        active=widget_defaults['foreground'],
        inactive=['#444444', '#333333'],

        this_screen_border=layout_defaults['border_focus'],
        this_current_screen_border=layout_defaults['border_focus'],
        other_screen_border='#444444',

        urgent_text=widget_defaults['foreground'],
        urgent_border='#ff0000',

        highlight_method='block',
        rounded=True,

        # margin=-1,
        padding=3,
        borderwidth=2,
        disable_drag=True,
        invert_mouse_wheel=True,
    )

    sep = dict(
        foreground=layout_defaults['border_normal'],
        height_percent=100,
        padding=5,
    )

    systray = dict(
        icon_size=16,
        padding=5,
    )

    battery = dict(
       energy_now_file='charge_now',
       energy_full_file='charge_full',
       power_now_file='current_now',
    )

    battery_text = battery.copy()
    battery_text.update(
        format='{char} {hour:d}:{min:02d}',
    )

    weather = dict(
        update_interval=300,
        format='{condition_temp}',
    )


# Commands to spawn
class Commands(object):
    browser = 'google-chrome'
    dmenu = 'dmenu_run -i -b -p ">>>" -fn "-*-fixed-*-*-*-*-18-*-*-*-*-*-*-*" -nb "#15181a" -nf "#fff" -sb "#333" -sf "#fff"'
    file_manager = 'dolphin'
    lock_screen = '/usr/bin/slock'
    screenshot = 'ksnapshot'
    terminal = 'konsole'
    trackpad_toggle = '/usr/local/bin/toggleTouchPad'
    volume_up = 'amixer -q set Master 5%+ unmute'
    volume_down = 'amixer -q set Master 5%- unmute'
    volume_toggle = 'amixer -q set Master toggle'


# Keybindings
mod = 'mod4'
keys = [
    # Window Manager Controls
    Key([mod, 'control'], 'r', lazy.restart()),
    Key([mod, 'control'], 'q', lazy.shutdown()),
    Key([mod, 'control'], 'l', lazy.spawn(Commands.lock_screen)),

    # Window Controls
    Key([mod], 'w', lazy.window.kill()),
    Key([mod], 'f', lazy.window.toggle_floating()),

    # Layout, group, and screen modifiers
    #Key([mod], 'j', lazy.layout.up()),
    #Key([mod], 'k', lazy.layout.down()),
    #Key([mod, 'shift'], 'j', lazy.layout.shuffle_up()),
    #Key([mod, 'shift'], 'k', lazy.layout.shuffle_down()),
    #Key([mod, 'shift'], 'g', lazy.layout.grow()),
    #Key([mod, 'shift'], 's', lazy.layout.shrink()),
    #Key([mod, 'shift'], 'n', lazy.layout.normalize()),
    #Key([mod, 'shift'], 'm', lazy.layout.maximize()),
    #Key([mod, 'shift'], 'space', lazy.layout.flip()),

    # Switch groups
    Key([mod], 'Left', lazy.screen.prevgroup()),
    Key([mod], 'Right', lazy.screen.nextgroup()),

    # Cycle layouts
    Key([mod], 'Up', lazy.nextlayout()),
    Key([mod], 'Down', lazy.prevlayout()),

    # Change window focus
    Key([mod], 'Tab', lazy.layout.next()),
    Key([mod, 'shift'], 'Tab', lazy.layout.previous()),

    # Switch focus to other screens
    Key([mod], 'h', lazy.to_screen(0)),  # left
    Key([mod], 'l', lazy.to_screen(1)),  # right

    # Commands: Application Launchers
    Key([mod], 'space', lazy.spawn(Commands.dmenu)),
    Key([mod], 'n', lazy.spawn(Commands.browser)),
    Key([mod], 'e', lazy.spawn(Commands.file_manager)),
    Key([mod], 'Return', lazy.spawn(Commands.terminal)),

    # Commands: Volume Controls
    Key([], 'XF86AudioRaiseVolume', lazy.spawn(Commands.volume_up)),
    Key([], 'XF86AudioLowerVolume', lazy.spawn(Commands.volume_down)),
    Key([], 'XF86AudioMute', lazy.spawn(Commands.volume_toggle)),

    Key([], 'XF86TouchpadToggle', lazy.spawn(Commands.trackpad_toggle)),
    Key([], 'XF86Display', lazy.spawn("/usr/local/bin/toggleVga1")),

    # TODO: What does the PrtSc button map to?
    Key([mod], 'p', lazy.spawn(Commands.screenshot)),
]


# Groups
group_setup = (
    ('www', {  # fa-globe
        'layout': 'max',
        'matches': [Match(wm_class=('Firefox', 'Google-chrome'))],
    }),
    ('code', {  # fa-terminal
        'layout': 'max',
        'matches': [Match(wm_class=('Konsole', 'xterm',))],
    }),
    ('comm', {  # communication
        'layout': 'max',
        'matches': [Match(wm_class=('Skype',))],
    }),
    ('other', {}),  # fa-other
)

groups = []
for idx, (label, config) in enumerate(group_setup):
    hotkey = str(idx + 1)
    config.setdefault('layout', 'tile')
    groups.append(Group(label, **config))

    # mod + hotkey = switch to group
    keys.append(Key([mod], hotkey, lazy.group[label].toscreen()))

    # mod + shift + hotkey = move focused window to group
    keys.append(Key([mod, 'shift'], hotkey, lazy.window.togroup(label)))


# Mouse
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
bring_front_click = True


# Screens
screens = [
    Screen(
        # bottom=bar.Bar(widgets=[Powerline()], **bar_defaults),
        top=bar.Bar(widgets=[
            widget.GroupBox(**Widget.groupbox),
            widget.WindowName(),

            widget.CPUGraph(graph_color='#18BAEB', fill_color='#1667EB.3', **Widget.graph),
            widget.MemoryGraph(graph_color='#00FE81', fill_color='#00B25B.3', **Widget.graph),
            widget.SwapGraph(graph_color='#5E0101', fill_color='#FF5656', **Widget.graph),
            widget.NetGraph(graph_color='#ffff00', fill_color='#4d4d00', interface='eth1', **Widget.graph),
            widget.HDDBusyGraph(device='sda', **Widget.graph),

            widget.ThermalSensor(metric=False, threshold=158),
            widget.Sep(**Widget.sep),

            widget.CurrentLayout(),
            widget.Systray(**Widget.systray),
            # widget.BatteryIcon(**Widget.battery),
            widget.Battery(**Widget.battery_text),
            # widget.Volume(theme_path='/usr/share/icons/Humanity/status/22/', cardid=1),
            widget.YahooWeather(location='Irvine, CA', **Widget.weather),
            widget.HDDBusyGraph(device='sdb', **Widget.graph),
            widget.Clock(fmt='%a %d %b %I:%M %p'),
            ], **bar_defaults),
    ),
    Screen(
        top=bar.Bar(widgets=[
            widget.GroupBox(**Widget.groupbox),
            widget.WindowName(),
            widget.CurrentLayout(),
        ], **bar_defaults),
    )
]


# Layouts
layouts = (
    layout.Tile(ratio=0.5, **layout_defaults),
    layout.Max(**layout_defaults),
    layout.RatioTile(**layout_defaults),
    layout.Matrix(**layout_defaults),
    layout.MonadTall(**layout_defaults),
    layout.Stack(**layout_defaults),
    layout.Zoomy(**layout_defaults),
)

floating_layout = layout.floating.Floating(
    auto_float_types=(
        'notification',
        'toolbar',
        'splash',
        'dialog',
    ),
    float_rules=[{'wmclass': x} for x in (
        'audacious',
        'Download',
        'dropbox',
        'file_progress',
        'file-roller',
        'gimp',
        'Komodo_confirm_repl',
        'Komodo_find2',
        'pidgin',
        'skype',
        'Transmission',
        'Update',  # Komodo update window
        'Xephyr',
    )],
    **layout_defaults
)


def main(qtile):
    pass


@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True
@hook.subscribe.client_new
def vidyo_windows(window):
    if ('vidyo' in window.window.get_name().lower()):
        window.floating = True
        

# not working, call from cmd-line or fix
@hook.subscribe.startup
def setup_keyboard():
    subprocess.call(['source ~/.xmodmap'])
