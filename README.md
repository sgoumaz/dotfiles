# Simon’s dotfiles

OSX, fish, git, Homebrew.


## Features

- Bootstrap script (`bootstrap.bash`) that syncs dotfiles to home dir, installs latest fish with Homebrew if missing and applies fish settings (universal vars)
- fish config (`.config/fish`) including 2-line prompt with user, host, working dir, git status (assumes terminal with dark background); e.g. <br/>
  <img src="http://sgoumaz.github.io/dotfiles/images/prompt-fresh.png" alt="Prompt example (fresh)"/><br/>
  The user, host and current working dir parts are dimmed when they don't change for less distraction; e.g.<br/>
  <img src="http://sgoumaz.github.io/dotfiles/images/prompt-dimmed.png" alt="Prompt example (dimmed)"/>
- Homebrew formulae (`brew.bash`)
- OSX settings (`osx.bash`)

The latter two borrow heavily from @mathiasbynens's [dotfiles](https://github.com/mathiasbynens/dotfiles).


## Installation

Prerequisite: Homebrew.

1. `./bootstrap.bash` (or `./bootstrap.bash -f` to avoid the confirmation prompt)
2. If necessary, add fish to the system shells and make it your default shell:
    - Add `/usr/local/bin/fish` to `/etc/shells`
    - `chsh -s /usr/local/bin/fish`


## Feedback

Suggestions and improvements [welcome](https://github.com/sgoumaz/dotfiles/issues)!


## TODO

- Move git credentials away from `.gitconfig` to avoid accidental commits under my name
- Check for possible other prerequisites (e.g. XCode)
- Install Sublime Text plugins
- Check for "minimal" set of apps?
- Consider adding more functions (cf. [inspiration](https://github.com/mathiasbynens/dotfiles))


## Thanks

Original inspiration from https://github.com/mathiasbynens/dotfiles.
