#!/usr/bin/env python3

import os

def make_symlink(git_filename, os_filepath, sudo=False, soft=False):
    home = os.path.expanduser('~/')
    cwd = os.getcwd()
    relpath = os.path.relpath(cwd, home)

    git_config = home+relpath+'/'+git_filename
    config = os.path.expanduser(os_filepath)

    if os.path.isfile(config):
        if sudo:
            os.system('sudo rm %s' % config)
        else:
            os.remove(config)

    if sudo and not soft:
        os.system('sudo ln %s %s' % (git_config, config))
    elif sudo and soft:
        os.system('sudo ln -s %s %s' % (git_config, config))
    elif not sudo and not soft:
        os.system('ln %s %s' % (git_config, config))
    elif not sudo and soft:
        os.system('ln -s %s %s' % (git_config, config))

def main():
    termite_config = os.path.expanduser('~/.config/termite/config')
    i3_config = os.path.expanduser('~/.config/i3/config')
    polybar_config = os.path.expanduser('~/.config/polybar/config')
    polybar_open_weather_sh = os.path.expanduser('~/.config/polybar/openweathermap-detailed.sh')
    polybar_open_weather_fc_sh = os.path.expanduser('~/.config/polybar/openweathermap-forecast.sh')
    polybar_gui_counter_py = os.path.expanduser('~/.config/polybar/gui-counter.py')
    rofi_config = os.path.expanduser('~/.config/rofi/config')
    nvim_config = os.path.expanduser('~/.nvimrc')
    nvim_init_config = os.path.expanduser('~/.config/nvim/init.vim')
    zshrc_config = os.path.expanduser('~/.zshrc')
    desktop_files = '/usr/share/applications/nvim-term.desktop'

    make_symlink('termite-config', termite_config, soft=True)
    make_symlink('i3-config', i3_config, soft=True)
    make_symlink('polybar-config', polybar_config, soft=True)
    make_symlink('openweathermap-detailed.sh', polybar_open_weather_sh, soft=True)
    make_symlink('openweathermap-forecast.sh', polybar_open_weather_fc_sh, soft=True)
    make_symlink('gui-counter.py', polybar_gui_counter_py, soft=True)
    make_symlink('rofi-config', rofi_config, soft=True)
    make_symlink('nvimrc', nvim_config, soft=True)
    make_symlink('nvim-init', nvim_init_config, soft=True)
    make_symlink('zshrc', zshrc_config, soft=True)
    make_symlink('nvim-term.desktop', desktop_files, sudo=True, soft=True)

if __name__ == '__main__':
    main()
