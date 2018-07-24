---
layout: default
lang: en
title: download
---
{% assign gura_version = '0.7.0' %}
{% assign gura_version_prev = '0.6.2' %}

# Download

Release notes are available [here](https://github.com/gura-lang/gura/releases).

## Latest Version

<table class="table table-striped">

<tr>
<td>Windows Installer</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-win32.msi"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-win32.msi');">gura-{{ gura_version }}-win32.msi</a></td>
</tr>

<tr>
<td>Windows Binary</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-win32.zip"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-win32.zip');">gura-{{ gura_version }}-win32.zip</a></td>
</tr>

<tr>
<td>Mac OS X Disk Image</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}.dmg"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}.dmg');">gura-{{ gura_version }}.dmg</a></td>
</tr>

<tr>
<td>Sorce Package</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-src.tar.gz"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-src.tar.gz');">gura-{{ gura_version }}-src.tar.gz</a></td>
</tr>

</table>

## Previous Version

<table class="table table-striped">

<tr>
<td>Windows Installer</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version_prev }}/gura-{{ gura_version_prev }}-win32.msi"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version_prev }}-win32.msi');">gura-{{ gura_version_prev }}-win32.msi</a></td>
</tr>

<tr>
<td>Windows Binary</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version_prev }}/gura-{{ gura_version_prev }}-win32.zip"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version_prev }}-win32.zip');">gura-{{ gura_version_prev }}-win32.zip</a></td>
</tr>

<tr>
<td>Mac OS X Disk Image</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version_prev }}/gura-{{ gura_version_prev }}.dmg"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version_prev }}.dmg');">gura-{{ gura_version_prev }}.dmg</a></td>
</tr>

<tr>
<td>Sorce Package</td>
<td><a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version_prev }}/gura-{{ gura_version_prev }}-src.tar.gz"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version_prev }}-src.tar.gz');">gura-{{ gura_version_prev }}-src.tar.gz</a></td>
</tr>

</table>

# Installation

## Windows

It has been confirmed that Gura runs on the following versions of Windows:

* Windows 7
* Windows 8.1
* Windows 10

Launch the installer
<a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-win32.msi"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-win32.msi');">gura-{{ gura_version }}-win32.msi</a> and follow the steps below:

<table>

<tr>
<td><img src="{{ topdir }}/assets/install-win32-step1.png" /></td>
<td>Click <code>[Next]</code> to go to the next page.</td>
</tr>

<tr>
<td><img src="{{ topdir }}/assets/install-win32-step2.png" /></td>
<td>Click <code>[Next]</code> to go to the next page. You can also modify the destinaton folder
where Gura's executable and other necessary files are to be installed by clicking <code>[Change...]</code>.</td>
</tr>

<tr>
<td><img src="{{ topdir }}/assets/install-win32-step3.png" /></td>
<td>Click <code>[Install]</code> to do the installation.
When you see a confirmation dialog that asks if you're sure to modify the system,
click <code>[Yes]</code> in it.</td>
</tr>

<tr>
<td><img src="{{ topdir }}/assets/install-win32-step4.png" /></td>
<td>Click <code>[Finish]</code> to finish the process.</td>
</tr>

</table>

The installer will set up all the necessary files as well as edit the registry
to assign file extensions `.gura`, `.guraw`, `.gurc` and `.gurcw` as executable ones.

If you don't want to modify registries, you can just expand ZIP file
<a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-win32.zip"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-win32.zip');">gura-{{ gura_version }}-win32.zip</a>
  in some directory and edit PATH environment so that it includes `gura\bin-x86` directory in the expanded content.


## Mac OS X

It has been confirmed that Gura runs on the following versions of Mac OS X.

* OS X 10.9 Mavericks

Open the disk image
<a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}.dmg"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}.dmg');">gura-{{ gura_version }}.dmg</a>
and drag `Gura.app` icon to `Applications` folder.

<img src="{{ topdir }}/assets/install-macos.png" />

**You can't use Launchpad to run `Gura.app`** as it'll be blocked by Gatekeeper.
This is because Gura hasn't been shipped with an Apple Developer ID so far.
Instead, browse the application in **Finder** and do "Open" in right-click menu.

Launching `Gura.app` will open a Terminal with Gura command prompt
in which you can evaluate Gura scripts interactively.
Call `setup()` function in the prompt to create a symbolic link `/usr/bin/gura`
that allows you to execute the interpreter in any direcrtories.

<pre><code>Gura x.x.x [clang v.x.x, xxx xx xxxx] Copyright (C) 2011-xxxx ypsitau
------------------------------------------------------------------------
Execute function setup() to create a symbolic link /usr/bin/gura.
------------------------------------------------------------------------
>>> <strong>setup()</strong>
Password:
Symbolic link /usr/bin/gura was created.
>>>
</code></pre>


## Linux

It has been confirmed that Gura can run on the following distributions of Linux.

* Ubuntu 13.10
* Ubuntu 14.04
* Ubuntu 16.04
* Fedora 20 (`wx` modules doesn't work well)

In default configuration, Ubuntu and Fedora do not include C++ compilers, cmake utility and readline library.
Install them as below before building Gura.

For Ubuntu:

    $ sudo apt-get install build-essential cmake libreadline-dev rpm

For Fedora:

    # yum install gcc gcc-c++ make cmake readline-devel

Download a source package
<a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-src.tar.gz"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-src.tar.gz');">gura-{{ gura_version }}-src.tar.gz</a>.
Then, follow the steps below to build Gura executables and modules.

    $ tar xvfz gura-{{ gura_version }}.tar.gz
    $ cd gura-{{ gura_version }}
    $ mkdir build
    $ cd build
    $ ../configure
    $ make
    $ sudo ./setup-guest
    $ ./build-modules

After that, follow the steps below to install them to the system.

    $ sudo make install
    $ sudo ldconfig     # necessary only for the first install
