PATH="$PATH:$HOME/.local/bin"

ZSH_AUTOSUGGEST_STRATEGY=( history )
ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )

[[ -r ~/.config/znap-repos/znap/znap.zsh ]] ||
        git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.config/znap-repos/znap
source ~/.config/znap-repos/znap/znap.zsh

setopt autocd

bindkey "^[[3~" delete-char

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source RobSis/zsh-completion-generator
znap source zsh-users/zsh-syntax-highlighting

eval "$(thefuck --alias)"

znap eval starship 'starship init zsh'
znap prompt
