-include config.in
include scripts/Makefile.lib

unexport GREP_OPTIONS

SHELL := /bin/bash
DESTDIR ?= $(HOME)

prefix ?= $(HOME)
bindir ?= $(prefix)/.local/bin

INSTALL = install
CHMOD	:= chmod
SED 	:= sed
M4		:= m4

cmd_install_one = \
				  $(Q)$(kecho) '  INSTALL	$<'; \
				  $(INSTALL)
cmd_install_many = \
				   $(kecho) '  INSTALL	'"$$i"; \
				   $(INSTALL)


GENERATED_FILES = git/.gitconfig

TARGETS = install-bin \
		  install-bash \
		  install-ssh \
		  install-git \
		  install-gnupg \
		  install-x \
		  install-tmux \
		  install-psqlrc \
		  install-mycnf \
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
		-D GIT_AUTHOR_EMAIL=$(GIT_AUTHOR_EMAIL) \
		-D GIT_SMTP_SERVER=$(GIT_SMTP_SERVER) \
		-D GIT_SMTP_ENCRYPTION=$(GIT_SMTP_ENCRYPTION) \
		-D GIT_SMTP_SERVER_PORT=$(GIT_SMTP_SERVER_PORT) \
		-D EDITOR=$(EDITOR) \
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
	$(Q)for i in $(GIT_FILES); do \
		$(call cmd_install_many) -D -m 644 $$i $(DESTDIR); \
	done

.PHONY: install-lesskey
install-lesskey: $(DESTDIR)/.lesskey ## install less-key(1) bindings file
$(DESTDIR)/.lesskey: less/.lesskey
	$(call cmd_install_one) -m 644 $< $@
	$(Q)lesskey

.PHONY: install-bin
install-bin: $(bindir) ## install user scripts
	$(Q)mkdir -p -- $@
	$(Q)for b in $(shell find ./bin -type f); do \
		install -m 744 $$b $(bindir); \
	done

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
	system.vim

VIM_SRCS := $(addprefix $(VIMDIR)/, $(VIM_SRCS))
VIM_SRCS += $(VIMRC)

install-vim: ## install vim runtime
	$(Q)for i in $(VIM_SRCS); do \
		$(call cmd_install_many) -D -m 644 $$i $(DESTDIR)/$$i; \
	done

GPG_FILES = gnupg/gpg.conf \
			gnupg/gpg-agent.conf

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

.PHONY: install-mycnf
install-mycnf: $(DESTDIR)/.my.cnf ## install mysql config
$(DESTDIR)/.my.cnf: mysql/.my.cnf
	$(call cmd_install_one) -m 644 $< $@

.PHONY: test
test: ## run shellcheck tests on scripts
	@./test.sh

.PHONY: install
install: $(TARGETS)

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
