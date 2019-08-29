# dotfiles
This repository contains personal configuration files, scripts and
settings for a `home/` directory.

<!-- BEGIN generated code DO NOT EDIT. -->
1.	[ dotfiles](#-dotfiles)
	1.	[ Installation](#-installation)
	2.	[ Configuration](#-configuration)
		1.	[ Environment](#-environment)
	3.	[ Test](#-test)
	4.	[ See also](#-see-also)
	5.	[ License](#-license)
<!-- END generated code DO NOT EDIT. -->

## Installation
```sh
git clone git@github.com:bwasd/dotfiles.git
cd dotfiles
make
make install
```

**ACHTUNG!**: the installation will overwrite contents under `$HOME` and does
not backup anything! To test changes without modifying `$HOME` create a
temporary directory for use as an ephemeral home directory

```sh
tmpdir=$(mktemp -d)
make install DESTDIR="$tmpdir"
env -i HOME="$tmpdir" TERM="$TERM" "$SHELL" -l
```

## Configuration
Commands and variables are read from `config.in` and processed by
`m4(1)` macros in some files.

```make
NAME = 'Full name'
USER = unixuser
EMAIL = "user@example.com"
EDITOR = vim
KEY = 1444995EA28E4606A75BD7327BC21207AB08D788
KEYSERVER = pgp.mit.edu
```

### Environment
Names placed in `bash/.env` will be exported to the shell's environment
when bash is started as an interactive or non-interactive shell.

## Test
```sh
make test
```

## See also
- [Managing dot files with git](https://sanctum.geek.nz/arabesque/managing-dot-files-with-git/)
- [Unix as IDE](https://sanctum.geek.nz/arabesque/series/unix-as-ide/)
- [Origin of Dotfiles](https://blog.bwasd.io/origin-of-dotfiles)

## License
MIT
