import lemonbar_manager
import modules
import bspwm_modules
import clock_modules
import disk_modules
import sound_modules
import task_modules
import media_modules


PADDING = '   '  # Padding


#import logging
#logging.basicConfig(level=logging.INFO)


# Define the modules to put on the bar (in order)
modules = (
    modules.Const('%{Sf}%{l}'),
    bspwm_modules.Tags('DVI-D-0'),
    modules.Const('%{c}'),
    bspwm_modules.Windows('DVI-D-0'),
    modules.Const('%{r}'),
    task_modules.Count('status:pending'),
    modules.Const(PADDING),
    disk_modules.DiskUsage('/dev/sda1'),
    modules.Const(PADDING),
    clock_modules.Clock(),
    modules.Const(PADDING),

    modules.Const('%{Sl}%{l}'),
    bspwm_modules.Tags('DP-1'),
    modules.Const('%{c}'),
    bspwm_modules.Windows('DP-1'),
    modules.Const('%{r}'),
    media_modules.MediaControls(),
    modules.Const(PADDING),
    sound_modules.Volume('Master'),
)


# Lemonbar command
command = (
    'lemonbar',
    '-b',
    '-a', '100',
    '-g', 'x25',
    '-B', '#111111',
    '-F', '#ADADAD',
    '-o', '0',  # Push Noto down 0px
    '-o', '-1', # Push Material Desisn Icons down -1px
    '-f', 'Noto Sans Display:size=11',
    '-f', 'Material Design Icons:size=13'
)

# Run the bar with the given modules
with lemonbar_manager.Manager(command, modules) as mgr:
    mgr.loop()
