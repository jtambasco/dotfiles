# ~/.zshrc

# Install:
# yay: zplug thefuck exa nerd-fonts-complete fasd fzf yapf the_silver_searcher
# pip: better_exceptions

source /usr/share/zsh/scripts/zplug/init.zsh

# Powerlevel9k theme settings
DEFAULT_USER='jl'
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir root_indicator vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator ssh vi_mode)
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-stash git-remotebranch git-tagname)

# Bundles from the default repo (robbyrussell's oh-my-zsh).
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/zsh-dircolors-solarized", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/dotenv", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "chrissicool/zsh-256color"
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3

# Load the theme.
zplug "bhilburn/powerlevel9k", as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# zsh auto config
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Highlight autocompletion objects
zstyle ':completion:*' menu select
autoload -U compinit && compinit

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
bindkey '^ ' autosuggest-accept
bindkey '^x' autosuggest-execute

# Default Python settings
export PYTHONSTARTUP=$HOME/.pythonstartup.py
export BETTER_EXCEPTIONS=1

# installed programs
alias yayClean='yay -R $(yay -Qdtq)'
alias papercut='~/.papercut/pc-client-linux.sh'
alias aomx='WINEARCH=win32 WINEPREFIX=~/.win32 wine "/home/jl/.win32/dosdevices/c:/Program Files/Microsoft Games/Age of Mythology/aomx.exe"'

# thefuck
eval $(thefuck --alias fu)

# neovim
alias vim=nvim

# exa
PATH="$PATH:$HOME/.cargo/bin"
alias ls='exa -h'

# term
export TERM=xterm-256color

# Lumerical
alias lumerical-fdtd='/opt/lumerical/fdtd/bin/fdtd-solutions'
alias lumerical-mode='/opt/lumerical/mode/bin/mode-solutions'
alias lumerical-interconnect='/opt/lumerical/interconnect/bin/interconnect'
alias lumerical-device='/opt/lumerical/device/bin/device'

# Qt5
alias qt5-designer='/usr/lib/x86_64-linux-gnu/qt5/bin/designer'

# ZSH vim insert mode styles.
prompt_vi_mode() {
    local mode="${${${KEYMAP/vicmd/NORMAL}/(vivis|vivli)/VISUAL}/(main|viins)/INSERT}"
  if [[ "$mode" == "NORMAL" ]]; then
    $1_prompt_segment "$0" "$2" "$DEFAULT_COLOR" "white" "NORMAL"
  elif [[ "$mode" == "VISUAL" ]]; then
    $1_prompt_segment "$0" "$2" "$DEFAULT_COLOR" "199" "VISUAL"
  else
    $1_prompt_segment "$0" "$2" "$DEFAULT_COLOR" "blue" "INSERT"
  fi
}

source ~/.fzf.zsh

# FASD
eval "$(fasd --init auto)"
alias v="f -e nvim"
alias o="a -e xdg-open"
