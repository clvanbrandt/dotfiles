import os
import socket
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.lazy import lazy

mod = "mod4"
alt = "mod1"
control = "control"
shift = "shift"
terminal = "alacritty"

font = "Fura Code Nerd Font"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


keys = [
    # Essentials
    Key([mod], "w", lazy.window.kill()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "r", lazy.spawn(f"dmenu_run -b -p 'Run: ' -fn '{font}'")),
    Key([mod, shift], "r", lazy.restart()),
    Key([mod, shift], "q", lazy.shutdown()),
    # LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "m", lazy.layout.maximize()),
    # APPLICATIONS
    Key([mod, control], "t", lazy.spawn(terminal)),
    Key([mod, control], "e", lazy.spawn("emacs")),
    Key([mod, control], "f", lazy.spawn("firefox")),
    Key([mod, control], "a", lazy.spawn("authy")),
    Key([mod, control], "b", lazy.spawn("bitwarden")),
    Key([mod, control], "s", lazy.spawn("slack")),
    # CHANGE FOCUS
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "space", lazy.layout.next()),
    # MOVE WINDOWS
    Key([mod, shift], "h", lazy.layout.shuffle_left()),
    Key([mod, shift], "l", lazy.layout.shuffle_right()),
    Key([mod, shift], "j", lazy.layout.shuffle_down()),
    Key([mod, shift], "k", lazy.layout.shuffle_up()),
    # RESIZE UP DOWN LEFT RIGHT# TOGGLE FLOATING LAYOUT
    Key([mod, shift], "space", lazy.window.toggle_floating()),
    Key([mod], "i", lazy.layout.shrink()),
    Key([mod], "o", lazy.layout.grow()),
    # FLIP LAYOUT
    Key([mod, shift], "space", lazy.layout.flip()),
    # Key([mod], "Return", lazy.layout.toggle_split()),
    # TOGGLE NEXT LAYOUT
    Key([mod], "Tab", lazy.next_layout()),
    # TOGGLE FLOATING LAYOUT
    Key([mod, shift], "f", lazy.window.toggle_floating()),
    # Multiple monitors
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),
    # Change the volume if your keyboard has special volume keys.
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 2 -q set PCM 1+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 2 -q set PCM 1-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -c 2 -q set PCM toggle")),
]


group_names = ["web", "code", "3", "4", "5", "6", "7", "8", "9"]
groups = [
    Group(name, layout="monadtall" if i == 1 else "max")
    for i, name in enumerate(group_names)
]


for i, name in enumerate(group_names):
    keys.extend(
        [
            Key(
                [mod],
                str(i + 1),
                lazy.group[name].toscreen(),
                desc="Switch to group {}".format(name),
            ),
            Key(
                [mod, shift],
                str(i + 1),
                lazy.window.togroup(name),
                desc="Move focused window to group {}".format(name),
            ),
            Key(
                [mod, control, shift],
                str(i + 1),
                lazy.window.togroup(name),
                lazy.group[name].toscreen(),
                desc="Move focused window to group {} and follow window".format(name),
            ),
        ]
    )

colors = {
    "background": "#202020",
    "background-alt": "#404040",
    "foreground": "#dfdfdf",
    "foreground-alt": "#808080",
    "primary": "#ffb52a",
    "secondary": "#e60053",
    "urgent": "#bd2c40",
    "selection": "#3e4451",
}


layout_theme = {
    "border_focus": colors["selection"],
    "margin": 8,
    "border_normal": "#1d2330",
    "border_width": 2,
}


layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
]


def init_widgets_defaults():
    return dict(
        font=font,
        padding=3,
        background=colors["background"],
        foreground=colors["foreground"],
    )


widget_defaults = init_widgets_defaults()
prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())


def init_widgets_list(scaling=1.0):
    fontsize = 18

    return [
        widget.Sep(
            fontsize=fontsize,
            linewidth=0,
            padding=6,
        ),
        widget.CurrentLayout(
            font="Noto Sans Bold",
            fontsize=fontsize,
            padding=4,
        ),
        widget.Sep(
            linewidth=2,
            padding=6,
        ),
        widget.GroupBox(
            font="FontAwesome",
            fontsize=fontsize,
            padding=2,
            # active="#ffaa00",
            inactive="#555555",
            highlight_method="line",
            this_current_screen_border="#fba922",
        ),
        widget.Sep(
            fontsize=fontsize,
            linewidth=0,
            padding=20,
        ),
        widget.WindowName(
            font="Fira Code Nerd Font",
            fontsize=fontsize,
        ),
        widget.Systray(
            fontsize=fontsize,
            padding=5,
        ),
        widget.Sep(
            fontsize=fontsize,
            linewidth=0,
            padding=10,
        ),
        widget.TextBox(
            fontsize=fontsize + 4,
            text="﬙",
            padding=1,
            foreground="#f90000",
        ),
        widget.CPU(
            fontsize=fontsize,
            format="{load_percent}%",
            padding=6,
        ),
        widget.CPUGraph(
            fill_color="#6790eb",
            graph_color="#6790eb",
            border_color="#c0c5ce",
            border_width=1,
            line_width=1,
            core="all",
            type="box",
        ),
        widget.ThermalSensor(
            fontsize=fontsize,
            fmt="{}",
            tag_sensor="Tctl",
            foreground_alert=colors["urgent"],
            threshold=80,
            padding=4,
        ),
        widget.TextBox(
            fontsize=fontsize + 4,
            text="",
            padding=4,
            foreground="#0a6cf5",
        ),
        widget.Memory(
            fontsize=fontsize,
            format="{MemUsed:.0f}M/{MemTotal:.0f}M",
            padding=2,
        ),
        widget.TextBox(
            fontsize=fontsize,
            text="",
            padding=8,
            foreground="#55aa55",
        ),
        # widget.Net(
        #     fontsize=fontsize,
        #     format="{down} ↓↑ {up}",
        #     padding=5,
        # ),
        widget.NetGraph(
            fontsize=12,
            bandwidth="down",
            interface="auto",
            fill_color="#6790eb",
            graph_color="#6790eb",
            border_color="#c0c5ce",
            padding=0,
            border_width=1,
            line_width=1,
        ),
        widget.TextBox(
            fontsize=fontsize + 4,
            text=" 墳",
            padding=2,
            foreground="#9f78e1",
        ),
        widget.PulseVolume(
            fontsize=fontsize,
            cardid=2,
            channel="PCM",
            padding=5,
        ),
        widget.TextBox(
            fontsize=fontsize,
            text=" ",
            foreground="#fba922",
            padding=2,
        ),
        widget.Clock(fontsize=fontsize, format=" %d-%m-%Y %a %H:%M", padding=0),
    ]


widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


widgets_screen1 = init_widgets_screen1()


def init_screens():
    return [
        Screen(
            bottom=bar.Bar(
                init_widgets_screen1(),
                30,
                opacity=0.9,
            ),
        ),
    ]


screens = init_screens()


# Mouse configuration
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click(
        [mod],
        "Button2",
        lazy.window.bring_to_front(),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List


@hook.subscribe.startup_once
def startup_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


@hook.subscribe.startup
def start_always():
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="Arandr"),
        Match(wm_class="feh"),
        Match(wm_class="Galculator"),
        Match(title="branchdialog"),
        Match(title="Open File"),
        Match(title="pinentry"),
        Match(title="Twilio Authy"),
        Match(title="CoreShot"),
        Match(title="JetBrains Toolbox"),
        Match(wm_class="ssh-askpass"),
    ],
    fullscreen_border_width=0,
    border_width=0,
)
auto_fullscreen = True

focus_on_window_activation = "focus"  # or smart

wmname = "LG3D"
