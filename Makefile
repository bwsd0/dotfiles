-include config.in
include scripts/Makefile.lib

unexport GREP_OPTIONS

SHELL := /bin/bash
DESTDIR ?= $(HOME)

prefix ?=
bindir ?= $(prefix)/.local/bin

INSTALL = install
TOC		:= $(srcdir)/bin/toc
CHMOD	:= chmod
SED 	:= sed
M4		:= m4

SHELLCHECKOPTS=$(addprefix -e, SC1091 SC1117)

cmd_install_one = \
				  $(Q)$(kecho) '  INSTALL	$<'; \
				  $(INSTALL)
cmd_install_many = \
				   $(kecho) '  INSTALL	'"$$i"; \
				   $(INSTALL)


GENERATED_FILES = git/.gitconfig \
				  gnupg/gpg.conf \
				  mutt/muttrc \
				  msmtp/.msmtprc \
				  mbsync/.mbsyncrc

TARGETS = install-bin \
		  install-bash \
		  install-ssh \
		  install-git \
		  install-gnupg \
		  install-mutt \
		  install-x \
		  install-tmux \
		  install-psqlrc \
		  install-abook \
		  install-msmtp \
		  install-mbsync \
		  install-vim \
		  install-lesskey

.PHONY: all test default

.DEFAULT_GOAL := default

default: $(GENERATED_FILES)
all: $(TARGETS)

.PHONY: .gitconfig
git/.gitconfig: git/gitconfig.m4
	$(Q)$(kecho) '  GEN		$@';
	$(Q)$(M4) \
		-D GIT_AUTHOR_NAME=$(NAME) \
		-D GIT_AUTHOR_EMAIL=$(EMAIL) \
		-D EDITOR=$(EDITOR) \
		-D KEY=$(KEY) \
		$< > $@

.PHONY: gpg.conf
gnupg/gpg.conf: gnupg/gpg.conf.m4
	$(Q)$(kecho) '  GEN		$@';
	$(Q)$(M4) \
		-D GNUPGHOME=$(GNUPGHOME) \
		-D KEYSERVER=$(KEYSERVER) \
		-D KEY=$(KEY) \
		$< > $@

.PHONY: .msmtprc
msmtp/.msmtprc: msmtp/msmtprc.m4
	$(Q)$(kecho) '  GEN		$@';
	$(Q)$(M4) \
		-D EMAIL=$(EMAIL) \
		-D PASSCMD=$(PASSCMD) \
	$< > $@

.PHONY: muttrc
mutt/muttrc: mutt/muttrc.m4
	$(Q)$(kecho) '  GEN		$@';
	$(Q)$(M4) \
		-D SENDMAIL=$(SENDMAIL) \
		-D NAME=$(NAME) \
		-D EMAIL=$(EMAIL) \
		-D EDITOR=$(EDITOR) \
		-D MAILDIR=$(MAILDIR) \
		$< > $@

.PHONY: .offlineimaprc
offlineimap/.offlineimaprc: offlineimap/offlineimaprc.m4
	$(Q)$(kecho) '  GEN		$@';
	$(Q)$(M4) \
		-D USERNAME=$(USER) \
		-D EMAIL=$(EMAIL) \
		-D MAILDIR=$(MAILDIR) \
		$< > $@

.PHONY: .mbsyncrc
mbsync/.mbsyncrc: mbsync/mbsyncrc.m4 ## generate mbsyncrc
	$(Q)$(kecho) '  GEN		$@';
	$(Q)$(M4) \
		-D USER=$(USER) \
		-D MAILDIR=$(MAILDIR) \
		-D EMAIL=$(EMAIL) \
		-D PASSCMD=$(PASSCMD) \
		$< > $@

BASH_RCS = $(addprefix bash/,.bashrc \
	.bash_profile \
	.bash_logout \
	.bash_aliases \
	.path \
	.functions \
	.env \
	.bash_prompt \
	.inputrc)

install-bash: ## install bash files
	$(Q)for i in $(BASH_RCS); do \
		$(call cmd_install_many) -D -m 644 $$i $(DESTDIR); \
	done
	$(Q)source $(DESTDIR)/.bashrc

.PHONY: install-ssh
install-ssh:$(DESTDIR)/.ssh/config ## install SSH user configuration file
$(DESTDIR)/.ssh/config: ssh/config
	$(Q)mkdir -p $(DESTDIR)/.ssh
	$(Q)$(CHMOD) 0700 $(DESTDIR)/.ssh
	$(call cmd_install_one) -m 600 $< $@

GIT_FILES = git/.gitconfig git/.gitignore_global
.PHONY: install-git
install-git: $(GIT_FILES)  ## install global git options
	$(Q)for i in $(BASH_RCS); do \
		$(call cmd_install_many) -D -m 644 $$i $(DESTDIR); \
	done

.PHONY: install-lesskey
install-lesskey: $(DESTDIR)/.lesskey ## install less-key(1) bindings file
$(DESTDIR)/.lesskey: less/.lesskey
	$(call cmd_install_one) -m 644 $< $@
	$(Q)lesskey

BIN_FILES = $(addprefix bin/,setup-debian \
			install-kernel \
			install-go \
			ls-git \
			toc \
			web)

.PHONY: install-bin
install-bin: $(DESTDIR)$(bindir) ## install user scripts
$(DESTDIR)$(bindir): $(BIN_FILES)
	$(Q)mkdir -p -- $@
	$(Q)$(INSTALL) -m 644 $^ $@
	$(Q)$(CHMOD) -R +x $@

VIMDIR = .vim
VIMRC := $(VIMDIR)/vimrc

VIM_SRCS = after/indent/gitconfig.vim \
	after/indent/make.vim \
	after/indent/vim.vim \
	after/syntax/gitcommit.vim \
	after/syntax/sh.vim \
	autoload/html.vim \
	autoload/mail.vim \
	autoload/go.vim \
	colors/codedark.vim \
	colors/hybrid.vim \
	compiler/bash.vim \
	compiler/shellcheck.vim \
	compiler/sh.vim \
	filetype.vim \
	ftdetect/mine.vim \
	scripts.vim \
	syntax/msmtp.vim \
	system.vim \
	templates/shell.sh \
	templates/README.md \
	templates/index.html \
	templates/main.c

VIM_SRCS := $(addprefix $(VIMDIR)/, $(VIM_SRCS))
VIM_SRCS += $(VIMRC)

install-vim: ## install vim runtime
	$(Q)for i in $(VIM_SRCS); do \
		$(call cmd_install_many) -D -m 644 $$i $(DESTDIR)/$$i; \
	done

GPG_FILES = gnupg/gpg.conf \
			gnupg/gpg-agent.conf \
			gnupg/dirmngr.conf

install-gnupg: $(GPG_FILES) ## install gnupg
	$(Q)mkdir -m 0700 -p -- $(DESTDIR)/$(GNUPGHOME)
	$(Q)for i in $(GPG_FILES); do \
		$(call cmd_install_many) -D -m 600 $$i $(DESTDIR)/$(GNUPGHOME); \
	done

MUTT_RCS = mutt/muttrc \
	mutt/mutt-dark-16.muttrc \
	mutt/signature \
	mutt/mailcap

.PHONY: install-mutt
install-mutt: $(MUTT_RCS) ## install mutt configuration
	$(Q)mkdir -p -- $(DESTDIR)/.mutt \
		$(DESTDIR)/.cache/mutt
	$(Q)for i in $(MUTT_RCS); do \
		$(call cmd_install_many) -D -m 644 $$i $(DESTDIR)/.mutt; \
	done

.PHONY: install-abook
install-abook: $(DESTDIR)/.abook/abookrc
$(DESTDIR)/.abook/abookrc: abook/abookrc  ## install abookrc
	$(call cmd_install_one) -D -m  644 $< $@

.PHONY: install-tmux
install-tmux: $(DESTDIR)/.tmux.conf ## install tmux.conf
$(DESTDIR)/.tmux.conf: tmux/.tmux.conf
	$(call cmd_install_one) -m 644 $< $@

.PHONY: install-x
install-x: X/.Xresources X/.xinitrc ## install X
	$(call cmd_install_one) -m 644 $^ $(DESTDIR)

.PHONY: install-psqlrc
install-psqlrc: $(DESTDIR)/.psqlrc ## install psqlrc
$(DESTDIR)/.psqlrc: psql/.psqlrc
	$(call cmd_install_one) -m 644 $< $@

.PHONY: install-msmtp
install-msmtp: $(DESTDIR)/.msmtprc
$(DESTDIR)/.msmtprc: msmtp/.msmtprc
	$(call cmd_install_one) -m 600 $< $@

.PHONY: install-mbsync
install-mbsync: $(DESTDIR)/.mbsyncrc
$(DESTDIR)/.mbsyncrc: mbsync/.mbsyncrc
	$(call cmd_install_one) -m 644 $< $@

.PHONY: install-offlineimap
install-offlineimap: $(DESTDIR)/.offlineimaprc
$(DESTDIR)/.offlineimaprc: offlineimap/.offlineimaprc
	$(call cmd_install_one) -m 644 $< $@

.PHONY: test
test: ## run shellcheck tests on scripts
	./test.sh $(SHELLCHECKOPTS)

.PHONY: install
install: $(TARGETS)

readme-update: ## update README
	$(Q)$(shell $(TOC)) README.md

.PHONY: uninstall
uninstall: ## uninstall targets
	$(Q)for i in $(notdir $(BIN_FILES)); do \
		rm -f "$(DESTDIR)$(bindir)/$$i"; \
	done

.PHONY: clean
clean: ## clean most generated files
	$(Q)rm -rf $(GENERATED_FILES)

.PHONY: help
help: ## print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sed 's/^[^:]*://g' | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'
	@echo ''
	@echo 'Execute "make && make install" to install all targets'
