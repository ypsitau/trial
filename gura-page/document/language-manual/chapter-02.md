---
layout: default
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">2</span><a name="anchor-2"></a>Launch Program</h1>
<h2><span class="caption-index-2">2.1</span><a name="anchor-2-1"></a>Program Files</h2>
<p>
For Windows, there are two types of program files to launch Gura interpreter: <code>gura.exe</code> and <code>guraw.exe</code>. <code>guraw.exe</code> doesn't show command prompt window and you can use it to run a script with graphical user interface.
</p>
<p>
For Linux, an executable binary <code>gura</code> is the interpreter program.
</p>
<h2><span class="caption-index-2">2.2</span><a name="anchor-2-2"></a>Interactive Mode</h2>
<p>
When you run <code>gura.exe</code> or <code>gura</code> with no script file specified in the argument, it will enter an interactive mode that waits for user inputs.
</p>
<pre><code>Gura x.x.x [xxxxxxxxxx, xxx xx xxxx] Copyright (C) 2011-2015 ypsitau
&gt;&gt;&gt; 
</code></pre>
<p>
When you input a script followed by an enter key after a prompt <code>&gt;&gt;&gt;</code>, it will evaluate the script and show its result.
</p>
<pre><code>&gt;&gt;&gt; 3 + 4
7
&gt;&gt;&gt; println('Hello world')
Hello world
</code></pre>
<p>
To quit the interpreter, enter <code>Ctrl+C</code> from keyboard or execute a script <code>sys.exit()</code>.
</p>
<p>
If you want to get a help of a function, put "<code>~</code>" before the function name and hit the enter key in the prompt. Below is an example to show a help of function <code>println()</code>:
</p>
<pre><code>&gt;&gt;&gt; ~println
println(values*):map:void

Prints out values and a line-break to the standard output.
</code></pre>
<p>
When an expression has some valid value as its result after being evaluated, you will see the value before the next prompt line.
</p>
<pre><code>&gt;&gt;&gt; a = 3
3
&gt;&gt;&gt;
</code></pre>
<p>
To suppress this, you can append a semicolon character at the end of line like below:
</p>
<pre><code>&gt;&gt;&gt; a = 3;
&gt;&gt;&gt;
</code></pre>
<h2><span class="caption-index-2">2.3</span><a name="anchor-2-3"></a>Run Script File</h2>
<p>
You can run a script file by specifying it as an argument for Gura interpreter program.
</p>
<pre><code>$ gura hello.gura
</code></pre>
<p>
A Gura script file should have a suffix <code>.gura</code> or <code>.guraw</code>, where <code>.gura</code> is for command-line scripts and <code>.guraw</code> for ones with GUI. In Windows environment, the suffix <code>.gura</code> is associated with the program <code>gura.exe</code> and <code>.guraw</code> with <code>guraw.exe</code>.
</p>
<p>
As a Gura script is a plain text file, you can use any of your favorite editor to create it. The code below shows the content of <code>hello.gura</code> script.
</p>
<pre><code>println('Hello World')
</code></pre>
<p>
If you want to make a script executable on UNIX-like OS such as Linux, it might be a good idea to add shebang at the top of the script file. Below is a Hello World script with a shebang.
</p>
<pre><code>#!/usr/bin/env gura
println('Hello World')
</code></pre>
<p>
If you want to use shebang, be careful to save the script file with each line ended with LF code. This is to avoid an error caused by specifications of shell programs, not of Gura.
</p>
<p>
If a script file contains non-ASCII characters like Japanese and Chinese, you should save it in UTF-8 character code, which is a default code set for the interpreter.
</p>
<p>
When you need to save the file in other character codes, there are two ways to parse it properly. One is to specify <code>-d</code> option in command line as following.
</p>
<pre><code>$ gura -d shift_jis foo.gura
</code></pre>
<p>
Another one is to describe a magic comment that specifies a character encoding at top of the script but after shebang if exists.
</p>
<pre><code>#!/usr/bin/env gura
# coding: shift_jis
println('... string that may contain characters in Shift-JIS ...')
</code></pre>
<p>
A magic comment has a format like "<code>coding: XXXXXX</code>" where "<code>XXXXXX</code>" indicates what encoding the parser is to use. It can be detected when it appears at the first or second line of a script and is described as a line comment that begins with "<code>#</code>" or "<code>//</code>".
</p>
<p>
The following format is acceptable too.
</p>
<pre><code>#!/usr/bin/env gura
# -*- coding: shift_jis -*-
</code></pre>
<p>
This is good to make Emacs determine what character encoding it should choose for editing.
</p>
<p>
Available encoding names are summarized below:
</p>
<pre><code>us-ascii, utf-8, utf-16
iso8859-1, iso8859-2, iso8859-3, iso8859-4, iso8859-5, iso8859-6
iso8859-7, iso8859-8, iso8859-9, iso8859-10, iso8859-11, iso8859-13
iso8859-14, iso8859-15, iso8859-16
big5, cp936, cp950, gb2312
cp932, euc-jp, iso-2022-jp, jis, ms_kanji, shift_jis
cp949, euc-kr
</code></pre>
<h2><span class="caption-index-2">2.4</span><a name="anchor-2-4"></a>Composite File</h2>
<p>
It often happens that an application consists of multiple script files and other resources such as image files. Consider an application that has following files:
</p>
<pre><code>foo.gura
utils.gura
message.txt
image.png
</code></pre>
<p>
Assume that <code>foo.gura</code> is a main script that imports <code>utils.gura</code> and reads files <code>message.txt</code> and <code>image.png</code>.
</p>
<p>
It could be bothersome to treat these files separately especially when you try to distribute them.
</p>
<p>
For such a case, Gura has a feature that can run a ZIP archive file containing scripts and any other files. Such a file is called Composite File and can be created by ordinary archiving commands like following:
</p>
<pre><code>$ zip foo.zip foo.gura utils.gura message.txt image.png
$ mv foo.zip foo.gurc
</code></pre>
<p>
Then you can run it as following:
</p>
<pre><code>$ gura foo.gurc
</code></pre>
<p>
A Composite File must have a suffix <code>.gurc</code> or <code>.gurcw</code> where <code>.gurc</code> is for command-line scripts and <code>.gurcw</code> for ones with GUI. These suffixes are also associated with <code>gura.exe</code> and <code>guraw.exe</code> respectively in Windows environment. A script file that has the same name with that of the Composite File except for their suffix part is recognized as a main script. The interpreter reads that file at first when given with the Composite File.
</p>
<p>
You can also use a Gura module to create a Composite File. Below is a script to create a Composite File <code>foo.gurc</code>.
</p>
<pre><code>import(gurcbuild)
gurcbuild.build(['foo.gura', 'utils.gura', 'message.txt', 'image.png'])
</code></pre>
<p>
This script is more useful than using other archiving tools to create a Composite File because the script will embed shebang comment at top of the file and put executable attribute to it so that the created one can run independently under Linux environment.
</p>
<h2><span class="caption-index-2">2.5</span><a name="anchor-2-5"></a>Command Line Options</h2>
<p>
Available command line options are listed below:
</p>
<p>
<table>
<tr>
<th>
Option</th>
<th>
Explanation</th>
</tr>

<tr>
<td>
<code>-h</code></td>
<td>
Prints a help message.</td>
</tr>

<tr>
<td>
<code>-t</code></td>
<td>
Runs a script file specified and then enters interactive mode.</td>
</tr>

<tr>
<td>
<code>-i module[, ...]</code></td>
<td>
Imports modules in the same way as
  calling <code>import</code> function in a script.
  You can specify more than one module names for this option by separating them with comma.
  Or, you can also specify the option in multiple times to import several modules.</td>
</tr>

<tr>
<td>
<code>-I dir</code></td>
<td>
Specifies a directory in which modules are searched.
  You can specify the option in multiple times to add several directories for module search.
  The specified path would be converted to an absolute path unless it starts with <code>"./"</code>.</td>
</tr>

<tr>
<td>
<code>-c cmd</code></td>
<td>
Runs a Gura script described in <code>cmd</code>.</td>
</tr>

<tr>
<td>
<code>-T template</code></td>
<td>
Runs template engine to evaluate the specified template file.</td>
</tr>

<tr>
<td>
<code>-C dir</code></td>
<td>
Changes the current directory before running scripts.</td>
</tr>

<tr>
<td>
<code>-d encoding</code></td>
<td>
Specifies character encoding that the parser uses to read scripts.</td>
</tr>

<tr>
<td>
<code>-v</code></td>
<td>
Prints a version number.</td>
</tr>

</table>

</p>
<h2><span class="caption-index-2">2.6</span><a name="anchor-2-6"></a>System Directory</h2>
<p>
The distribution package contains the interpreter executable as well as other various files such as Gura modules and dynamic-loaded libraries. When installed, they are stored in directories that are relative to where the interpreter executable is located.
</p>
<p>
For Windows, they are stored in the following directories:
</p>
<pre><code>[install directory] -+- bin
                     +- module
                     +- include
                     +- lib
</code></pre>
<p>
For Linux, they are as below:
</p>
<pre><code>[install directory] -+- bin
                     +- include
                        +- gura
                     +- lib
                        +- gura
                     +- share
                        +- gura
</code></pre>
<p>
As the interpreter searches these files in directories that are relative to its own location, they are relocatable. This feature makes it easier to install different versions of Gura in a certain system.
</p>
<h2><span class="caption-index-2">2.7</span><a name="anchor-2-7"></a>Working Directory</h2>
<p>
When the interpret is launched, it creates a working directory if it's not exist, which Gura applications can use to store working files.
</p>
<p>
The directory name comes like below where <code>GURA_VERSION</code> is the Gura's version.
</p>
<p>
For Windows:
</p>
<pre><code>%LOCALAPPDATA%\Gura\GURA_VERSION
</code></pre>
<p>
For Linux:
</p>
<pre><code>$HOME/.gura/GURA_VERSION
</code></pre>
<p>
A variable <code>sys.localdir</code> points to the directory.
</p>
<p />

{% endraw %}
