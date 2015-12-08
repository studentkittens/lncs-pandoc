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

The YubiKey was developed and manufactured by Yubico. In autumn 2015 the *YubiKey
4* was released, the 4th generation since the foundation of Yubico in 2007.
In order to understand the whole concept of YubiKey a few basics are shown in the
next steps.

## Two-factor authentication

Two-factor authentication consists of something you know and something you
have
[(see, Fig. 1)](# [Concept of two-factor authentication.).
The first factor is usually a username and password. The second factor is a
physical token, in this case the YubiKey.

![Concept of two-factor authentication.](img/2fauth.png)



## Acts like a USB keyboard

The basic idea is that YubiKey acts like a keyboard when it is plugged into a
USB port. Which means there is no need for additional drivers or client
software. The YubiKey will be identified as a standard USB Human Interface
Device (HID). Therefore it is possible to use the native system drivers. 
Furthermore no battery is needed. Similar to any other USB keyboard the
YubiKey is a USB 1.0/2.0 device[@manual chapter 2]. 



## The hardware token

The size of the YubiKey is 18mm x 45mm x 3mm and the weight is 3 gram.
Which means it is a very light weight device. The used material is crush- and
water-resistant. [Figure 2](#token) shows the YubiKey. There is a touchbutton in
the middle of the YubiKey. It is a solid-state capacitive touch sensor which means it only
works with a human finger. The figure also shows the USB contacts and the
equipment to put it on a keychain.

There are five versions of YubiKey available (see table @tbl:demo). The
amount of
functions grows from the first YubiKey (YubiKey Standard) to the latest (YubiKey
4). A special one is the FIDO U2F[^Fido] which only works with U2F compliant
    applications. The features and funtions will be explained in
    [chapter 3](#functions). 
In addition there are YubiKeys much smaller than the
common size. It is called the *Nano* version.

![YubiKey – The hardware token.](img/yubi_outside_paper.png)

[^Fido]: FIDO = the open-authentication industry consortium
U2F = Universal Second Factor




<!-- ![The versions of YubiKey. From the first developed (*Standard*) to the latest
version (*YubiKey 4*).](img/versions.png)
-->


-----------------------------------------------------------------------------------------------------
                                YubiKey      YubiKey              YubiKey       YubiKey       YubiKey
Function                              4          Neo                 Edge      Standard      Fido U2F
--------------------------    ---------   ----------         ------------     ---------     ---------
Static Passwords              \ding{52}    \ding{52}            \ding{52}     \ding{52}     \ding{52}        
YubiKey OTP                   \ding{52}  
Smartcard (OpenPGP)           \ding{52} 
Fido U2F                      \ding{52} 
Online Applications           \ding{52}
-----------------------------------------------------------------------------------------------------

Table: YubiKey versions and some of their functions. {#tbl:demo} 




## How it works

Everytime the YubiKey is plugged into a USB port and the touch sensor is
pressed, it executes the configured function. For example it generates an
one-time password. The generating of one-time passwords will be explained in
part [3.1](#otpexplain). There are two slots which can be configured. The first slot can 
be accessed with a short press (0.3 - 1.5 seconds) and the second slot can be accessed
with a long press (2.5 - 5 seconds) [@manual chapter 4.1]. There is also an LED indicator signaling
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

<!--
+----------------------+----------------+-----------------+------------------+----------------------+--------------+
|                      |  **YubiKey 4** | **YubiKey Neo** | **YubiKey Edge** | **YubiKey Standard** | **Fido U2F** |
+======================+================+=================+==================+======================+==============+
|  Static Passwords    | \ding{52}      | \ding{52}       | \ding{52}        | \ding{52}            |  \ding{56}   |
+----------------------+----------------+-----------------+------------------+----------------------+--------------+
|  YubiKey OTP         | \ding{52}      | \ding{52}       | \ding{52}        | \ding{52}            |  \ding{56}   |
+----------------------+----------------+-----------------+------------------+----------------------+--------------+
|  Smartcard (OpenPGP) |  \ding{52}     | \ding{52}       | \ding{56}        | \ding{56}            |  \ding{56}   |
+----------------------+----------------+-----------------+------------------+----------------------+--------------+
|  Fido U2F            |  \ding{52}     | \ding{52}       |  \ding{52}       | \ding{56}            |  \ding{52}   |
+----------------------+----------------+-----------------+------------------+----------------------+--------------+
|  Online Applications |  \ding{52}     | \ding{52}       | \ding{52}        |   \ding{52}          |  \ding{52}   |
+----------------------+----------------+-----------------+------------------+----------------------+--------------+
-->



# Functions and Features {#functions}

The YubiKey offers various functions and features depending on its version (see
table @tbl:demo).
The major function is to generate one-time passwords. Because of this the one-time password
will be shown more detailed. Other functions are for example the static password, connection
via NFC [^NFC], smartcard or Fido U2F[^U2F]. 

[^NFC]: Near-Field-Communication


## One Time Password {#otpexplain}


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

The second part is the encrypted passcode. In the YubiKey Manual
[@manual] and YubiKey Security Evaluation [@security] the general concept of
generating this part of the OTP is described as follows:

Maltitude factors are combined to form a byte string. These factors are a
private ID, usage counter, timestamp, session usage counter, random number and
checksum. In the next step, the byte string is encrypted with a 128-bit
AES[^AES] key.
Additionally the now encrypted Hex-byte string is encoded to a ModHex string. That
was made to stay independent from language settings of the operating system.

The validation server receiving the string, [Fig. 4](#OTP) first converts it back to a byte
string. The next step is to decrypt the string with the same 128-bit AES key
used by the YubiKey for encrypting. After verifying the checksum and additional
fields, the received counter is compared with the stored one. If it is lower or
equal to the stored value on validation server, the one-time password is rejected.
Is the counter greater than the stored value, the one-time password is valid
and the received counter value is stored.

![OTP.](img/otp.png)

[^AES]: Advanced Encryption Standard



## Static Password

In the white paper *YubiKey Static Password Function* [@static] the developer of the
YubiKey delivers insight to the background of static passwords concerning the
YubiKey. Of course, static passwords are not as secure as one-time passwords but
not any application supports one-time passwords. For this reason the static
password function was implemented. It's an combination of 16 to 64 characters or
numbers. It is recommendable to combine the static password with a manually
added part. [Figure 5](#Static password) shows an example. The word *banana*
is manually added to the generated 16 chars static password.

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
Near-Field-Communication (NFC). Therefore it is possible to have easy to use
two-factor authentication with NFC-enabled smartphones. The YubiKey has only be
touched to the smartphone which acts as NFC reader. It depends on the
configuration and type of record but the most common one is the URI- and Text
type. Which means the YubiKey constructs a concatenation between a URI and a
generated one-time password [@manual chapter 7.2].

example?


**FIDO U2F**[^U2F]

U2F stands for *Universal Second Factor* and is an open authentication
standard. It was created by Yubico and Google, hosted by FIDO -- the
open-authentication industry consortium. Summarized could U2F explained an a
challenge-response protocol which works in the background. It is implemented
along the one-time password. The user does the same as it were a one-time
password application. There is a detailed technical description of U2F at the
developer sites on yubico.com [@u2f].


[^U2F]: Universal Second Factor

# Where to use the YubiKey

The YubiKey can be used for securing access to many applications. First Online
Applications and Password Managment seems to be the most interesting. Of course
there are many more applications, some of them will be mentioned.

## Online Applications

Everyone logging in to online applications wants to secure their private data
and identity. But every day online accounts were hacked, passwords and private data
were stolen. A lot of online applications already offers two-factor authentication to add an extra layer
of security. Some of them will
be presented in the following.


<!--
Facebook on its own had 233 million daily active users in third
quartal of 2015 in Europe [@statista]. Therefore and many other applications the
YubiKey offers an additional layer of security.

**Facebook**
It is also possible to login with the facebook
account to many other online applications. Which means in this case, stolen
access data can be used to access also other applications. Using the YubiKey
to login via facebook account secures the access to the data. Of course, facebook itself
is nevertheless collecting and using the data. That is a different matter.
-->

**Google**

Google promotes the login with only one username and password to all of their services.
If this username and password is stolen all services can be accessed and harmed.
Particularly in this case, two-factor authentication is very helpfull. Google offers
two-factor authentication with YubiKey via U2F standard.




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
[@configuration]. It is plattform independent. The following functions can
be configured: OTP (Yubico OTP and OATH-HOTP), Static Password and Challenge Response
Mode. To all of this functions there is a quick and an advanced configuration mode.
Furthermore the tool shows which slots are configured. The default value of slot 1
is to generate one-time passwords. But this can be configured as wanted. There is also an
overview of supported features.

Of course it is possible to configure the YubiKey with command line interface.
- Vielleicht eine Configuration zeigen? mit CLI und GUI?
- für smartcard extra tool


# YubiKey for Business

Enterprises have to handle the challenge to secure their data and systems.
On the one hand the YubiKey offers strong authentication and on the other hand,
it is very simple to use. Especially the simple to use concept is an important
factor for employees using the YubiKey every day.

There are many enterprises already using the YubiKey. For example Google is
using the YubiKey for all employees. Also Facebook is using it for several
applications. In an interview, John Flynn from Facebook annouced the situation
when employees wants to read their emails somewhere else than the office. So 
the employee is asked to tap on the YubiKey and ensures that nobody is breaking
in with a stolen password [@flynn]. CERN, the European Organization
for Nuclear Research is using the YubiKey for Secure Shell (SSH) and
single-sign-on (SSO) web portal. Remi Mollon of the CERN Computer Security Team
mentioned the open algorithm and the available open-source software support as 
one of the facts why CERN is using the YubiKey [@mollon].


## Possible applications

With the YubiKey the access to a lot of applications could be improved. In the
following are some of them mentioned.
 - Remote Access
 - Computer Login
 - Securing Servers
 - Password Management
 - Disk Encryption
 - Securing Cloud Solutions
 - Identity and Access Management
 - Securing mobile devices


## YubiKey Business Solutions

extra stations to configure more than one YubiKey
Administrator kann Zugriffe einsehen, recovery-codes etc.

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
