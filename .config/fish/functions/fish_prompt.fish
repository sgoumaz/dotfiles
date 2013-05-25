function fish_prompt --description 'Write out the prompt'
  set last_status $status

  # HACK: workaround to force new sessions not to display dimmed;
  # prompt seems to be called multiple times which makes our change detection logic ineffective,
  # comparing the time attempts to detect such cases
  set date (date)

  # set default colors

  set user_color $fish_color_user
  set host_color $fish_color_host
  set cwd_color $fish_color_cwd

  # check changes and dim color if no change

  set cur_user (whoami)
  if test "$fish_prompt_last_user" = $cur_user -a "$fish_prompt_last_date" != $date
    set user_color $fish_color_dimmed
  end
  set -g fish_prompt_last_user $cur_user

  set cur_host (hostname -s)
  if test "$fish_prompt_last_host" = $cur_host -a "$fish_prompt_last_date" != $date
    set host_color $fish_color_dimmed
  end
  set -g fish_prompt_last_host $cur_host

  set cur_cwd (prompt_pwd)
  if test "$fish_prompt_last_cwd" = $cur_cwd -a "$fish_prompt_last_date" != $date
    set cwd_color $fish_color_dimmed
  end
  set -g fish_prompt_last_cwd $cur_cwd

  # HACK continuation (see above)
  set -g prompt_last_date $date

  # write prompt

  set_color $user_color;           echo -n $cur_user

  set_color $fish_color_separator; echo -n '@'

  set_color $host_color;           echo -n $cur_host

  set_color $fish_color_separator; echo -n ':'

  set_color $cwd_color;            echo -n $cur_cwd

  set_color normal;                prompt_git_status

  echo
  if not test $last_status -eq 0
    set_color $fish_color_error
  end
  echo -n '▸ '

  set_color normal
end
