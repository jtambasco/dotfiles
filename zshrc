# ~/.zshrc

# Install:
# Trizen: antigen thefuck exa nerd-fonts-complete fzf yapf
# better_exceptions

source /usr/share/zsh/share/antigen.zsh

# Powerlevel9k theme settings
DEFAULT_USER='jl'
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir root_indicator vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator ssh vi_mode)
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-stash git-remotebranch git-tagname)

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle pip
antigen bundle command-not-found
antigen bundle zsh-dircolors-solarized
antigen bundle zsh-syntax-highlighting
antigen bundle git
antigen bundle bundler
antigen bundle dotenv
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle chrissicool/zsh-256color
antigen bundle supercrabtree/k
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle colored-man-pages
antigen bundle cp
antigen bundle vi-mode
antigen bundle b4b4r07/zsh-vimode-visual

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k


# Tell Antigen that you're done.
antigen apply

# zsh auto config
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
bindkey '^ ' autosuggest-accept
bindkey '^x' autosuggest-execute

# Default Python settings
export PYTHONSTARTUP=$HOME/.pythonstartup.py
export BETTER_EXCEPTIONS=1

# installed programs
alias trizenClean='trizen -R $(trizen -Qdtq)'
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

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source ~/.fzf.zsh
