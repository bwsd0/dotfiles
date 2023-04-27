[user]
    name = GIT_AUTHOR_NAME
    email = GIT_AUTHOR_EMAIL
    signingKey = KEY

[sendemail]
  smtpserver = GIT_SMTP_SERVER
  smtpuser = GIT_AUTHOR_EMAIL
  smtpencryption = GIT_SMTP_ENCRYPTION
  smtpserverport = GIT_SMTP_SERVER_PORT

[core]
    editor = EDITOR
    abbrev = 12

    # treat spaces before tabs, and all kinds of whitespace as an error
    whitespace = space-before-tab,-indent-with-non-tab,trailing-space
    precomposeUnicode = true
    excludesfile = ~/.gitignore_global
    attributesfile = ~/.gitattributes
    hooksPath = ~/b/dotfiles/git/templates/hooks

[init]
  defaultBranch = main

[grep]
    lineNumber = true
    column = true

[url "ssh://git@github.com/"]
    insteadOf = https://github.com/

[url "ssh://git@gitlab.com/"]
    insteadOf = https://gitlab.com/

[pretty]
    fixes = Fixes: %h (\"%s\")

[alias]
    ltree = log --graph --oneline --decorate --all
    l = log --pretty=oneline -n 20 --graph --abbrev-commit
    # show summary of authors with commit numbers
    authors = shortlog --summary --email --numbered

[diff]
    tool = vimdiff

[help]
    # auto correct and execute mistyped coommands
    autocorrect = 1

[merge]
    tool = vimdiff
    # include summaries in new merge commit messages
    log = true

[branch]
    autoSetupRebase = always

[commit]
    gpgsign = false

[gpg]
    program = gpg2

[gpgv]
    program = gpgv2

[tag]
    # always sign annotated tags
    forceSignAnnotated = true
