#!/usr/bin/env python3

import subprocess
import sys
from collections import Counter, OrderedDict

def f(string, idx):
    return '%%{T%i}%s%%{T-}' % (idx, string)

# Font from:
# ttf-material-design-icons-git (https://materialdesignicons.com/)

# Update GUIs
GUI = True

# Update processes
PROCESS = True

# Glyph to mark start and end of program output
start_end_marker = ''

# Program/process names and corresponding gylphs.
guis = OrderedDict({
    'terminals': '',
    'chromes': f('', 4),
    'firefox': '',
    'skypeforlinux': '',
    'filemanager': '蝹',
    'remote-desktop': '',
    'pdfviewer': '',
    'image': '',
    'klayout': '',
    'messenger': '',
    'whatsie': '',
})

processes = OrderedDict({
    'vims': f('', 4),#'',
    'ssh': '',
    'lumerical': '',
    'updater': '練',
})

# Combine counts of program/process names in the tuple.  The resulting glpyh used will
# be that of the corresponding key.
combine_guis = {
    'terminals': ('termite', 'terminator', 'urxvt'),
    'chromes': ('chromium', 'chrome'),
    'filemanger': ('nemo', 'thunar', 'dolphin', 'nautilus', 'pcmanfm'),
    'remote-desktop': ('TeamViewer', ),
    'pdfviewer': ('evince', 'okular', 'zathura'),
    'image': ('gthumb', 'shotwell', 'deepin-image-vi'),
    'messenger': ('messengerfordes', 'caprine'),
}

combine_proccesses = {
    'vims': ('nvim', 'vim'),
    'lumerical': ('fdtd-solutions', 'mode-solutions'),
    'updater': ('pacman', 'yay', 'trizen', 'yaourt'),
}

################################################################################

gui_output = ''
process_output = ''

if GUI:

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
            return proc

        wlist = [l.split() for l in subprocess.check_output(["wmctrl", "-lp"])\
                 .decode("utf-8").splitlines()]
        validprocs = [
            get_process(w[2]) for w in wlist if check_wtype(w[0]) == True
        ]

        #print(validprocs)
        return validprocs

    # Get list of running GUI programs.
    gui_counts = Counter(get_running_guis())

    # Combine programs in program combine list.
    for k, lst in combine_guis.items():
        count = 0
        for i in lst:
            try:
                count += gui_counts.pop(i)
            except KeyError:
                pass
        if count:
            gui_counts[k] += count

    # Generate program output.
    for k, v in guis.items():
        try:
            c = gui_counts[k]
            if c:
                gui_output += '%s %i ' % (v, c)
        except:
            pass

if PROCESS:

    def get_running_proc(process_name_list):
        counts = [None] * len(process_name_list)

        for i, p in enumerate(process_name_list):
            try:
                count = int(
                    subprocess.check_output(['pgrep', '-c', '-x',
                                             p]).decode('utf-8'))
            except subprocess.CalledProcessError:
                count = 0
            counts[i] = (p, count)

        return dict(counts)

    # Count running proccesses.
    process_counts = get_running_proc(processes.keys())
    combine_counts = get_running_proc(
        list(sum(combine_proccesses.values(), ())))
    process_counts.update(combine_counts)

    # Combine processes in process combine list.
    for k, lst in combine_proccesses.items():
        count = 0
        for i in lst:
            try:
                count += process_counts.pop(i)
            except KeyError:
                pass
        if count:
            process_counts[k] += count

    # Generate process output.
    for k, v in processes.items():
        try:
            c = process_counts[k]
            if c:
                process_output += '%s %i ' % (v, c)
        except:
            pass

if gui_output or process_output:
    print(start_end_marker + (gui_output + process_output)[:-1] + start_end_marker)
else:
    print('')
