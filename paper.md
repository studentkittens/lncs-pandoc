---
documentclass: llncs
title: Docker -- Application containers and sandboxing
author: Christopher Pahl
institute: University of applied science Augsburg
email: "christopher.pahl@hs-augsburg.de"
keywords: docker, deployment, container, sandbox
abstract: | 

    Docker is a new approach to deployment targeted at making distributing
    software easier and faster. Instead of true hardware virtualization,
    software is run in containers which are easily reproducible and can be
    versioned. The containers can be easily exchanged either raw of over
    a common platform like DockerHub. Besides deployment, docker can be used
    for tasks like sandboxing, creating testbeds for small to large
    applications and generally as an alternative for many usecases where
    hardware virtualization was used previously.
...


# Introduction

The task of software deployment is still considered as very hard by many
distributors. Modern software is characterized by relying on many external,
heterogeneous components (e.g. external libraries or databases) which will be
called dependencies hereafter. While this is a good for preventing the
reimplementation of already solved problems, the dependencies may change
drastically themselves over time. This makes it very hard for all parties to
maintain a consistent, working state.

Since dependencies are developed by their own respective developers, changes can
result in broken APIs which result in broken compilations or in more subtle
changes where the API stays the same but behaves slightly different. In any case
the software will be broken under certain circumstances, causing bug reports by
the user. The exact circumstances where the error occurs is often hard to
reproduce for the developer, often leading to a ``cannot reproduce`` state of
the bug report.

Many developers are not fully aware of these difficulties. The software is
either distributed as binary blob for proprietary software or as source code
archive for Open Source Software (ref). In the first case the user has only a
slight chance of getting the software working when he has incompatible
dependencies. In the latter case the user is able to compile the software
himself, possibly using the correct, working dependency. But in both cases the
problem is shifted to the user of the software, while this is a clear problem of
the original developer, especially if he is offering his product in a commercial
way.

# Application Containers

In Marc 2013 ``Docker`` was released by *dotCloud* (a Platform as a Service
company). The application, which is written entirely in Google's programming
language *Go*, soon gathered attention from many large companies including
Microsoft, IBM and others since they have seen ``Docker`` as a promising
solution to the problems described above. 

Docker is in it's core a program that makes it possible to run applications in
*containers*. In this case, a container always consists of an operation system
image and of the application that is supposed to run in it.

Images are usually stripped down linux distributions [^windows], with all 
unnecessary packages removed -- this includes for example the ``X.org`` display
server, making it not possible to run gui applications inside of images by
default. These images are often called *base images*, to indicate that we are
supposed to create our own version based on them.

Applications that run inside of the container have a full copy of the filesystem
in the image which they can modify at will. By default, the application has no
way of accessing the host's resources, since the kernel of the host starts all
*dockerized* application in a new *namespace*. This allows the container
application to have their own process ids, hostname, mount points and IPC
primitives. 

All communication of the containers are done internally via the docker daemon
``dockerd``, which is a system service that run on the host system and handles
all containers on a single system.

[^windows]: This could change soon with the upcoming windows support. 

## Workflow

In order to pack an application inside of an container one has two options:

1) Download one of the many base images from *DockerHub* and modify it by
   running a shell inside of it. Inside this shell it is possible to modify 
   the container to the developer's needs. For example, he might use the linux 
   distribution's package manage in order to install a webserver (the
   dependency), his application that runs on top of it and possibly populates
   a database with the data needed for the application.
2) The above method is tedious if many containers need to be created, all of
   them with minimal configuration changes. In this case this process can be
   automated via a so-called ``Dockerfile``. A ``Dockerfile`` is basically a
   list of commands needed to reproduce the container from a base image (which
   must be stated on the first line). The image can be built with a single 
   docker command that pulls the base image and applies each command on it
   automatically. With small amounts of scripting it is possible to create 
   slightly different configurations for every build.

While the second option is a lot mightier and faster on the second run, the
first one is the default for many usecases. Following a short demonstrative
commandline session is given to illustrate the said:

TODO: Add versioning/daemon / single-process-container-best-practice

```bash
$ docker images  # List all available images on the host
REPOSITORY   TAG         IMAGE ID      CREATED       VIRTUAL SIZE
fedora       latest      7d3f07f8de5f  9 weeks ago   374.1 MB
base/arch    2014.04.01  a64697d71089  7 months ago  277.1 MB
base/arch    latest      a64697d71089  7 months ago  277.1 MB

# Specify the image and the application (echo here) to create a container
$ docker run base/arch echo "hello world"
hello world

# Run an shell inside the container, 
# -i means "catch stdout", 
# -t means "create a tty for the shell"
$ docker run -i -t base/arch bash
> echo "hello world"
hello world

TODO
```

## Technical aspects


TODO: Insert techical dia

The biggest difference to other commonly used techniques is that all
applications run on the same operating system, which means on the same kernel,
but with a different userspace. This allows the sandboxed application to
directly access the hardware over a thin layer of linux kernel techniques. This
lies contrast to true hardware virtualization where a whole new kernel is
started on emulated hardware.

This thin layer is ``cgroups``. It allows the grouping of processes and creating
the already mentioned namespaces for them. Additionally it is possible to
configure the ressources that a group of processes may use in a fine-grained
way. All processes in a docker container run in such a process group, therefore
every container can be configured in the same way.

Since ``docker`` containers are versioned, containers need a way to write their
changes into a staging area, so the original container is not modified until the
developer decides he wants to commit his staged changes. For this purpose
``docker`` uses a overlay filesystem. ``Docker`` can use both ``aufs`` or
``btrfs``. ``aufs`` for example provides a read- and writable overlay over a
normal filesystem which is only readable through ``aufs``. All written changes
are cached until a synchronization is requested.

In order to make ``docker`` easily extendible and controllable, the tool is
split up in a daemon called ``dockerd`` and ``docker clients`` which are usually
the commandline ``docker`` utility and also each application container.
This split up also allows a clean language agnostic extension approach since 
all communication goes over a defined network protocol. Therefore it is easily
possible  to develop remote control software that is able to list all
containers, show statistics of them and to start or stop them. The open source 
webtool ``Shipyard`` (TODO) is an example for such a remote control.


## Difference to other systems

There are many other technologies on the market that have a similar feature set
to ``docker`` but may work differently. Two of these technologies are shown in a
small comparison here:

- **LXC:** A linux kernel technique that also uses ``cgroups`` to do operating
  system level virtualization. 
- **FreeBSD jails:** A very powerful alternative on *FreeBSD* 
- **chroot:** Very traditional and common tool for having nested filesystems
  with different shells in it.


TODO.

Summary:



## Features

Until now we only had simple cases where only a single application runs inside a
container. But real server software usually comes in many parts. For example one
database backend, one analyzer engine, one webserver and many more small
applications in between. Even worse, those application need to communicate over
sockets, share data from a common mounted volume or just need to forward their
network ports to the outside. This is all possible though with the extended
features discussed in the following.

### Port forwarding

### Volumes

### Linking containers

# Use cases

## Deployment

This is the main usecase of ``Docker``. 

Short deployment example, DockerHub

## Sandboxed application testbeds

From a developer's point of view it is often needed to test an untrusted
application on real production data. While it's always possible to set up a test
server with a copy of the data is an tedious task. It is desirable to simply do
this work once and, if needed, to reset to the last working state. While this
might be possible with other techniques like snapshotting filesystems or *true*
hardware virtualization it is slow to restore the made damage compared to just
restarting the ``Docker`` container. 

```bash
$ docker run -i -t base/arch:latest bash
> rm -rf / # Simulate destructive application
> exit
$ docker run -i -t base/arch:latest bash
> ls   # Everything back.
bin  boot  dev	etc  home  lib	lib64  mnt  opt  
proc  root  run  sbin	srv  sys  tmp  usr  var
```

A related usecase: third party applications that cannot be trusted can be easily
executed inside a container. If they decide to do malicious actions the host
system cannot be compromised. An usage of this principle would be running a
browser inside of a ``Docker`` container to visit potentially unsafe websites
(e.g. with Adobe Flash). An implementation of this idea can be found here: 
https://github.com/jlund/docker-chrome-pulseaudio

## Package and cluster management

CoreOS

Recent News: Rocket.

# Conclusion

## Advantages

- Portability
- Low ressources, lightweight
- developer friendly
- commond standard

## Disadvantages

- cannot replace things like Virtualbox
- GUI Applications are hard. 
- still virtualization needed on unsupported operating system.

Criticism

## Summary

While ``docker`` is not a new technology by any means (operating system level
virtualization dates back to the last millenium) it is a welcome renaissance of
this old deployment technique. In contrast to it's competitors, ``docker`` makes it
painless to create working containers and *ship* them to the client side. Future
development might improve the current portability issues and might deliver
integration in other products. The development started in 2013 and still new
features come in a weekly rate. 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\newpage

# References
