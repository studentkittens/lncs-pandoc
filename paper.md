---
documentclass: llncs
title: Filemanagement using git--annex
author: Christoph Piechula
institute: Hochschule Augsburg - University of Applied Sciences
email: "christoph.piechula@hs-augsburg.de"
keywords: git, file management, remote, backup, storage, encryption, annex
abstract: | 

        Today cloud storage services are all over the place. There is dropbox,
        google cloud, box.com and many other services. Important files also
        often gets backup to a local hard drive, to ensure access if the cloud
        service stops working. It is often hard for the user to implement
        a useful backup strategy and to track data saved in the cloud or local
        hard drive. A tool named git--annex is a possible solution to this
        problem. It also addresses other usual issues with  cloud security and
        data integrity in general. This paper intends to give a git--annex
        introduction by explaining the concepts behind git--annex and 
        demonstrating different use case scenarios and features of git-annex.
---


# Introduction

The demand on data access is growing day by day. Today a lot of user have
multiple devices like a pc,  a laptop, a tablet pc or a smart phone. It is also a
comfortable way to synchronize e.g. photos with friends or sensible documents
with co--workers. 

To keep all important files (e.g. documents, photos) in sync, a synchronisation
tool is needed. Cloud storage services are also often used as backup location
for private or commercial data. As devices are not inevitably connected directly
with each other, a cloud storage service is used as a intermediary. Widely used
cloud storage service providers are Dropbox, Box.com, Google Drive, Apple iCloud
and Microsoft OneDrive [^storageproviders].

There are known issues with cloud storage services which may cause data loss
[^dataloss] or unauthorized access [^unauthorizedaccess] to private data. Your
data also might be unaccessible when a provider gets taken down by the FBI
because of piracy allegations [^piracy]. Another point is that the user doesn't
know if his private or commercial data gets encrypted properly. Also there might
be a privacy issues because of PRISM [^prism]. Usually there is always the
problem with most of the cloud storage services provides that used tools and
methods are not transparent.

To keep data nevertheless accessible and secure backups and the use of
encryption is advisable. When backing up data, one should always bear in mind
that hardware is also very error prone [^ramhdd], [^bitrot].

To sum up, just doing a backup is not enough to keep data safe and secured. It
is also necessary to check the data's integrity (checking if data is
unchanged/valid). Therefor a backup and restore strategy (validating the
integrity of data) is needed.

There are numerous ways check or ensure data integrity. One possibility would be
to use filesystems like `ZFS` or `BTRFS` which by itself ensure that your data
doesn't get corrupted. These filesystems have the ability to detect and avoid
avoid data corruption [^dataintegrity]. Another possibility to identify data
corruption is by checksumming [^checksum] the data. 

To keep the data secured and avoid unauthorized access encryption a proven
standard encryption should be used [^dataencryption]. 

To implement above backup strategy usually different tools are needed. Another
concept that also intends to deal with the issues above is `git--annex`. It is a
tool for file synchronisation and archival purposes. This paper aims to give a
introduction to the `git--annex` basics and its core features.



# Git--annex overview

## Project details

The tool named `git--annex` is a tool that aims to synchronize one's data while
addressing all the issues that automatically come with cloud storage services
and hardware.

`Git--annex` was started as a crowd funding project by Joey Hess, former Debian
GNU/Linux developer. Targeting the project at \$3.000 it reached over \$20.000
within a few hours. `Git--annex` is written in Haskell, a functional programming
language. It has been written in Haskell and not as a *script*-tool as Joey Hess
wanted to provider a decent and stable tool with a decent test suite.

Git annex is a free software tool (free and open source) on top of git. Git is a
``distributed`` version control used by developers to mange source code.
However, git is not suitable for big binary data as it is calculating
differences for all file changes and storing the complete history of a file that
changes. This allows the developer to ,,rollback" the source code state to a
previous version. Doing this with big binary data the repository becomes very
large.

`Git--annex` addresses this problem by only managing the files meta data within
git. While this might seem paradoxical for the first moment, is has a lot of
advantages to do so with files which cannot be handled with git by itself.
Primary `git--annex` is developed as a command line tool. In the meantime there
is also a fancy web-based GUI that allows the non-technical user to use
`git--annex` for file synchronization in a comfortable way like using e.g. the
Dropbox--Client.

## Distributed file synchronisation concept

    * pics

## Alternatives

Alternatives:

    * git media -> only manual sync
    * tool for distributed usage needed -> different online and offline
      storage, encryption, os support (windows, mac, linux)
    * git annex does not check content into git


## Git annex essentials

The `git-annex` concept is based on usual `git` repositories. Meta data is
synchronized between repositories. A repositories is the place where a copy of
your meta data is stored. As `git` works in a distributed way, `git-annex` is
able to share files across different repositories also in a distributed way,
compared to the usual way using cloud storage provider, where usually a
centralized approach is used. For more information about `git` see, [^git].

A `git`-repository is containing a `.git`-folder which contains information
about the repository like, available remotes, user identity and so on. For a
complete list see [^dotgit]. `Git-annex` extends this folder structure by adding
a `annex` folder to it. In this location `git-annex` related information is hold.

When adding a file to `git-annex`, the file gets moved to the
`.git/annex/objects/`-folder and a symbolic link to the data is created by
default. This is a `git-annex` feature to avoid unwanted manipulation of the
data. The filename itself is renamed in a way which name represents the
cryptographic hash sum of the data itself. In this way the data might be
validated by `git-annex`. This behavior is called `git annex indirect`-mode.

As the symbolic link approach is not always a wanted behavior, there is also the
`git annex direct` mode. This mode is also used when symbolic links are not
supported by the filesystem, this is the case when using a filesystem like the
fat-filesystem. The `direct` mode is also used by the `git annex assistant`,
see[^assistant].

The repository and remote configuration itself is saved inside the `.git/config`
file. This file is provided by `git` and extended by `git-annex` for its
purposes. A repository is represented by a unique id (UUID), a typical extended
`.git/config` file:


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

## Commandline usage 

### Creating a git-annex repository

To initialize a `git-annex`-repository first you have to initialize a
`git`-repository. The complete procedure looks as the following shell session
demonstrates:

~~~sh
    $ git init 'repositoryname'
    $ cd 'repositoryname'
    $ git annex init 'annex-repository-name'
~~~

The created `git`-repository now may be modified using the usual `git`-commands.
Adding a remote repository for synchronization can be achieved by running the
`git remote add <repo-name> <repo-path>` command.


### Adding files to a git-annex repository

All data manipulation commands are related to the `git-annex`-command set. A
complete procedure looks this way:

~~~sh
    $ git annex add filename.ext
    $ git commit -m 'file added.'
~~~

### Synchronizing repository with remotes

After adding files to a repository the metadata is updated with the ,,connected"
repositories (remotes) by pulling changes from the wanted remote and pushing
current changes to the remote. 

~~~sh
    $ git annex pull <remotename>
    $ git annex push <remotename>
~~~

This is the way synchronization is realized when using `git` or `git-annex`.

Committing files on every change might seem very uncomfortable, because of the
reason there is a monitoring daemon included in `git annex`. To automate the
complete procedure the daemon can be started by running `git annex watch`. Now
all files added to the directory are committed automatically. 


### Git-annex assistant

The assistant tool allow `git-annex` to implement a completely automated
synchronization the way like Dropbox Client similar synchronisation tools work.
By default only metadata is synchronized. Applying the `--content` option to the
git annex assistant client will tell `git-annex` to synchronize the content too.

### Git-annex webapp

The webapp of `git-annex` is a part of the `git annex assistant`. It allow the
configuration and management of repositories and remotes in a user friendly way.

# Git-annex features

## Repository Groups

`Git annex` introduces `repository groups` as a way to specify the behaviour of
a repository. Using `repository groups` gives the user more control about the
way how a repository behaves. For example if a repository is used as a *backup*
repository, all synchronized files get accumulated. There are also `repository
groups` for archival purposes. User repositories are usually  in the *client*
group. Repositories used to exchange between not directly connected devices are
typically in the *transfer group*. `Repository groups` can be controlled by
using `git annex vicfg`. For a complete list of `repository groups` see
[^repositorygroups].


## Remotes

`Git-annex` extends the `git` repository concept by introducing `special
remotes`. These remotes can by used like typical `git`-repositories,
`git`-commands however cannot be used. Typical special remotes are cloud storage
services like `Amazon S3` or `Box.com`. For a complete list of currently
supported special remotes by `git-annex` see, [^specialremotes]. Usually there
are three *types* of remotes, `special remotes`, `archive remotes` and `local
remotes` like USB drives. As `git-annex` follows a modular approach, there is
the possibility to *connect* `git-annex` to yet unsupported `special remotes` by
writing a extension. This can be done in three different ways. For more
information see [^ownremotes].

## Encryption

As data may be saved on untrusted cloud storage services by using `special
remotes`, `git-annex` support three different encryption concepts of encryption
to ensure privacy.

**Shared encryption** is the most simple way to implement encryption when using `git-annex`.
Using this encryption concept a *symmetric key* is generated and saved inside
the user repository. This is only a save approach if you trust all clones of
your repositories, as there is a copy of the encryption key to encrypt all data
saved on a `special remote`.

**Hybrid encryption** is the *recommended* way to encrypt when synchronizing
data with untrusted `special remotes`. When using *hybrid encryption*, the
symmetric encryption key is additionally encrypted with a *pgp* public key of a
user. This approach allows `git-annex` to use share a encrypted repository with
different user without sharing a common passphrase. 

**Public key encryption** is the third method that may by used to encrypt your
data. For details about *public key encryption* see, [^pgp].

## Repository trustiness levels

`Git-annex` supports different levels of *trustness*. By default repositories are
*semitrusted*. If a repository is *semitrusted* `git-annex` checks if the
minimum needed number of file copies is present when a file is dropped by the
user.

## Communication

For communication between `git-annex` repositories usually ``ssh`` (secure
shell) is used. File transfer is realized with the ``rsync``-tool [^rsync].
The ``XMPP``-protocol is used to communicate with repositories if a direct
connection is not possible, e.g. because of firewall restrictions.

There is also a local UDP based paring mechanism for the local network, this
mechanism is used by the `git annex webapp` as it needs user interaction
exchange a secrect key to pair repositories with each other.

## Prefered content

This option gives the user the ability to configure which content to be
managed within a repository by *including* or *excluding* different filetypes.

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

[^dataloss]: http://www.zdnet.com/dropbox-sync-glitch-results-in-lost-data-for-some-subscribers-7000034610/ 
[^unauthorizedaccess]: http://www.cnet.com/news/dropbox-confirms-security-glitch-no-password-required/ 
[^storageproviders] http://www.tomshardware.com/reviews/cloud-storage-provider-comparison,3905.html
[^piracy] http://techcrunch.com/2012/01/19/megaupload-taken-down-on-piracy-allegations/
[^prism] http://www.cnet.com/news/what-is-the-nsas-prism-program-faq/
[^ramhdd] https://blog.codecentric.de/en/2013/11/hardware-will-fail-just-way-expect/ 
[^bitrot] http://en.wikipedia.org/wiki/Data_degradation 
[^dataintegrity] http://en.wikipedia.org/wiki/Data_integrity 
[^checksum] http://en.wikipedia.org/wiki/Checksum 
[^dataencryption] http://en.wikipedia.org/wiki/Encryption
[^dotgit] http://gitready.com/advanced/2009/03/23/whats-inside-your-git-directory.html 
[^assistant] Assistant ref
[^git] http://git-scm.org
[^specialremotes] http://git-annex.branchable.com/special_remotes/
[^rsync] http://en.wikipedia.org/rsync
[^ownremotes] http://en.wikipedia.org/rsync
[^pgp] http://en.wikipedia.org/pgp
