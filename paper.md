---
documentclass: llncs
title: Filemanagement using git--annex
author: Christoph Piechula
institute: Hochschule Augsburg
email: "christoph.piechula@hs-augsburg.de"
keywords: git, file management, remote, backup, storage, encryption, annex
abstract: | 

        Today cloud storage services are all over the place. There is dropbox,
        google cloud, box.com and many other services. Important files also
        often gets backup to a local hard drive, to ensure access if the cloud
        service stops working. It is often hard to keep track of all files by
        using multiple backup strategies. A tool named git--annex is a possible
        solution to this problem. It also addresses other common problems like
        security and data integrity. This paper intends to give a git--annex
        introduction by demonstrating different use case scenarios and
        git-annex features.

---


# Introduction

* Git--annex is a free software application for ,,distributed file management". 
* Cloudservices dealing with security issues. Unauthorized data access by third
  party possible. Dataloss when cloud service provider gets shutdown by the
  authorities.
* NSA/PRISM scandal
* It is comfortable to have files synchronized on different different devices.
  Have synced folders.
* There are different tools like rsync, robocopy, one could write a script to
  backup stuff.
* Git annex is a tool that tries to stay comfortable while handling different
  scenarios of todays infrastructure.
* Idea why jhess wrote git annex.

* Cloud funding project
* joey, debian
* git based, git is bad for big data
* written in Haskell
* reports
    * http://www.engadget.com/2014/10/13/dropbox-selective-sync-bug/
    * http://techcrunch.com/2011/06/20/dropbox-security-bug-made-passwords-optional-for-four-hours/
    * http://www.h-online.com/security/news/item/Dropbox-left-login-door-open-for-4-hours-1264195.html

* Why should we trust cloud services?
* git--based, git tracks complete history, binary files not recommended

* Usually there is not problem to have different devs like phone, tablet,
  laptop, desktop... but...data is not always avaiable. One may use dropbox but
  th ere are issuses with data security and availability.

* Data may be stored locally on usb drive, fileserver or cloud service.
* Problem: Broadcast network not always available
* Dropbox/Box.com? client tools? -> Stored unencrypted? Password problem, data
  deletion problem. Files might be accessed by service providers or others. ->
  Methods not transparent.

* distributed file Sync possible with git -> Git not suitable for large files. 
* Git annex to strore music, movies, pictures, binary documents
* 10gb data, git needs 10 gb more space?

Alternatives:

    * git media -> only manual sync
    * tool for distributed usage needed -> different online and offline
      storage, encryption, os support (windows, mac, linux)
    * git annex does not check content into git

## Git annex essentials

* files saved into .git/annex folder als unique UUID and symlink'ed
* repositories and remote information saved in .git/config

~~~
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[annex]
	uuid = 59a11cf0-0c01-4298-bb94-71c6593caa5b
	version = 5
[remote "temp"]
	url = /tmp/gannex
	fetch = +refs/heads/*:refs/remotes/temp/*
	annex-uuid = b6e1928e-af46-4478-88e1-d17882fdc9f7
~~~

# Git--annex remotes

* repository modes -> indirect, direct (used by assistant), direct mode is
  also used on filesystems that does not support symlinks
  * no git status or git commit in direct mode git annex [command] 

* repo trustiness setable

## Communication

 * ssh to communicate with remotes encrypted
 * file transport done by rsync
 * xmpp to communicate if remotes not connected directly (unsafe?)
 * Pairing UDP based -> cloning repos to devices in local net, with secret
   key -> if connected -> ssh

History of git annex:

    * jhess, why developed? needet tool to sync lot of data in a small time
      slot -> Kickstarter Project, already two times?
    * no script, binary with decent testsuite
    * written in haskell -> auf flo referenzieren
    * GPL, free software, may be used in commercial environment


## Special remotes

* git remotes extended by special remotes. Key-Value remotes. This
  modification allows to use non git remotes and services like dropbox, box.com
as remotes.
* three different remote types

* Special Remotes, Dropbox, Google Cloud etc
* Archive Remotes, Amazon Glacier
* USB Drives

* own remotes possible by providing interfaces

# prefered content

* include, exclude filtype


# Features

* excluding filetypes

# Repository Groups

* all content, excludes archive dir
* set with git annex vicfg


# Security

* git annex does not trust semitrusted repos -> check is always done
* num of copies -> semitrusted repositories
* symlinks
* repository trust
* encryption
* lost repos cannot be deleted but marked as dead -> does not count into
  number of copies anymore
* trusted repos assumed to be save -> not checked

## Encryption

* restrict access or encrypt to obtain security
* GPG does encryption
* usually no encryption, everyone sees content that can access repository
* hybrid (recommended), adding keys later is possible, not possible to block person 
* share encryption key
* regular public key encryption and MAC
* none
* encrlypt remote git repositories with gcrypt

## Additional features

* data integrity -> fsck -> verifies checksum (sha1) -> corrupted data goes to .git/annex/bad
* git annex watch
* assistant, simplifies usage 
* webapp, simplifies usage
* whereis -> location tracking

## Misc

* Collision handling
* Test-Suite
* end to end encryption for cloud services
* videos and good introduction

## Conclusion

* nice tool


# References
