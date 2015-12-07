---
documentclass: llncs
header-includes:    
    - \usepackage{color}
    - \usepackage{pifont}
title: YubiKey - Technology and Applications
author: Susanne Kießling-- \today
institute: Hochschule Augsburg -- University of Applied Sciences
email: "susanne.kiessling@hs-augsburg.de"
keywords: YubiKey, two-factor-authentication, Token, Password, Security
abstract: | 
        Security of passwords and authentication issues in general are issues
        of high importance. Nevertheless a huge rate of passwords isn't secure
        enough and could be.
---

\pagestyle{plain}

# Introduction

In almost every authentication process a password is required. There are a lot
of services and applications with password authentication and the amount of
passwords to remember increases continuously. Unfortunately in many cases 
the chosen passwords aren't secure enough. Which means they can be cracked
e.g. by dictionary attacks. But even if you have chosen a secure password there
are other risks e.g. the service it is for could leak it. At this point
two factor authentication could be a security improvement. Two-factor
authentication in general consists of something you know and something you have.
The YubiKey is a hardware token for two-factor authentication. It's the physical
part within the two-factor authentication. In comparision to other two-factor
authentication solutions the YubiKey has some advantages. Besides that, the
paper will give an overview of the various use cases, explains the basic concepts
and introduces the hardware of YubiKey. Furthermore companies use the YubiKey to
protect their data and systems. This point also will be covered in the paper.
Bruce Schneier, on Schneier on Security [@bruce].


[^ZFS]: A combined file system and logical volume manager designed by Sun Microsystems
[^BTRFS]: ,,B-tree FS" A copy-on-write linux file system with similar features
to zfs


# Basic information

The YubiKey was developed and manufactured by Yubico. In autumn 2015 the YubiKey
4 were released, the 4th generation since the foundation of Yubico in 2007. For better understanding the whole idea and the basic concept of the
YubiKey, some basics will be explained.

## Two-factor authentication

Two-factor authentication consists of something you know and something you have.
[Fig. 2](# [Concept of two-factor authentication.)
The first factor is usually an username and password. The second factor is a
physical token, in this case the YubiKey.

![Concept of two-factor authentication.](img/2fauth.png)


## Acts like a USB keyboard

The basic idea is that YubiKey acts like a keyboard when it is plugged into a
USB port. Which means there is no need for additional drivers or client
software. The YubiKey will be identified as a standard USB Human Interface
Device (HID). Therefore it's possible to use the native system drivers. 
Furthermore no battery is needed. 



## The hardware token

The size of YubiKey is 18mm x 45mm x 3mm and the weight is 3 gram.
Which means it's a very light weight device. The used material is crush- and
water-resistant. Figure [Fig. 3](#token) shows the YubiKey. There is a touchbutton in
the middle of the YubiKey. It's a capacitive touch sensor which means it only
works with a finger. One of the advantages the YubiKey has. There are five versions
of YubiKey available. In addition there are YubiKeys much smaller than the
common size. It's called the Nano version. The following
table shows the different versions of YubiKey. A more detailed table could be
find on ......


![token](img/yubi_outside_paper.png)


## How it works

Everytime the YubiKey is plugged into an USB port and the touch sensor is
pressed, it executes the configured function. For example it generates an
one-time password. The generating of one-time passwords will be explained in
part XXXXX. There are two slots which can be configured. The first slot can 
be accessed with a short press (0.3 - 1.5 seconds) and the second slot can be accessed
with a long press (2.5 - 5 seconds). There is also an LED indicator signaling
the current state of the YubiKey. If the YubiKey is ready to work there is a
steady green light. A rapidly flashing light means some kind of error.

<!--
MICRATHENE
MICRATHENE
MICRATHENE: Versuche mal mit den Virtuellen Desktops von Gnome zu arbeiten um
dich nicht so mit dem hin und her klicken zu verwirren alt + strg + pfeil oben | unten
Und auf dem linken Bildschirm hast du dein PDF, kannst du auch auf n Virtuellen
Desktop tun!

MICRATHENE!!! nicht vergessen dann :set filetype=pandoc zu machen nachdem du die
tabelle bearbeitet hast!
-->


+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
|                       |  **YubiKey 4**            | **YubiKey Neo**          | **Fido U2F**              | **YubiKey Edge**          | **YubiKey Standard**       |
+=======================+===========================+==========================+===========================+===========================+============================+
| *Static Passwords*    |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{red}{\ding{56}}   | \color{green}{\ding{52}}  | \color{green}{\ding{52}}   |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *YubiKey OTP*         | \color{green}{\ding{52}}  | \color{green}{\ding{52}} |  \color{red}{\ding{56}}   | \color{green}{\ding{52}}  | \color{green}{\ding{52}}   |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *OATH - HOTP*         |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{red}{\ding{56}}   | \color{green}{\ding{52}}  | \color{green}{\ding{52}}   |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *OATH - TOTP*         |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{red}{\ding{56}}   | \color{green}{\ding{52}}  | \color{green}{\ding{52}}   |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *PIV*                 |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{red}{\ding{56}}   | \color{red}{\ding{56}}    | \color{red}{\ding{56}}     |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *OpenPGP*             |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{red}{\ding{56}}   | \color{red}{\ding{56}}    | \color{red}{\ding{56}}     |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *Fido U2F*            |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{green}{\ding{52}} |  \color{green}{\ding{52}} | \color{red}{\ding{56}}     |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *Secure Element*      |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{green}{\ding{52}} |  \color{green}{\ding{52}} | \color{red}{\ding{56}}     |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+
| *Online Applications* |  \color{green}{\ding{52}} | \color{green}{\ding{52}} |  \color{green}{\ding{52}} |  \color{green}{\ding{52}} |   \color{green}{\ding{52}} |
+-----------------------+---------------------------+--------------------------+---------------------------+---------------------------+----------------------------+



# Functions and Features
 
## One Time Password

Generating one-time passwords (OTP) was the basic function in early days of the
YubiKey. Each one-time password works only once. With the YubiKey it is possible to use three
different implementations of one-time passwords. On the one hand the YubiKey
OTP, developed by Yubico. On the other hand OATH-HOTP and OATH-TOTP, both
open authentication standards specified by OATH, the Initiative for Open Authentication. At this point the
paper will go into detail on the YubiKey OTP. 

A touch on the integrated sensor triggers the one-time password generation.
Figure [Fig. 3](#OTP output) shows the output of touching the YubiKey. The
one-time password consists of two major parts, the YubiKey ID and the encrypted
passcode. The YubiKey ID identifies a YubiKey, it is unique and never changes.


![OTP output.](img/otp_output.png)

The general concept of generating YubiKey OTPs is described in the YubiKey Manual
[@manual] and YubiKey Security Evaluation [@security] as follows:

Maltitude factors are combined to form a byte string. These factors are a
private ID, usage counter, timestamp, session usage counter, random number and
checksum. In the next step, the byte string is encrypted with a 128-bit AES key.
Additionally the encrypted Hex-byte string is encoded to a ModHex string. That
was made to stay independent from language settings of the operating system.

The validation server receiving the string, [Fig. 4](#OTP) first converts it back to a byte
string. The next step is to decrypt the string with the same 128-bit AES key
used by the YubiKey for encrypting. After verifying the checksum and additional
fields, the received counter is compared with the stored one. If it is lower or
equal to the stored value on validation server, the one-time password is rejected.
Is the counter greater than the stored value, the one-time password is valid
and the received counter value is stored.




![OTP.](img/otp.png)


## Static Password

In the white paper *YubiKey Static Password Function* [@static] the developer of the
YubiKey delivers insight to the background of static passwords concerning the
YubiKey. Of course, static passwords aren't as secure as one-time passwords but
not any application supports one-time passwords. For this reason the static
password function was implemented. It's an combination of 16 to 64 characters or
numbers. [Fig.](#Static password) 


![Static password.](img/static_pw.png)

## Further functions and features

**Smartcard (OpenPGP)**
The latest versions of YubiKey presents itself to the host not only as USB devices, it
supports also smartcard functions via CCID. An applet in the context of
data security is for
example to store OpenPGP keys. PGP stands for Pretty Good Privacy and is an
open standard for encrypting emails, signatures and authentication. Additionally
the stored PGP keys can be secured with an PIN.


**Near-Field-Communication (NFC)**
YubiKey in the version *Neo* supports connection via
Near-Field-Communication (NFC). 


**Fido U2F**



# Where to use the YubiKey

The YubiKey can be used for securing access to many applications. Online
Applications and Password Managment seems to be the most interesting. Of course
there are many more applications, some of them will be mentioned.

## Online Applications

Everyone logging in to online applications wants to secure their private data
and identity. Facebook on its own had 233 million daily active users in third
quartal of 2015 in Europe [@statista]. Therefore and many other applications the
YubiKey offers an additional layer of security.

**Facebook**
It is also possible to login with the facebook
account to many other online applications. Which means in this case, stolen
access data can be used to access also other applications. Using the YubiKey
to login via facebook account secures the access to the data. Of course, facebook itself
is nevertheless collecting and using the data. That is a different matter.


**Google**


**Dropbox**


**GitHub**


## Password Management

To manage passwords especially strong passwords which are not easy to remember,
there are applications called password manager. But also the password manager
needs to be protected with a strong password. In this case, the YubiKey
offers an extra layer of security.

**LastPass**

**KeePass**

## Other Applications

**Disk Encryption**
**System-Login**

# Configuration

To configure the YubiKey there is a tool called *YubiKey Persolization Tool*
[@configuration]. It is plattform independent. 
Also configuration with command line interface (CLI) is possible.
- Vielleicht eine Configuration zeigen? mit CLI und GUI?
- für smartcard extra tool


# YubiKey for Business

- have to handle the challenge: securing data and systems
- securing mobile devices


- extra stations to configure more than one YubiKey
- Administrator kann Zugriffe einsehen, recovery-codes etc.

[^gcrypt]: Encryption tool for git repositories, https://github.com/bluss
[^gpg]: GNU Privacy Guard, a free tool that implements public key cryptography


# Conclusion 

comparison to antoher 2FA
As discussed at the beginning of the paper, it's worth to be
considering to use two-factor authentication. YubiKey
Two-factor authentication with a YubiKey makes your login secure and keeps your
information private. 

\newpage

# References
