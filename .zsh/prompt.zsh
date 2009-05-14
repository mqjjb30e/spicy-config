autoload -Uz vcs_info && vcs_info
RED=$'%{\e[31m%}'
GR=$'%{\e[32m%}'
MA=$'%{\e[35m%}'
YE=$'%{\e[33m%}'
NC=$'%{\e[0m%}'
zstyle ':vcs_info:*' actionformats  "/${GR}%s:${YE}${GR}%b${YE}|${RED}%a${NC}"
zstyle ':vcs_info:*' formats        "/${GR}%s:${Y}${GR}%b%}${NC}"
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat "%b${RED}:${YE}%r"

# Put the string "hostname::/full/directory/path" in the title bar:
set_term_title() { 
	echo -ne "\e]2;$PWD\a" 
}

# Put the parentdir/currentdir in the tab
set_term_tab() {
	echo -ne "\e]1;$PWD:h:t/$PWD:t\a" 
}

set_running_app() {
 printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

precmd() { 
  if [ $TERM_PROGRAM ]; then
    set_term_title
    set_term_tab
    vcs_info
  fi
}

preexec() { 
  if [ $TERM_PROGRAM ]; then
    set_running_app
  fi
}

postexec() {
  set_running_app
}

export PS1='%{$reset_color$fg[gray]%}%2~%{$reset_color%}%{$vcs_info_msg_0_%}>%{$reset_color%} '
