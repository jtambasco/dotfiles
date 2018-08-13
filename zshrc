# ~/.zshrc
#
# Install:
# Trizen: oh-my-zsh-git thefuck exa fasd nerd-fonts-complete fzf yapf
# oh-my-zsh: Powerlevel9k zsh-dircolors-solarized zsh-syntax-highlighting
# better_exceptions

# oh-my-zsh config
DEFAULT_USER='jl'
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME='powerlevel9k/powerlevel9k'

plugins=(
  zsh-dircolors-solarized
  zsh-syntax-highlighting
  git
  bundler
  dotenv
)

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir root_indicator vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator ssh)

POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-stash git-remotebranch git-tagname)

export ZSH=/usr/share/oh-my-zsh
source $ZSH/oh-my-zsh.sh

# zsh auto config
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

# Default Python settings
export PYTHONSTARTUP=$HOME/.pythonstartup.py
export BETTER_EXCEPTIONS=1

# installed programs
alias trizenClean='trizen -R $(trizen -Qdtq)'
alias papercut='~/.papercut/pc-client-linux.sh'
alias coral='/usr/local/coral-remote/coral-remote-mtl'
alias css='wine /home/jl/.wine/drive_c/Program\ Files\ \(x86\)/Setti/Counter-Strike\ Source/hl2.exe -game cstrike -console -novid'
alias aomx='wine "/home/jl/.wine/drive_c/Program Files (x86)/Microsoft Games/Age of Mythology/aomx"'
alias coh='cd "/home/jl/.wine/drive_c/Program Files (x86)/THQ/Company of Heroes/" && wine "/home/jl/.wine/drive_c/Program Files (x86)/THQ/Company of Heroes/RelicCOH.exe" && cd -'
alias supcom='wine "/home/jl/.wine/drive_c/Program Files (x86)/THQ/Gas Powered Games/Supreme Commander - Forged Alliance/bin/ForgedAlliance.exe"'
alias voobly='export STAGING_WRITECOPY=1 && wine "/home/jl/.wine/drive_c/Program Files (x86)/Voobly/voobly.exe"'

# thefuck
eval $(thefuck --alias fu)

# fasd
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
alias v='f -e vim' # quick opening files with vim
alias sv='vim `sf`'
eval "$(fasd --init posix-alias zsh-hook)"

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

# FZF
alias fvim='nvim $(fzf)'
alias fcd='cd "$(dirname "$(fzf)")"'

# Qt5
alias qt5-designer='/usr/lib/x86_64-linux-gnu/qt5/bin/designer'
