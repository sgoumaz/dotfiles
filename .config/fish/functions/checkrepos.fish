function checkrepos
  # TODO restore original directory when interrupted
  # set -l pwd (pwd)
  # this doesn't work: trap "cd $pwd" 1 2 15

  set -l pull 0
  for option in $argv
    switch "$option"
        case -p --pull
          set pull 1
    end
  end

  set -l dirty 0

  echo ""

  for file in *
    if not test -d "$file/.git"
      continue
    end

    # it's a git repo

    cd $file

    git remote update >/dev/null

    set -l remote_changes (git --no-pager log --remotes --not --branches --oneline|wc -l|xargs)
    set -l local_changes (git --no-pager log --branches --not --remotes --oneline|wc -l|xargs)

    if test "$remote_changes" != "0" -o "$local_changes" != "0"
      set dirty 1

      set_color --bold white
      echo -n "$file"
      set_color normal
      if test "$remote_changes" != "0"
        set_color yellow; echo -n " ("(echo $remote_changes)")"
      end
      if test "$local_changes" != "0"
        set_color red; echo -n " ("(echo $local_changes)")"
      end

      if test "$pull" = "1"
        set_color 999
        echo ""
        echo -n "pull: "
        set_color normal
        git pull
      end


      echo ""
      echo ""
    end

    cd ..
  end

  return $dirty
end
