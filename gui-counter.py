#!/usr/bin/env python3

import subprocess
import sys
from collections import Counter, OrderedDict

# Program names and corresponding gylphs.
programs = OrderedDict({
    'termite': '',
    'chrome': '',
    'firefox': '',
    'klayout': '',
    'skypeforlinux': '',
    'nemo': '蝹'
})

# Combine counts of program names in the tuple.  The resulting glpyh used will
# be that of the first program name in the tuple.
combine = [('chrome', 'chromium'),
           ('nemo', 'dolphin', 'nautilus', 'pcmanfm')]


def get_running_guis():
    # From https://askubuntu.com/questions/728157/how-to-get-the-list-of-running-gui-applications-in-the-unity-launcher
    try:
        listed = sys.argv[1]
    except IndexError:
        listed = []

    get = lambda cmd: subprocess.check_output(cmd).decode("utf-8").strip()

    def check_wtype(w_id):
        # check the type of window; only list "NORMAL" windows
        return "_NET_WM_WINDOW_TYPE_NORMAL" in get(["xprop", "-id", w_id])

    def get_process(w_id):
        # get the name of the process, owning the window
        proc = get(["ps", "-p", w_id, "-o", "comm="])
        proc = "gnome-terminal" if "gnome-terminal" in proc else proc
        return proc

    wlist = [l.split() for l in subprocess.check_output(["wmctrl", "-lp"])\
             .decode("utf-8").splitlines()]
    validprocs = [
        get_process(w[2]) for w in wlist if check_wtype(w[0]) == True
    ]

    return validprocs


# Get list of running GUI programs.
running = Counter(get_running_guis())

# Combine programs in combine list.
for lst in combine:
    count = 0
    for i in lst[1:]:
        try:
            count += running.pop(i)
        except KeyError:
            pass
    if count:
        running[lst[0]] += count

# Add counts to program list.
for k, v in running.items():
    programs[k] = (programs[k], v)

# Generate output.
output = ''
for v in programs.values():
    if isinstance(v, tuple):
        output += '%s %i ' % (v[0], v[1])

print(output)
