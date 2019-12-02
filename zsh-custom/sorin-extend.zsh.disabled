# sorin.zsh-theme
# screenshot: http://i.imgur.com/aipDQ.png

export AWS_EXPIRY=""

function _background_procs() {
	[[ $(jobs -l | wc -l) -gt 0 ]] && echo -n "⚙  "
}

function _kube_info() {
  if ! type kubectl &> /dev/null; then
    return
  fi

  context=`kubectl config current-context 2> /dev/null`
  if [ $? != 0 ]; then
    return
  fi

  if [[ "$context" =~ 'prod' ]]; then
    context="%{$fg[red]%}prod"
  elif [[ "$context" =~ 'dev' ]]; then
    context="%{$fg[blue]%}dev"
  elif [[ "$context" =~ '.*\@(.*)' ]]; then
    context="%{$fg[blue]%}${match[1]}"
  else
    context="%{$fg[blue]%}`echo $context | cut -c-21`"
  fi

  print "%{$fg[blue]%}ﴱ $context "
}

function _aws_vault_segment() {
  local color_indicator
  if [ ! -z "$AWS_EXPIRY" ]; then
    if [[ $AWS_EXPIRY > `date +%s` ]]; then
      color_indicator="%{$fg[blue]%}"
    else
      color_indicator="%{$fg[red]%}"
    fi
  fi
  local vault_segment
  vault_segment="$color_indicator`prompt_aws_vault_segment`%{$reset_color%}"
  [[ `prompt_aws_vault_segment` != '' ]] && echo "$vault_segment "
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
  local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%}"

  PROMPT='$(_kube_info)$(_aws_vault_segment)$(_background_procs)%{$fg[cyan]%}%c$(git_prompt_info) %(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%}❯)%{$reset_color%} '

  ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git%{$reset_color%}:%{$fg[red]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  #RPROMPT='${return_status}$(git_prompt_status)%{$reset_color%}'
	RPROMPT='${return_status} $(git_prompt_status) $(vi_mode_prompt_info)%{$reset_color%}'

  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
  ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
else 
  MODE_INDICATOR="❮❮❮"
  local return_status="%(?::⏎)"
  
  PROMPT='%c$(git_prompt_info) %(!.#.❯) '

  ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='${return_status}$(git_prompt_status)'

  ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
  ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
  ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi
