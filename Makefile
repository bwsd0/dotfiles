-include config.in

SHELL := /bin/bash
DESTDIR ?= $(HOME)
bindir ?= $(DESTDIR)/.local/bin

INSTALL := install -C
M4 := m4

# Verbosity control: V=1 for verbose output
Q := $(if $(V),,@)
msg = echo '  $(1)	$(2)'

TARGETS := install-bin \
	install-bash \
	install-ssh \
	install-git \
	install-gnupg \
	install-tmux \
	install-psqlrc \
	install-mycnf \
	install-vim

.PHONY: all default install clean help configure $(TARGETS)

.DEFAULT_GOAL := default

default: git/.gitconfig

all: $(TARGETS)

install: $(TARGETS)

# Generate .gitconfig from template
configure git/.gitconfig: git/gitconfig.m4
	@./scripts/mkconfig.sh
	$(Q)$(call msg,GEN,$@)
	$(Q)$(M4) -DNAME='$(NAME)' -DEMAIL='$(EMAIL)' -DEDITOR='$(EDITOR)' -DKEY='$(KEY)' $< > git/.gitconfig

# Bash configuration files
BASH_FILES := .bashrc .bash_profile .bash_logout .bash_aliases .path .functions .env .bash_prompt .inputrc

install-bash: ## install bash files
	$(Q)for f in $(BASH_FILES); do \
		$(call msg,INSTALL,bash/$$f); \
		$(INSTALL) -m 644 bash/$$f $(DESTDIR)/$$f; \
	done

# SSH configuration
install-ssh: ssh/config ## install SSH config
	$(Q)$(call msg,INSTALL,$<)
	$(Q)mkdir -p -m 0700 $(DESTDIR)/.ssh
	$(Q)$(INSTALL) -m 600 $< $(DESTDIR)/.ssh/config

# Git configuration
install-git: git/.gitconfig git/.gitignore_global ## install git config
	$(Q)for f in $^; do \
		$(call msg,INSTALL,$$f); \
		$(INSTALL) -m 644 $$f $(DESTDIR)/$$(basename $$f); \
	done

# User scripts
BIN_FILES := $(wildcard bin/*)

install-bin: $(BIN_FILES) ## install user scripts
	$(Q)mkdir -p $(bindir)
	$(Q)for f in $^; do \
		$(call msg,INSTALL,$$f); \
		$(INSTALL) -m 755 $$f $(bindir); \
	done

# Vim runtime files
VIM_FILES := $(shell find .vim -type f -name '*.vim') .vim/vimrc

install-vim: $(VIM_FILES) ## install vim runtime
	$(Q)for f in $(VIM_FILES); do \
		$(call msg,INSTALL,$$f); \
		mkdir -p $(DESTDIR)/$$(dirname $$f); \
		$(INSTALL) -m 644 $$f $(DESTDIR)/$$f; \
	done

# GnuPG configuration
GNUPGHOME ?= .gnupg
GPG_FILES := gnupg/gpg.conf gnupg/gpg-agent.conf

install-gnupg: $(GPG_FILES) ## install gnupg config
	$(Q)mkdir -p -m 0700 $(DESTDIR)/$(GNUPGHOME)
	$(Q)for f in $^; do \
		$(call msg,INSTALL,$$f); \
		$(INSTALL) -m 600 $$f $(DESTDIR)/$(GNUPGHOME)/$$(basename $$f); \
	done

# Tmux configuration
install-tmux: tmux/.tmux.conf ## install tmux.conf
	$(Q)$(call msg,INSTALL,$<)
	$(Q)$(INSTALL) -m 644 $< $(DESTDIR)/.tmux.conf

# PostgreSQL configuration
install-psqlrc: psql/.psqlrc ## install psqlrc
	$(Q)$(call msg,INSTALL,$<)
	$(Q)$(INSTALL) -m 644 $< $(DESTDIR)/.psqlrc

# MySQL configuration
install-mycnf: mysql/.my.cnf ## install mysql config
	$(Q)$(call msg,INSTALL,$<)
	$(Q)$(INSTALL) -m 644 $< $(DESTDIR)/.my.cnf

# Cleanup
clean: ## clean generated files
	$(Q)rm -f git/.gitconfig

# Uninstall
uninstall: ## uninstall targets
	$(Q)for f in $(notdir $(BIN_FILES)); do \
		rm -f "$(bindir)/$$f"; \
	done

# Help
help: ## print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}' | \
		sort
	@echo ''
	@echo 'Run "make install" to install all targets'
