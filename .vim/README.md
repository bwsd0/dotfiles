# vim

Compile vim from source with the `+xterm_clipboard` and `+clipboard`
features enabled:

```bash
sudo apt-get install libncurses5-dev \
	libgtk2.0-dev \
	libatk1.0-dev \
	libcairo2-dev \
	libx11-dev \
	libxpm-dev \
	libxt-dev \
	python-dev-is-python3 \
	python3-dev \
	ruby-dev \
	lua5.1 \
	lua5.1-dev \
	libperl-dev \
	git

sudo apt-get remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox

git clone https://github.com/vim/vim.git
./configure \
	--enable-rubyinterp=dynamic \
	--enable-cscope \
	--enable-gui=auto \
	--enable-gtk2-check \
	--enable-gnome-check \
	--with-features=huge \
	--with-x
 make && sudo make install
 ```
