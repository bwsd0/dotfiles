[user]
    name = GIT_AUTHOR_NAME
    email = GIT_AUTHOR_EMAIL
    signingKey = KEY

[sendemail]
	smtpserver = smtp.gmail.com
	smtpuser = GIT_AUTHOR_EMAIL
	smtpencryption = tls
	smtpserverport = 587

[core]
    editor = EDITOR
    abbrev = 12

    # treat spaces before tabs, and all kinds of whitespace as an error
    whitespace = space-before-tab,-indent-with-non-tab,trailing-space
    precomposeUnicode = true
    excludesfile = ~/.gitignore
    attributesfile = ~/.gitattributes
    hooksPath = ~/dotfiles/git/templates/hooks

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
