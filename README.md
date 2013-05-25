# Simon’s dotfiles

OSX, fish, git, Homebrew (prerequisite).

## Features

- Bootstrap script (`bootstrap.bash`) that syncs dotfiles to home dir, installs latest fish with Homebrew if missing and applies fish settings (universal vars)
- fish config (`.config/fish`) including 2-line prompt with user, host, working-dir, git-status (assumes terminal with dark background); e.g.
  <pre style="background-color: #333;"><code>
<span style="color: #5f875f;">sim</span><span style="color: #999;">@</span><span style="color: #5f87af;">serveur</span><span style="color: #999;">:</span><span style="color: #87af5f;">~/D/E/dotfiles</span><span style="color: #999;">:</span><span style="color: red;">master</span><span style="color: #999;">[</span><span style="color: green;">+</span><span style="color: blue;">•</span><span style="color: magenta;">›</span><span style="color: #666;">-</span><span style="color: red;">?</span><span style="color: #999;">]</span>
<span style="color: white;">▸</span>&nbsp;<span style="background-color: #555;">&nbsp;</span>
  </code></pre>
  The user, host and current working dir parts are dimmed when they don't change for less distraction; e.g.
  <pre style="background-color: #333;"><code>
<span style="color: #555;">sim</span><span style="color: #999;">@</span><span style="color: #555;">serveur</span><span style="color: #999;">:</span><span style="color: #555;">~/D/E/dotfiles</span><span style="color: #999;">:</span><span style="color: green;">master</span><span style="color: #999;">[</span><span style="color: green;">✓</span><span style="color: #999;">]</span>
<span style="color: white;">▸</span>&nbsp;<span style="background-color: #555;">&nbsp;</span>
  </code></pre>
  Note: inline styles are stripped on GitHub, so you must view this locally to see the proper colors above.
- Homebrew formulae (`brew.bash`)
- OSX settings (`osx.bash`)

The latter two borrow heavily from @mathiasbynens's [dotfiles](https://github.com/mathiasbynens/dotfiles).


## Installation

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
- Check for "required" apps?
- Consider adding more functions (cf. aliases/functions [there](https://github.com/mathiasbynens/dotfiles))


## Thanks

Original inspiration from https://github.com/mathiasbynens/dotfiles.
