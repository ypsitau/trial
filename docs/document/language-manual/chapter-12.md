---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">12</span><a name="anchor-12"></a>Module</h1>
<h2><span class="caption-index-2">12.1</span><a name="anchor-12-1"></a>Module as Environment</h2>
<p>
A <strong>module</strong> is a kind of environment and capable of containing variables and functions inside it. You can use <code>module()</code> function that takes a block procedure containing expressions of variable and function assignments. Below is an example:
</p>
<pre><code>foo = module {
    var:public = 'hello'
    func() = { /* body */ }
}
</code></pre>
<p>
Then, you can call functions and read/modify variables in the module with a member accessing operator <code>.</code> specifying the module on its left.
</p>
<pre><code>foo.func()
println(foo.var)
</code></pre>
<p>
By default, functions defined in a module are marked as public and are accessible from outside. On the other hand, variables in a module are marked as private and would cause an error for an access from outer scope. You have to put <code>:public</code> attribute in a variable assignment to make it public.
</p>
<p>
You can use modules to isolate variables and functions from the current scope by giving them an independent name space. But its main purpose is to provide a mechanism to load external files that extend the language's capability.
</p>
<h2><span class="caption-index-2">12.2</span><a name="anchor-12-2"></a>Importing Module File</h2>
<p>
Gura language has a policy that the interpreter itself should provide functions that are less dependent on external libraries, operating systems and hardware specifications. So, variety of functions such as handling regular expressions, image processing and GUI are realized by dynamically loadable files called <strong>module files</strong>.
</p>
<p>
There are two types of module files: script module file and binary module file.
</p>
<table>
<tr>
<th>
Module File</th>
<th>
Suffix</th>
<th>
Content</th>
</tr>
<tr>
<td>
script module file</td>
<td>
<code>.gura</code></td>
<td>
a usual Gura script file</td>
</tr>
<tr>
<td>
binary module file</td>
<td>
<code>.gurd</code></td>
<td>
a dynamic link library that has been compiled from C++ source code</td>
</tr>
</table>
<p>
A process of loading a module file and registering its properties to the current environment is called "import". You can use <code>import()</code> function in your script to import a module like below:
</p>
<pre><code>import(re)
</code></pre>
<p>
This loads a module file <code>re.gurd</code> and creates a module <code>re</code> in the current scope. After importing, functions like <code>re.match()</code> and <code>re.sub()</code> that the module provides become available.
</p>
<p>
You can import module properties into the current scope by specifying their symbols in a block of <code>import()</code> function.
</p>
<pre><code>import(re) { match, sub }
</code></pre>
<p>
Then, you can call these functions like <code>match()</code> instead of <code>re.match()</code>. Specifying <code>*</code> in the block will import all of the module properties into the current scope.
</p>
<pre><code>import(re) { * }
</code></pre>
<p>
Usually, this is not a recommended manner because there's a risk that symbols in a module conflict with ones that already exist. However, it may be a practical way to import some modules like <code>opengl</code>, which guarantees all the properties have distinguishable symbols.
</p>
<p>
You can also import modules at the timing launching the interpreter by specifying a command line option <code>-i</code> with module names. Below is an example that imports a module <code>re</code> before parsing the script file <code>foo.gura</code>.
</p>
<pre><code>$ gura -i re foo.gura
</code></pre>
<p>
You can specify multiple module names by separating them with a comma character.
</p>
<pre><code>$ gura -i re,http,png foo.gura
</code></pre>
<p>
Under Windows, the interpreter searches module files in the following path, where <code>GURA_VERSION</code> and <code>GURA_DIR</code> represent the interpreter's version and the path name in which the program has been installed respectively.
</p>
<ol>
<li>Current directory.</li>
<li>Directories specified by <code>-I</code> option in the command line.</li>
<li>Directories specified by environment variable <code>GURAPATH</code>.</li>
<li>Directory: <code>%LOCALAPPDATA%\Gura\GURA_VERSION\module</code>.</li>
<li>Directory: <code>GURA_DIR\module</code>.</li>
<li>Directory: <code>GURA_DIR\module\site</code>.</li>
</ol>
<p>
Under Linux, the interpreter searces module files in the following path.
</p>
<ol>
<li>Current directory.</li>
<li>Directories specified by <code>-I</code> option in the command line.</li>
<li>Directories specified by environment variable <code>GURAPATH</code>.</li>
<li>Directory: <code>$HOME/.gura/GURA_VERSION/module</code>.</li>
<li>Directory: <code>/usr/lib/gura/GURA_VERSION/module</code>.</li>
<li>Directory: <code>/usr/lib/gura/GURA_VERSION/module/site</code>.</li>
</ol>
<p>
A variable <code>sys.path</code> is assigned with a list that contains path names to search module files. You can add path names into the list while a script is running.
</p>
<h2><span class="caption-index-2">12.3</span><a name="anchor-12-3"></a>Creating Module File</h2>
<p>
Any script file can be a script module file, which you can import in other scripts. But there are several points you need to know concerning access controls. Consider the following script file named <code>foo.gura</code>:
</p>
<pre><code>var:public = 'hello'
func() = { /* body */ }
</code></pre>
<p>
Then, you can import it to make its properties available.
</p>
<pre><code>import(foo)
println(foo.var)
foo.func()
</code></pre>
<p>
As with a module created by <code>module()</code> function, following rules are applied:
</p>
<ul>
<li>Functions defined in a module file are marked as public and are accessible from outside. If necessary, you can put <code>:private</code> attribute in a function assignment to encapsulate it inside the file.</li>
<li>Variables defined in a module file are marked as private and would cause an error for an access from outer scope. You have to put <code>:public</code> attribute in a variable assignment to make it public.</li>
</ul>
<p>
As a script module file is not different to a usual script file, it can contain any expressions as well other than assignment expressions of function and variable. These expressions are evaluated once, when <code>import()</code> function is called.
</p>
<p>
If a script file is imported as a module, a global variable <code>__name__</code> holds its own module name. For instance, a script in <code>foo.gura</code> sees the variable with a value <code>'foo'</code> when imported. If a script file is parsed by the interpreter firsthand, the variable is set to <code>'__main__'</code>. Utilizing this feature, you can write a script in a module file to test its own functions like below:
</p>
<pre><code>func() = { /* body */ }

if (__name__ == '__main__') {
    func()  // test func()
}
</code></pre>
<p>
Since the body of <code>if()</code> function would only be evaluated when the script runs as a main one, you can write codes inside it that wouldn't be evaluated when imported as a module.
</p>
<h2><span class="caption-index-2">12.4</span><a name="anchor-12-4"></a>Extensions by Module</h2>
<p>
Modules don't only provide functions but could enhance various capabilities.
</p>
<ul>
<li><p>
<strong>Extensions of Existing Class</strong>
</p>
<p>
Some modules would provide additional methods to classes that already exists. For example, module <code>re</code> would add some methods to <code>string</code> class like <code>string#match()</code>.
</p>
</li>
<li><p>
<strong>Operator</strong>
</p>
<p>
Some modules would enhance operators so that they can handle objects the modules provide. For example, a module named <code>gmp</code> provides operators on arbitrary precision numbers.
</p>
</li>
<li><p>
<strong>Image Format</strong>
</p>
<p>
You can use a function <code>image()</code> to read a image file. Importing modules that handle image data would expand the function's capability to support additional image formats. For example, after importing <code>jpeg</code> module, the function can read a file in JPEG format like following:
</p>
<pre><code>import(jpeg)
img = image('foo.jpg')
// .. any jobs
</code></pre>
</li>
<li><p>
<strong>Path Name for Stream</strong>
</p>
<p>
You can use a stream instance to access a file stored in a certain storage. While a stream is opened by specifying a path name associated with it, some modules would expand the path name handler so that it can recognize its specific name format. For example, importing a module named <code>curl</code> would allow access to a file stored in networks and enhance the path name handler to be able to recognize names that begin with '<code>http:</code>'.
</p>
<pre><code>import(curl)
print(readlines('http://example.com/index.html'))
</code></pre>
<p>
For another example, module <code>zip</code> provides functions to read and write content of ZIP files. and it would make the path name accessible in a ZIP file. The example below prints a content of <code>doc/readme.txt</code> that is stored in <code>foo.zip</code>.
</p>
<pre><code>import(zip)
print(readlines('foo.zip/doc/readme.txt'))
</code></pre>
</li>
<li><p>
<strong>Path Name for Directory</strong>
</p>
<p>
Path names in functions that handle directories could also be enhanced by modules.
</p>
<p>
A function <code>path.walk()</code> recursively retrieves entries in a storage with a specified path name. After importing module <code>zip</code>, you can seek entries in a ZIP file using that function.
</p>
<pre><code>import(zip)
println(path.walk('foo.zip/src'))
</code></pre>
</li>
<li><p>
<strong>Suffix Handler</strong>
</p>
<p>
There's a case that a module will provide additional suffix handlers. For example, module <code>gmp</code> can handle suffix <code>L</code> that creates an instance of arbitrary precision number from a number literal.
</p>
<pre><code>import(gmp)
x = 3.1415L * 2 * r
</code></pre>
</li>
<li><p>
<strong>Character Codec</strong>
</p>
<p>
Modules can provide additional handlers for character codec.
</p>
</li>
</ul>
<h2><span class="caption-index-2">12.5</span><a name="anchor-12-5"></a>List of Bundled Modules</h2>
<p>
This section describes a list of modules that are bundled with the interpreter.
</p>
<p>
Image file format:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>bmp</code></td>
<td>
handles BMP image file</td>
</tr>

<tr>
<td>
<code>gif</code></td>
<td>
handles GIF image file</td>
</tr>

<tr>
<td>
<code>jpeg</code></td>
<td>
handles <a href="http://www.ijg.org/">JPEG</a> image file</td>
</tr>

<tr>
<td>
<code>msico</code></td>
<td>
handles Microsoft Icon file</td>
</tr>

<tr>
<td>
<code>png</code></td>
<td>
handles <a href="http://www.libpng.org/">PNG</a> image file</td>
</tr>

<tr>
<td>
<code>ppm</code></td>
<td>
handles PPM image file</td>
</tr>

<tr>
<td>
<code>tiff</code></td>
<td>
handles <a href="http://www.libtiff.org/">TIFF</a> image file</td>
</tr>

<tr>
<td>
<code>xpm</code></td>
<td>
handles XPM image file</td>
</tr>

</table>

</p>
<p>
Compression/depression/archiving/hash:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>bzip2</code></td>
<td>
provides compressor/decompressor functions for <a href="http://www.bzip.org/">bzip2</a> format</td>
</tr>

<tr>
<td>
<code>gzip</code></td>
<td>
provides compressor/decompressor functions for <a href="http://zlib.net/">gzip</a> format</td>
</tr>

<tr>
<td>
<code>tar</code></td>
<td>
provides function to read/write tar archive file</td>
</tr>

<tr>
<td>
<code>zip</code></td>
<td>
provides function to read/write ZIP archive file</td>
</tr>

<tr>
<td>
<code>hash</code></td>
<td>
</td>
</tr>

</table>

</p>
<p>
Image operation:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>cairo</code></td>
<td>
provides APIs of <a href="http://cairographics.org">Cairo</a>, a 2D graphic library</td>
</tr>

<tr>
<td>
<code>freetype</code></td>
<td>
provides APIs of <a href="http://www.freetype.org">FreeType</a>, a library to render fonts</td>
</tr>

<tr>
<td>
<code>opengl</code></td>
<td>
provides APIs of <a href="http://www.opengl.org">OpenGL</a>, a library to render 2D/3D graphics</td>
</tr>

<tr>
<td>
<code>glu</code></td>
<td>
Utility functions for OpenGL</td>
</tr>

</table>

</p>
<p>
GUI operation:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>sdl</code></td>
<td>
provides APIs of <a href="http://www.libsdl.org">SDL</a>,
a library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D</td>
</tr>

<tr>
<td>
<code>tcl</code></td>
<td>
provides APIs of <a href="https://www.tcl.tk">Tcl</a> interpreter</td>
</tr>

<tr>
<td>
<code>tk</code></td>
<td>
provides APIs of Tk using <code>tcl</code> module</td>
</tr>

<tr>
<td>
<code>wx</code></td>
<td>
provides APIs of <a href="https://www.wxwidgets.org/">wxWidgets</a>, a cross-platform GUI library</td>
</tr>

<tr>
<td>
<code>show</code></td>
<td>
provides <code>image#show()</code> method that displays image on a window</td>
</tr>

<!-- <tr><td><code>canvas</code></td><td>(obsolete)</td></tr> -->
</table>

</p>
<p>
Audio operation:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>midi</code></td>
<td>
provides APIs to control MIDI hardware and to create MIDI files</td>
</tr>

<!-- <tr><td><code>wav</code></td><td></td></tr> -->
</table>

</p>
<p>
Network operation:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>curl</code></td>
<td>
provides APIs to access to network using <a href="http://curl.haxx.se/">CURL</a> library</td>
</tr>

<tr>
<td>
<code>http</code></td>
<td>
provides APIs for HTTP server and client functions</td>
</tr>

<!-- <tr><td><code>guri</code></td><td></td></tr> -->
</table>

</p>
<p>
OS specific:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>conio</code></td>
<td>
controls console I/O</td>
</tr>

<tr>
<td>
<code>mswin</code></td>
<td>
provides APIs for OLE interface registry access</td>
</tr>

<tr>
<td>
<code>msxls</code></td>
<td>
provides simple classes that handle MS Excel documents</td>
</tr>

<tr>
<td>
<code>uuid</code></td>
<td>
generates UUID</td>
</tr>

</table>

</p>
<p>
Text file operation:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>csv</code></td>
<td>
Read/write CSV file</td>
</tr>

<tr>
<td>
<code>markdown</code></td>
<td>
parser of Markdown syntax</td>
</tr>

<tr>
<td>
<code>re</code></td>
<td>
Regular expression</td>
</tr>

<tr>
<td>
<code>tokenizer</code></td>
<td>
provides APIs that tokenize strings</td>
</tr>

<tr>
<td>
<code>xml</code></td>
<td>
XML parser</td>
</tr>

<tr>
<td>
<code>xhtml</code></td>
<td>
XHTML composer</td>
</tr>

<tr>
<td>
<code>yaml</code></td>
<td>
provides APIs to read/write document in <a href="http://pyyaml.org/wiki/LibYAML">YAML</a> format</td>
</tr>

</table>

</p>
<p>
Mathematical:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>gmp</code></td>
<td>
provides APIs of <a href="https://gmplib.org/">GMP</a>,
  a library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.</td>
</tr>

</table>

</p>
<p>
Database:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>sqlite3</code></td>
<td>
provides APIs to access to database of <a href="http://www.sqlite.org/index.html">sqlite3</a></td>
</tr>

</table>

</p>
<p>
Helper to build modules:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>gurcbuild</code></td>
<td>
provides APIs to create a composite file</td>
</tr>

<tr>
<td>
<code>modbuild</code></td>
<td>
used in a script to build a binary module</td>
</tr>

<tr>
<td>
<code>modgen</code></td>
<td>
generates template files to build a binary module</td>
</tr>

</table>

</p>
<p>
Utilities:
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>argopt</code></td>
<td>
provides APIs to handle argument options</td>
</tr>

<tr>
<td>
<code>calendar</code></td>
<td>
generates a specified year's calendar</td>
</tr>

<tr>
<td>
<code>sed</code></td>
<td>
replaces strings using regular expression across multiple files</td>
</tr>

<tr>
<td>
<code>testutil</code></td>
<td>
utilities for tester script</td>
</tr>

<tr>
<td>
<code>units</code></td>
<td>
definition of units</td>
</tr>

<tr>
<td>
<code>utils</code></td>
<td>
utilities</td>
</tr>

<!-- <tr><td><code>sample</code></td><td></td></tr> -->
<!-- <tr><td><code>graph</code></td><td></td></tr> -->
</table>

</p>
<h2><span class="caption-index-2">12.6</span><a name="anchor-12-6"></a>Creating Binary Module File</h2>
<p>
Gura has a mechanism to support users who create binary modules. This document shows how to create an original binary module hoge.
</p>
<p>
At first, execute the following command.
</p>
<pre><code>$ gura -i modgen hoge
</code></pre>
<p>
This would generate a builder script, build.gura, and a template source file of module, Module_hoge.cpp. Although the file Module_hoge.cpp is just a C++ source file that consists of less than 40 lines of codes, it already has an implementation for a Gura function named test.
</p>
<p>
Executing build.gura would create the module by launching a proper C++ compiler. If you try it in Windows, you need to install Visual Studio 2010 in advance. You may use Express version that is available for free of charge.
</p>
<pre><code>$ gura build.gura --here
</code></pre>
<p>
If you find a binary module file hoge.gurd has successfully been built in the current directory, import it into Gura's script and test it.
</p>
<pre><code>$ gura
&gt;&gt;&gt; import(hoge)
&gt;&gt;&gt; dir(hoge)
[`__name__, `test]
&gt;&gt;&gt; hoge.test(3, 5)
8
</code></pre>
<p>
Congratulations! It's ready to edit Module_hoge.cpp for implementations as you like. If you get what you want, execute the following command to install the module into Gura's environment.
</p>
<pre><code>$ sudo gura build.gura install
</code></pre>
<p>
By the way, you need to get some information about C++ functions and classes provided by Gura for actual programming. The best way for it is to see source files of other binary modules. At first, find out a module from those provided by Gura, which has a function similar to what you want to create. You can find module source files in a directory gura/src/Module_module in a source package. Each module is so simple that consists of one to two source files. I'm sure it's relatively easy to know how to realize your purpose by investigating them, because they have been developed in the same coding policy.
</p>
<p />

{% endraw %}
