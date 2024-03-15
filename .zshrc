# PERSONALIZATION

# NAVIGATION KEYBINDS
# from https://stackoverflow.com/a/29403520/11877756

bindkey "^U" backward-kill-line
bindkey "^X\\x7f" backward-kill-line
bindkey "^X^_" redo

# AUTOCOMPLETION

# initialize autocompletion
autoload -U compinit && compinit

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# autocompletion using arrow keys (based on history)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# USER PROMPT
# https://alldrops.info/posts/cli-drops/2021-07-26_customize-zsh-part-2/
  
# enable command-subsitution in PS1 
setopt PROMPT_SUBST
  
NL=$'\n'
  
PS1='$NL%B%F{cyan}%3~%f%b$NL%B%(?.%F{green}.%F{red})%(!.#.>)%f%b ' 



# Load commit signing SSH Key if not in the agent already
    ssh-add -l | grep "+git-commit-signing@datadoghq.com" > /dev/null || ssh-add --apple-use-keychain /Users/kevin.guo/.ssh/datadog_git_commit_signing 2> /dev/null
export GITLAB_TOKEN=$(security find-generic-password -a ${USER} -s gitlab_token -w)
# BEGIN ANSIBLE MANAGED BLOCK
# Load homebrew shell variables
eval "$(/opt/homebrew/bin/brew shellenv)"

# Force certain more-secure behaviours from homebrew
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha
export HOMEBREW_DIR=/opt/homebrew
export HOMEBREW_BIN=/opt/homebrew/bin

# Load python shims
eval "$(pyenv init -)"

# Load ruby shims
eval "$(rbenv init -)"

# Prefer GNU binaries to Macintosh binaries.
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Add AWS CLI to PATH
export PATH="/opt/homebrew/opt/awscli@1/bin:$PATH"

# Add GCloud to PATH
source "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
# Add datadog devtools binaries to the PATH
export PATH="$HOME/dd/devtools/bin:$PATH"

# Point GOPATH to our go sources
export GOPATH="$HOME/go"

# Add binaries that are go install-ed to PATH
export PATH="$GOPATH/bin:$PATH"

# Point DATADOG_ROOT to ~/dd symlink
export DATADOG_ROOT="$HOME/dd"

# Tell the devenv vm to mount $GOPATH/src rather than just dd-go
export MOUNT_ALL_GO_SRC=1

# store key in the login keychain instead of aws-vault managing a hidden keychain
export AWS_VAULT_KEYCHAIN_NAME=login

# tweak session times so you don't have to re-enter passwords every 5min
export AWS_SESSION_TTL=24h
export AWS_ASSUME_ROLE_TTL=1h

# Helm switch from storing objects in kubernetes configmaps to
# secrets by default, but we still use the old default.
export HELM_DRIVER=configmap

# Go 1.16+ sets GO111MODULE to off by default with the intention to
# remove it in Go 1.18, which breaks projects using the dep tool.
# https://blog.golang.org/go116-module-changes
export GO111MODULE=auto
export GOPRIVATE=github.com/DataDog
export GOPROXY=binaries.ddbuild.io,https://proxy.golang.org,direct
export GONOSUMDB=github.com/DataDog,go.ddbuild.io

# Configure Go to pull go.ddbuild.io packages.
export GOPROXY="binaries.ddbuild.io,proxy.golang.org,direct"
export GONOSUMDB="github.com/DataDog,go.ddbuild.io"
# END ANSIBLE MANAGED BLOCK

eval "$(direnv hook $SHELL)"
