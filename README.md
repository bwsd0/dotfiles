# dotfiles

This repository contains personal settings and scripts for a user's `home/`
directory.

## Installation

```sh
apt-get install build-essential m4
make install
```

**Note**: running `make install` overwrites contents the current user's `$HOME`
directory. Use the following to test changes in an ephemeral $HOME directory:

```sh
tmpdir="$(mktemp -d)"
make && make install DESTDIR="$tmpdir"
env -i HOME="$tmpdir" TERM="$TERM" "$SHELL" -l
```

## Test

```sh
make test
```

## License

MIT
