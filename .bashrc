# ------------------------------------------------------
# ------------------------------------------------------
# ------------------------------------------------------
#   ⚠️ DO NOT INCLUDE PERSONAL OR SENSITIVE DATA ⚠️ 
# ------------------------------------------------------
# ------------------------------------------------------
# ------------------------------------------------------

# -------------------------------------
# oh-my-posh start
# -------------------------------------

export POSH_THEME=/home/babak/Downloads/themes/sim-web.omp.json
export POSH_SHELL_VERSION=$BASH_VERSION
export POWERLINE_COMMAND="oh-my-posh"
export POSH_PID=$$
export CONDA_PROMPT_MODIFIER=false
omp_start_time=""

# start timer on command start
PS0='${omp_start_time:0:$((omp_start_time="$(_omp_start_timer)",0))}$(_omp_ftcs_command_start)'
# set secondary prompt
PS2="$(/home/babak/.local/bin/oh-my-posh print secondary --config="$POSH_THEME" --shell=bash --shell-version="$BASH_VERSION")"

function _set_posh_cursor_position() {
    # not supported in Midnight Commander
    # see https://github.com/JanDeDobbeleer/oh-my-posh/issues/3415
    if [[ "false" != "true" ]] || [[ -v MC_SID ]]; then
        return
    fi

    local oldstty=$(stty -g)
    stty raw -echo min 0

    local COL
    local ROW
    IFS=';' read -sdR -p $'\E[6n' ROW COL

    stty $oldstty

    export POSH_CURSOR_LINE=${ROW#*[}
    export POSH_CURSOR_COLUMN=${COL}
}

function _omp_start_timer() {
    /home/babak/.local/bin/oh-my-posh get millis
}

function _omp_ftcs_command_start() {
    if [ "false" == "true" ]; then
        printf "\e]133;C\a"
    fi
}

# template function for context loading
function set_poshcontext() {
    return
}

function _omp_hook() {
    local ret=$? pipeStatus=(${PIPESTATUS[@]})
    if [[ "${#BP_PIPESTATUS[@]}" -ge "${#pipeStatus[@]}" ]]; then
        pipeStatus=(${BP_PIPESTATUS[@]})
    fi

    local omp_stack_count=$((${#DIRSTACK[@]} - 1))
    local omp_elapsed=-1
    local no_exit_code="true"

    if [[ -n "$omp_start_time" ]]; then
        local omp_now=$(/home/babak/.local/bin/oh-my-posh get millis --shell=bash)
        omp_elapsed=$((omp_now-omp_start_time))
        omp_start_time=""
        no_exit_code="false"
    fi

    set_poshcontext
    _set_posh_cursor_position

    PS1="$(/home/babak/.local/bin/oh-my-posh print primary --config="$POSH_THEME" --shell=bash --shell-version="$BASH_VERSION" --status="$ret" --pipestatus="${pipeStatus[*]}" --execution-time="$omp_elapsed" --stack-count="$omp_stack_count" --no-status="$no_exit_code" | tr -d '\0')"
    return $ret
}

if [ "$TERM" != "linux" ] && [ -x "$(command -v /home/babak/.local/bin/oh-my-posh)" ] && ! [[ "$PROMPT_COMMAND" =~ "_omp_hook" ]]; then
    PROMPT_COMMAND="_omp_hook; $PROMPT_COMMAND"
fi

if [ "false" == "true" ]; then
    echo ""
fi

# -------------------------------------
# o-my-posh end
# -------------------------------------


# -------------------------------------
# bashrc start
# -------------------------------------

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

export PATH="$PATH:/opt/nvim-linux64/bin"
export POETRY_ROOT=~/.cache/pypoetry/
export EDITOR=/usr/bin/nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
. "$HOME/.cargo/env"

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias ls="lsd"
alias la="ll -a"

# -------------------------------------
# bashrc end
# -------------------------------------
