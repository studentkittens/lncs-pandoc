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
        often gets backup to  a local hard drive, to ensure access if the cloud
        service stops working. It is often hard to keep track of all files by
        using multiple backup strategies. A tool named git--annex is a possible
        solution to this problem. It also addresses other common problems like
        security and data integrity. This paper intends to give a git--annex
        introduction by demonstrating different use case scenarios and
        git-annex features.

---


# Introduction

Git--annex is a free software application for ,,distributed file management". 

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


# Git--annex remotes

* Special Remotes, Dropbox, Google Cloud etc
* Archive Remotes, Amazon Glacier
* USB Drives

* own remotes possible by providing interfaces

# Features

* excluding filetypes

# Repository Groups

* all content, excludes archive dir


# Security

* repository trust
* encryption
* adding number of min copies

## Encryption

* hybrid
* shared
* none

## Additional features

* data integrity -> fsck
* git annex watch, assistant, webapp

## Misc

* Collision handling
* Test-Suite
* end to end encryption for cloud services
* videos and good introduction

## Conclusion

* nice tool


# References
