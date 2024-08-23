# Simon’s dotfiles

Homebrew, fish, git, Hammerspoon…


## Features

- Bootstrap script (`bootstrap.bash`) that syncs dotfiles to home dir, installs latest fish with Homebrew if missing and applies fish settings (universal vars)
- [fish](https://github.com/fish-shell/fish-shell) config (`.config/fish`) including 2-line prompt with user, host, working dir, git status (assumes terminal with dark background); e.g. <br/>
  <img src="http://sgoumaz.github.io/dotfiles/images/prompt-fresh.png" alt="Prompt example (fresh)"/><br/>
  *Experimental hack: The user, host and current working dir parts are dimmed when they don't change for less distraction; e.g.*<br/>
  <img src="http://sgoumaz.github.io/dotfiles/images/prompt-dimmed.png" alt="Prompt example (dimmed)"/>
- [Hammerspoon](https://www.hammerspoon.org/) settings
- Homebrew formulae (`brew.bash`)


## Installation

Prerequisites: MacOS command-line tools, Homebrew.

1. `./bootstrap.bash` (or `./bootstrap.bash -f` to avoid the confirmation prompt)
2. If necessary, add fish to the system shells and make it your default shell:
    - `which fish >> /etc/shells`
    - `chsh -s $(which fish)`


## Feedback

Suggestions and improvements [welcome](https://github.com/sgoumaz/dotfiles/issues).


## Thanks

Original inspiration from https://github.com/mathiasbynens/dotfiles.
