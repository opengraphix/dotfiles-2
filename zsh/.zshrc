# https://wiki.gentoo.org/wiki/Zsh/HOWTO
# https://wiki.archlinux.org/index.php/Zsh#Simple_.zshrc

autoload -U compinit promptinit

#enable funky tab completion
compinit

#cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# enable menu style completion
zstyle ':completion:*' menu select

# beautify completion style
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# autocomplete aliases too
setopt completealiases

# load more prompts
promptinit

# set default prompt to walters theme
prompt walters

# add fancy git prompt
# https://github.com/olivierverdier/zsh-git-prompt 
# included as a submodule in dotfiles repo
if [[ -d ~/.zsh/git-prompt ]]
then
    source ~/.zsh/git-prompt/zshrc.sh
    PROMPT='%B%m%~%b$(git_super_status) %# '
fi

# set emacs as default key bindings
# vim = bindkey -v
bindkey -e

# allow cd'ing to dirs without the cd cmd
# for example /etc instead of cd /etc
setopt autocd

# enable extended globbing queries such as cp ^*.(tar|bz2|gz) .
setopt extendedglob

setopt HIST_IGNORE_DUPS