---
layout: default
lang: en
title: download
---
{% assign gura_version = '0.7.0' %}
{% assign gura_version_prev = '0.6.2' %}

# Download <a name="download"></a>

## Latest Version <a name="download-latest"></a><a class="btn btn-secondary float-right" data-toggle="collapse" href="#relnote-latest" role="button" aria-expanded="false" aria-controls="relnote-latest">Release Notes</a>

<div class="collapse bg-light p-2 mb-2" id="relnote-latest" markdown="1">
  - Performance has been improved. It's **twice** as fast as v0.6.2.
  - Uses Visual Studio 2015 to build for Windows.
  - Can be built with GCC 5.
  - Supports Ubuntu 16.04.
  - Enhanced `opengl` module so that it supports APIs of OpenGL 1.2 or later.
  - Implemented `array` class that provides features for matrix calculations.
  - Mathematical functions such as `math.sin()` and `math.log()` can be expanded so they can take various types of value in their arguments.
  - Implemented `vertex` class that represents 2-D or 3-D coord data.
  - Implemented `model.stl` module that provides measures to read/write files in STL format for 3D models.
  - Implemented `model.obj` module that provides measures to read/write files in OBJ format for 3D models.
  - Implemented `doxygen` module that parses Doxygen documents.
  - Implemented `fftw` module that applies fourier transform on array data.
</div>

<table class="table">
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

## Previous Version <a name="download-previous"></a><a class="btn btn-secondary float-right" data-toggle="collapse" href="#relnote-previous" role="button" aria-expanded="false" aria-controls="relnote-previous">Release Notes</a>

<div class="collapse bg-light p-2 mb-2" id="relnote-previous" markdown="1">
  - Enhanced features to provide help documents of each function.
    - Added much of help document.
    - You can use `~` operator to print a function help in the interactive mode: eg) `~println`
    - As the help documents are written in Markdown, they can also be converted to HTML and TeX.
        Actually, the Gura Library Reference (http://www.gura-lang.org/library-reference/index.html) has been created from documents implemented in the interpreter.
  - Enhanced `markdown` module:
    - It can now parse a "table" format in which columns and rows are separated with vertical bars and hyphens.
    - Implemented parser of fenced code blocks.
  - Modified `import` function so that it can take a variable as its argument like `import(&foo)` where `foo` is a variable that has been assigned with a module name as a string.
  - Modified naming convention of methods for image class: eg) `image#jpegread` -> `image#read@jpeg`
  - Reimplemented methods in `re` module.
  - Implemented `diff` module that extracts differences between two documents.
  - Implemented `string#embed()` method that embeds Gura script in a string.
  - Implemented `u` and `U` escape sequence in a string that represents a unicode point coded in UTF-16 and UTF-32 respectively.
  - Implemented method `string#replaces()` that accepts multiple match-substitution pairs.
  - Implemented methods `string#isalnum()`, `string#isalpha()`, `string#isdigit()` and `string#isspace()`.
  - Places site-specific modules in module/site directory.
</div>

<table class="table">

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

# Installation <a name="installation"></a>

## <i class="fab fa-windows"></i> Windows <a name="installation-windows"></a>

It has been confirmed that Gura runs on the following versions of Windows:

* Windows 7
* Windows 8.1
* Windows 10

Launch the installer
<a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-win32.msi"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-win32.msi');">gura-{{ gura_version }}-win32.msi</a> and follow the steps below:

<div class="card-deck">
  <div class="card mt-2 border-secondary">
	<div class="card-header text-white bg-secondary">Step. 1</div>
	<img class="card-img-top p-2" src="{{ topdir }}/assets/install-win32-step1.png" />
	<div class="card-body">
	  Click <code>[Next]</code> to go to the next page.
	</div>
  </div>
  <div class="card mt-2 border-secondary">
	<div class="card-header text-white bg-secondary">Step. 2</div>
	<img class="card-img-top p-2" src="{{ topdir }}/assets/install-win32-step2.png" />
	<div class="card-body">
	  Click <code>[Next]</code> to go to the next page. You can also modify the destinaton folder
	  where Gura's executable and other necessary files are to be installed by clicking <code>[Change...]</code>.
	</div>
  </div>
</div>

<div class="card-deck">
  <div class="card mt-2 border-secondary">
	<div class="card-header text-white bg-secondary">Step. 3</div>
	<img class="card-img-top p-2" src="{{ topdir }}/assets/install-win32-step3.png" />
	<div class="card-body">
	  Click <code>[Install]</code> to do the installation.
	  When you see a confirmation dialog that asks if you're sure to modify the system,
	  click <code>[Yes]</code> in it.
	</div>
  </div>
  <div class="card mt-2 border-secondary">
	<div class="card-header text-white bg-secondary">Step. 4</div>
	<img class="card-img-top p-2" src="{{ topdir }}/assets/install-win32-step4.png" />
	<div class="card-body">
	  Click <code>[Finish]</code> to finish the process.
	</div>
  </div>
</div>

<div class="mt-4" />

The installer will set up all the necessary files as well as edit the registry
to assign file extensions `.gura`, `.guraw`, `.gurc` and `.gurcw` as executable ones.

If you don't want to modify registries, you can just expand ZIP file
<a href="https://github.com/gura-lang/gura/releases/download/v{{ gura_version }}/gura-{{ gura_version }}-win32.zip"
  onClick="ga('send', 'event', 'download', 'click', 'gura-{{ gura_version }}-win32.zip');">gura-{{ gura_version }}-win32.zip</a>
  in some directory and edit PATH environment so that it includes `gura\bin-x86` directory in the expanded content.


## <i class="fab fa-apple"></i> Mac OS X <a name="installation-mac"></a>

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


## <i class="fab fa-linux"></i> Linux <a name="installation-linux"></a>

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
