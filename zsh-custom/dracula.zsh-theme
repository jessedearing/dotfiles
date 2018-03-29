# Dracula Theme v1.0.0
#
# https://github.com/zenorocha/dracula-theme
#
# Copyright 2015, All rights reserved
#
# Code licensed under the MIT license
# http://zenorocha.mit-license.org
#
# @author Zeno Rocha <hi@zenorocha.com>

PROMPT='$(prompt_symbols)%{$fg_bold[blue]%}%{$fg_bold[green]%}➜ %{$fg_bold[green]%}%p %{$fg_bold[blue]%}%c $(git_prompt_info)% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_CLEAN=") %{$fg_bold[green]%}✔ "
ZSH_THEME_GIT_PROMPT_DIRTY=") %{$fg_bold[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

prompt_symbols() {
  local symbols
  symbols=()
  symbols+="%(?,,%{$fg_bold[red]%}✘)"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{$fg_bold[cyan]%}⚙  "
  [[ -n "$symbols" ]] && symbols+=""
  echo ${symbols[*]}
}
