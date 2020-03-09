---
title:  dotme user guide
---

## NAME

**dotme** - manage environment driven by these "dot files".

## SYNOPSIS

**dotme [-h] [-vd]** [command]

## DESCIPTION

The **dotme** utility installs and configures a local computer environment based
driven by an opinionated set of "dot files". These "dot files" drive a commnon
configuration for tools like vim, tmux and brew. By running this on all local
environment you can ensure that all local environments worked on are the
configured the same.

Supported commands are as follows:

**brew**
: install brew dependencies

**clean**
: clean up caches

**compile**
: compile resource such as man files

**help**
: this help

**install** (default)
: install all configurations

**man**
: view these man files

**pull**
: update local configuration files from git source

**stow**
: stow the configuration files so that each tool picks up the desired
configuration.

**uninstall**
: unistall the dot file configuration, reversing some of the steps made during
installing. Note that this is not a complete reversal, for example applications
installed with brew will remain.

**unstow**
: reverse of the **stow** operation

**update**
: update packages already installed, e.g. brew packages

## OPTIONS

-h
: this help

-v
: verbose mode

-d
: dry run
