#!/usr/bin/env python3

import os

def make_symlink(git_filename, os_filepath):
    home = os.path.expanduser('~/')
    cwd = os.getcwd()
    relpath = os.path.relpath(cwd, home)

    git_config = home+relpath+'/'+git_filename
    config = os.path.expanduser(os_filepath)
    try:
        os.remove(config)
    except OSError:
        pass
    os.symlink(git_config, config)

def main():
    termite_config = os.path.expanduser('~/.config/termite/config')
    nvim_config = os.path.expanduser('~/.nvimrc')
    zshrc_config = os.path.expanduser('~/.zshrc')
    desktop_files = '/usr/share/applications'

    make_symlink('termite-config', termite_config)
    make_symlink('vimrc', nvim_config)
    make_symlink('zshrc', zshrc_config)
    make_symlink('nvim-term.desktop', desktop_files)

if __name__ == '__main__':
    main()
