---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">15</span><a name="anchor-15"></a>File Operation</h1>
<h2><span class="caption-index-2">15.1</span><a name="anchor-15-1"></a>Overview</h2>
<p>
Gura provides mechanism of <strong>Stream</strong> and <strong>Directory</strong> to work on files: Stream is prepared to read and write content of a file and Directory to retrieve lists of files stored in some containers. Here, a term "file" is not limited to what is stored in a file system of an OS. You can also use Stream and Directory to access files through networks and even ones stored in an archive files. Gura provides a generic framework to handle these resources so that you can expand the capabilities by importing Modules.
</p>
<p>
Each of Streams and Directories is associated with a uniquely identifiable string called <strong>pathname</strong>. A framework called <strong>Path Manager</strong> is responsible of recognizing pathname for Stream and Directory and dispatching file operations to appropriate processes that have been registered by built-in and imported Modules.
</p>
<h2><span class="caption-index-2">15.2</span><a name="anchor-15-2"></a>Pathname</h2>
<h3><span class="caption-index-3">15.2.1</span><a name="anchor-15-2-1"></a>Acceptable Format of Pathname</h3>
<p>
A pathname is a string that identifies Stream and Directory, which should be handled by Path Manager.
</p>
<p>
By default, built-in module <code>fs</code> has been registered to Path Manager, which tries to recognize a pathname as what is for ones stored in a file system. Below are some of such examples:
</p>
<pre><code>/home/foo/work/example.txt
C:\Users\foo\source\main.cpp
</code></pre>
<p>
You can use both a slash or a backslash as a directory separator for a file in file systems, which is to be converted by <code>fs</code> module to what the current OS can accept. You can see variable <code>path.sep_file</code> to check what character is favorable to the OS.
</p>
<h3><span class="caption-index-3">15.2.2</span><a name="anchor-15-2-2"></a>Utility Functions to Parse Pathname</h3>
<p>
Function <code>path.dirname()</code> extracts a directory part by eliminating a file part from a pathname.
</p>
<pre><code>rtn = path.dirname('/home/foo/work/example.txt')
// rtn is '/home/foo/work/'
</code></pre>
<p>
If the pathname ends with a directory separator, the function determines it doesn't contain a file part and returns the whole string.
</p>
<pre><code>rtn = path.dirname('/home/foo/work/')
// rtn is '/home/foo/work/'
</code></pre>
<p>
Function <code>path.filename()</code> extracts a file part from a pathname.
</p>
<pre><code>rtn = path.fileame('/home/foo/work/example.txt')
// rtn is 'example.txt'
</code></pre>
<p>
When given with a pathname that ends with a directory separator, the function determines it doesn't contain a file part and returns a null string.
</p>
<pre><code>rtn = path.filename('/home/foo/work/')
// rtn is ''
</code></pre>
<p>
Function <code>path.split()</code> splits a pathname by a directory separator and returns a list containing its directory part and file part. This works the same as a combination of <code>path.dirname()</code> and <code>path.filename()</code>.
</p>
<pre><code>rtn = path.split('/home/foo/work/example.txt')
// rtn is ['/home/foo/work/', 'example.txt']
</code></pre>
<p>
Function <code>path.cutbottom()</code> eliminates the last element in the directory hierarchy. This works the same as <code>path.dirname()</code> when the pathname ends with a file part.
</p>
<pre><code>rtn = path.cutbottom('/home/foo/work/example.txt')
// rtn is '/home/foo/work/'
</code></pre>
<p>
Note that it would have a different result if the pathname ends with a directory separator.
</p>
<pre><code>rtn = path.cutbottom('/home/foo/work/')
// rtn is '/home/foo/'
</code></pre>
<p>
Function <code>path.bottom()</code> splits a pathname and returns the last element. This works the same as <code>path.filename()</code> when the pathname ends with a file part.
</p>
<pre><code>rtn = path.bottom('/home/foo/work/example.txt')
// rtn is 'example.txt'
</code></pre>
<p>
Note that it would have a different result if the pathname ends with a directory separator.
</p>
<pre><code>rtn = path.bottom('/home/foo/work/')
// rtn is 'work'
</code></pre>
<p>
Function <code>path.splitext()</code> splits a pathname by a period existing last and returns a list containing its preceding part and suffix part.
</p>
<pre><code>rtn = path.splitext('/home/foo/work/example.txt')
// rtn is ['/home/foo/work/example', 'txt']
</code></pre>
<p>
Function <code>path.absname()</code> takes a relative path name in a file system and returns an absolute name based on the current directory.
</p>
<h2><span class="caption-index-2">15.3</span><a name="anchor-15-3"></a>Stream</h2>
<h3><span class="caption-index-3">15.3.1</span><a name="anchor-15-3-1"></a>Stream Instance</h3>
<p>
A Stream is a data object to read and write content of a file and represented by a <code>stream</code> instance created by a constructor function named <code>stream()</code>. Below shows a declaration of the constructor function:
</p>
<pre><code>stream(pathname:string, mode?:string, codec?:codec):map {block?}
</code></pre>
<p>
In many platforms and languages, people are accustom to using a term <code>open</code> as a function name for opening a file, or a stream. So, function <code>open()</code> is provided as a complete synonym for <code>stream()</code>, which has the same declaration with it.
</p>
<pre><code>open(pathname:string, mode?:string, codec?:codec):map {block?}
</code></pre>
<p>
In many cases, this document uses function <code>open()</code> instead of <code>stream()</code> to create a <code>stream</code> instance.
</p>
<p>
Function <code>open()</code> takes a pathname string as its argument and returns a <code>stream</code> instance.
</p>
<pre><code>fd = open('foo.txt')
// fd is a stream to read data from "foo.txt"
</code></pre>
<p>
When it is called with its second argument <code>mode</code> set to <code>'w'</code>, the function would create a new file and returns a <code>stream</code> instance to write data into it.
</p>
<pre><code>fd = open('foo.txt', 'w')
// fd is a stream to write data into "foo.txt"
</code></pre>
<p>
A <code>stream</code> instance will be closed when method <code>stream#close()</code> is called on it.
</p>
<pre><code>fd.close()
</code></pre>
<p>
When a stream for writing is closed, all the data stored in some buffer would be flushed out before the instance is invalidated.
</p>
<p>
Method <code>stream#close()</code> would also be called automatically when the instance is destroyed after its reference count decreases to zero. At times, it may be ambiguous about when the instance is destroyed, so it may be better to use <code>stream#close()</code> explicitly when you want to control the closing timing.
</p>
<p>
Another way to create and utilize a <code>stream</code> instance is to call <code>open()</code> function with a block procedure that will take a <code>stream</code> instance through its block parameter.
</p>
<pre><code>open('foo.txt') {|fd|
    // any jobs here
}
</code></pre>
<p>
Using this description, you can access the created instance only within the block, which will be automatically destroyed at the end of the procedure.
</p>
<h3><span class="caption-index-3">15.3.2</span><a name="anchor-15-3-2"></a>Cast from String to Stream Instance</h3>
<p>
If a certain function has an argument that expects a <code>stream</code> instance, you can pass it a string of a pathname, which will automatically be converted to a <code>stream</code> instance by a casting mechanism. The <code>stream</code> instance would be created as one for reading.
</p>
<pre><code>f(fd:stream) = {
    // fd is a stream instance for reading
    // any jobs here
}
f('foo.txt')   // same as f(open('foo.txt'))
</code></pre>
<p>
If the argument is declared with <code>:w</code> attribute, the <code>stream</code> instance would be created for writing.
</p>
<pre><code>f(fd:stream:w) = {
    // fd is a stream instance for writing
    // any jobs here
}
f('foo.txt')   // same as f(open('foo.txt', 'w'))
</code></pre>
<p>
Attribute <code>:r</code> is also prepared to explicitly declara that the stream is to be opened for reading.
</p>
<h3><span class="caption-index-3">15.3.3</span><a name="anchor-15-3-3"></a>Stream Instance to Access Memory</h3>
<p>
Beside <code>string</code>, an instance of class that accesses data stored in memory can also be casted to <code>stream</code>. These classes are <code>binary</code>, <code>memory</code> and <code>pointer</code>. Using this mechanism, you can read/write memory content through <code>stream</code> methods.
</p>
<p>
Below is an example to cast <code>binary</code> to <code>stream</code>.
</p>
<pre><code>f(fd:stream) = {
    // read/write access to content of buff through fd
}
buff = binary()
f(buff)
</code></pre>
<h3><span class="caption-index-3">15.3.4</span><a name="anchor-15-3-4"></a>Stream Instance for Standard Input/Output</h3>
<p>
There are three <code>stream</code> instances for the access to standard input and output, which are assigned to variables in <code>sys</code> module.
</p>
<ul>
<li><code>sys.stdin</code> &hellip; Standard input that retrieves data from key board.</li>
<li><code>sys.stdout</code> &hellip; Standard output that outputs texts to console screen.</li>
<li><code>sys.stderr</code> &hellip; Standard error output that outputs texts to console screen without interference of pipe redirection.</li>
</ul>
<p>
Functions <code>print()</code>, <code>printf()</code> and <code>println()</code> output texts to the stream <code>sys.stdout</code>. This means that the following two codes would cause the same result.
</p>
<pre><code>println('Hello world')
sys.stdout.println('Hello world')
</code></pre>
<p>
You can also assign a <code>stream</code> instance you create to these variables. Assignment to <code>sys.stdout</code> would affect the behavior of functions such as <code>println()</code>.
</p>
<pre><code>sys.stdout = open('foo.txt', 'w')
println('Hello world')   // result will be written into 'foo.txt'.
</code></pre>
<h3><span class="caption-index-3">15.3.5</span><a name="anchor-15-3-5"></a>Stream with Text Data</h3>
<p>
There are fundamental functions that print texts out to standard output stream.
</p>
<ul>
<li>Function <code>print()</code> takes multiple values that are to be printed out to <code>sys.stdout</code> in a proper format.</li>
<li>Function <code>println()</code> works the same as <code>print()</code> but also puts a line feed at the end.</li>
<li>Function <code>printf()</code> works similar with C language's <code>printf()</code> function and prints values to <code>sys.stdout</code> based on format specifiers. See chapter <a href="String-Operation.html">String Operation</a> for more details about formatter.</li>
</ul>
<p>
Below is a sample code using above functions to get the same result each other.
</p>
<pre><code>n = 3, name = 'Tanaka'
print('No.', n, ': ', name, '\n')
println('No.', n, ': ', name)
printf('No.%d: %s\n', n, name)
</code></pre>
<p>
Class <code>stream</code> is equipped with methods <code>stream#print()</code>, <code>stream#println()</code> and <code>stream#printf()</code> that correspond to functions <code>print()</code>, <code>println()</code> and <code>printf()</code> respectively, but output result to the target <code>stream</code> instread of <code>sys.stdout</code>. The code below outputs string to a file <code>foo.txt</code>.
</p>
<pre><code>n = 3, name = 'Tanaka'
open('foo.txt', 'w') {|fd|
    fd.print('No.', n, ': ', name, '\n')
    fd.println('No.', n, ': ', name)
    fd.printf('No.%d: %s\n', n, name)
}
</code></pre>
<p>
Method <code>stream#readline()</code> returns a string containing one line of text from the stream. It will return <code>nil</code> when it reaches to end of the stream, so you can write a program that prints content of a file as below:
</p>
<pre><code>fd = open('foo.txt')
while (line = fd.readline()) {
    print(line)
}
</code></pre>
<p>
Regarding that you often need to read multiple lines from a stream, method <code>stream#readlines()</code> may be more useful. It creates an iterator that returns each line's string as its element. A program to prints contet of a file comes as below:
</p>
<pre><code>fd = open('foo.txt')
lines = fd.readlines()
print(lines)
</code></pre>
<p>
Using function <code>readlines()</code> that takes <code>stream</code> instance as its argument, you don't need to explicitly open a stream because of casting mechanism from <code>string</code> to <code>stream</code>. This is the simplest way to read text files.
</p>
<pre><code>lines = readlines('foo.txt')
print(lines)
</code></pre>
<p>
If you want to eliminate a line feed character that exists at each line, specify <code>:chop</code> attribute.
</p>
<pre><code>lines = readlines('foo.txt'):chop
println(lines)
</code></pre>
<p>
An iterator created by method <code>stream#readlines()</code> and function <code>readlines()</code> owns a reference to the <code>stream</code> instance because they're designed to read data from it while iteration. This means that the stream instance won't be released while such iterator is running.
</p>
<p>
Consider the following code that is expected to read text from <code>foo.txt</code> and write text back to the same file after converting alphabet characters to upper case.
</p>
<pre><code>lines = readlines('foo.txt')
open('foo.txt', 'w').print(lines:*upper())
</code></pre>
<p>
Unfortunately, this program doesn't work correctly. The iterator <code>lines</code> owns a stream to read content from the file <code>foo.txt</code>, which conflicts with the attempt to open <code>foo.txt</code> for writing. To avoid this, you need to call <code>readlines()</code> function with <code>:list</code> attribute that reads whole the lines from the stream before storing them to a <code>list</code> instance. The function would release the stream and then return the <code>list</code> instance as its result.
</p>
<pre><code>lines = readlines('foo.txt'):list
open('foo.txt', 'w').print(lines:*upper())
</code></pre>
<p>
Method <code>stream#readtext()</code> returns a string containing the whole content of the stream.
</p>
<pre><code>txt = fd.readtext()
</code></pre>
<p>
As for the character sequence existing at each end of line in a file, two types of sequence are acceptable: LF (0x0a) and CR(0x0d)-LF(0x0a). Some systems like Linux that have inherited from UNIX uses LF code at line end while Windows uses CR-LF sequence. By default, the following policies are applied so that the string read from a file would only contain LF code.
</p>
<ul>
<li>When reading, all the CR codes are removed.</li>
<li>When writing, there's no modification about the sequence of end of line. This results in a file containing only LF code.</li>
</ul>
<p>
To change this behavior, use methods <code>stream#delcr()</code> and <code>stream#addcr()</code>. If you want to keep CR code from the read text, call <code>stream#delcr()</code> method with an argument set to <code>false</code>.
</p>
<pre><code>fd.delcr(false)
</code></pre>
<p>
If you want to append CR code at each end of line in a file to write, call <code>stream#addcr()</code> method with an argument set to <code>true</code>.
</p>
<pre><code>fd.addcr(true)
</code></pre>
<h3><span class="caption-index-3">15.3.6</span><a name="anchor-15-3-6"></a>Character Codecs</h3>
<p>
While a <code>string</code> instance holds string data in UTF-8 format, there are various character code sets to describe texts in files. To be capable of handling them, a <code>stream</code> instance may contain an instance of <code>codec</code> class that is responsible of converting characters between UTF-8 and those codes. You can specify a <code>codec</code> instance to a <code>stream</code> by passing it as a third argument of <code>open()</code> function.
</p>
<pre><code>fd = open('foo.txt', 'r', codec('cp932'))
</code></pre>
<p>
Since there's a casting feature from <code>string</code> to <code>codec</code> instance, you can simply specify a codec name to the argument as well.
</p>
<pre><code>fd = open('foo.txt', 'r', 'cp932')
</code></pre>
<p>
Below is a table that shows what codecs are available and what module provides them.
</p>
<p>
<table>
<tr>
<th>
Module</th>
<th>
Available Codec Names</th>
</tr>

<tr>
<td>
<code>codecs.basic</code></td>
<td>
<code>base64</code>, <code>us-ascii</code>, <code>utf-8</code>, <code>utf-16</code></td>
</tr>

<tr>
<td>
<code>codecs.chinese</code></td>
<td>
<code>big5</code>, <code>cp936</code>, <code>cp950</code>, <code>gb2312</code></td>
</tr>

<tr>
<td>
<code>codecs.iso8859</code></td>
<td>
<code>iso8859-1</code>, .. <code>iso8859-16</code></td>
</tr>

<tr>
<td>
<code>codecs.japanese</code></td>
<td>
<code>cp932</code>, <code>euc-jp</code>, <code>iso-2022-jp</code>, <code>jis</code>, <code>ms_kanji</code>, <code>shift_jis</code></td>
</tr>

<tr>
<td>
<code>codecs.korean</code></td>
<td>
<code>cp949</code>, <code>euc-kr</code></td>
</tr>

</table>

</p>
<p>
Codecs only have effect on methods to read/write text data that are summarized below:
</p>
<pre><code>stream#print(), stream#println(), stream#printf()
stream#readline(), stream#readlines(), stream#readtext()
</code></pre>
<p>
The standard output/input streams, <code>sys.stdin</code>, <code>sys.stdout</code> and <code>sys.stderr</code>, must be equipped with a codec of the character code set that the console device expects. While the detection of a proper codec is done by a value of environment variable <code>LANG</code> or a result of some system API functions, it may sometimes happen that you want to change codec in these. In such a case, you can use <code>stream#setcodec()</code> like below:
</p>
<pre><code>sys.stdout.setcodec('utf-8')
</code></pre>
<h3><span class="caption-index-3">15.3.7</span><a name="anchor-15-3-7"></a>Stream with Binary Data</h3>
<p>
In addition to methods to handle text data, class <code>stream</code> is equipped with methods to read/write binary data as well.
</p>
<p>
Method <code>stream#read()</code> reads specified size of data into a <code>binary</code> instance and returns it. When the stream reaches its end, the method returns <code>nil</code>.
</p>
<pre><code>open('foo.bin') {|fd|
    while (buff = fd.read(512)) {
        // some jobs with buff
    }
}
</code></pre>
<p>
Method <code>stream#write()</code> writes content of a <code>binary</code> instance to the stream.
</p>
<pre><code>open('foo.bin', 'w') {|fd|
    fd.write(buff)
}
</code></pre>
<p>
Method <code>stream#seek()</code> moves the current offset at which read/write operations are applied.
</p>
<p>
Method <code>stream#tell()</code> returns the current offset.
</p>
<p>
Methods <code>stream.copy()</code>, <code>stream#copyto()</code> and <code>stream#copyfrom()</code> are responsible of copying data from a stream to another stream. They have the same result each other but take <code>stream</code> instances in different ways. Below shows how they are called where <code>src</code> means a source stream and <code>dst</code> a destination.
</p>
<pre><code>stream.copy(src, dst)
src.copyto(dst)
dst.copyfrom(src)
</code></pre>
<p>
These methods can take a block procedure that takes <code>binary</code> instance containing a data segment during the copy process. The size of a data segment can be specified by an argument named <code>bytesunit</code>.
</p>
<pre><code>stream.copy(src, dst) {|buff:binary|
    // any job during copying process
}
</code></pre>
<p>
You can use the block procedure with the copying method to realize a indicator that shows how much process the methods have done.
</p>
<p>
Method <code>stream#compare()</code> compares contents between two streams and returns <code>true</code> if there's no difference and <code>false</code> otherwise.
</p>
<h3><span class="caption-index-3">15.3.8</span><a name="anchor-15-3-8"></a>Filter Stream</h3>
<p>
A Filter Stream is what is attached to other <code>stream</code> instance and applies data modification while reading or writing operation.
</p>
<p>
There are two types of Filter Stream: reader and writer.
</p>
<p>
A Filter Stream of reader type applies operation on methods for reading data including <code>stream#read()</code>, <code>stream#readline()</code>, <code>stream#readlines()</code> and <code>stream#readtext()</code>.
</p>
<pre><code>+--------+    +---------------+
| stream |---&gt;| filter stream |---&gt; (reading data)
|        |    |   (reader)    |
+--------+    +---------------+
</code></pre>
<p>
A Filter Stream of writer type applies operation on methods for writing data including <code>stream#write()</code>, <code>stream#print()</code>, <code>stream#println()</code> and <code>stream#printf()</code>.
</p>
<pre><code>+--------+    +---------------+
| stream |&lt;---| filter stream |&lt;--- (writing data)
|        |    |   (writer)    |
+--------+    +---------------+
</code></pre>
<p>
Module <code>gzip</code> provides functions to read and write files in gzip format, which usually have a suffix <code>.gz</code>. Importing the module would add following methods to <code>stream</code> class.
</p>
<ul>
<li><code>stream#gzipreader()</code> returns a stream from which you can read data after decompressing a sequence of gzip format from the attached stream.</li>
<li><code>stream#gzipwriter()</code> returns a stream to which you can write data that are to be compressed to a sequence of gzip format into the attached stream.</li>
</ul>
<p>
Module <code>bzip2</code> provides functions to read and write files in bzip2 format, which usually have a suffix <code>.bz2</code>. Importing the module would add following methods to <code>stream</code> class.
</p>
<ul>
<li><code>stream#bzip2reader()</code> returns a stream from which you can read data after decompressing a sequence of bzip2 format from the attached stream.</li>
<li><code>stream#bzip2writer()</code> returns a stream to which you can write data that are to be compressed to a sequence of bzip2 format into the attached stream.</li>
</ul>
<p>
Module <code>base64</code> provides functions to encode and decode files in Base64 format, which often appear in protocols of network. It's a build-in module that you can utilize without importing and makes following methods available in <code>stream</code> class.
</p>
<ul>
<li><code>stream#base64reader()</code> returns a stream from which you can read data after decoding a sequence of Base64 format from the attached stream.</li>
<li><code>stream#base64writer()</code> returns a stream to which you can write data that are to be encoded to a sequence of Base64 format into the attached stream.</li>
</ul>
<p>
Following code is an example to read content of a file in gzip format:
</p>
<pre><code>import(gzip)
open('foo.gz') {|fd_gzip|
    fd = fd_gzip.gzipreader()
    // reading process from fd
    fd.close()
}
</code></pre>
<p>
These methods that generate a Filter Stream can accept a block procedure just like <code>open()</code> function, in which you can take the instance of Filter Stream as a block parameter.
</p>
<pre><code>import(gzip)
open('foo.gz') {|fd_gzip|
    fd_gzip.gzipreader {|fd|
        // reading process from fd
    }
}
</code></pre>
<p>
Or simply, you can write it as below:
</p>
<pre><code>import(gzip)
open('foo.gz').gzipreader {|fd|
    // reading process from fd
}
</code></pre>
<p>
The same goes with a writing process. In this case, the attached stream must have a writing attribute.
</p>
<pre><code>import(gzip)
open('foo.gz', 'w') {|fd_gzip|
    fd = fd.gzipwriter()
    // writing process to fd
    fd.close()
}
</code></pre>
<p>
You can also attach a Filter Stream on yet another Filter Stream, which enables you to compose a chain of stream. Following is a code to decode a sequence in Base64 and then decompress it with gzip algorithm:
</p>
<pre><code>import(gzip)
open('foo.gz.hex') {|fd_hex|
    fd_hex.base64reader().gzipreader {|fd|
        // reading process from fd
    }
}
</code></pre>
<p>
Below shows a diagram of the process:
</p>
<pre><code>+--------+    +-----------------+    +---------------+
| stream |---&gt;|  filter stream  |---&gt;| filter stream |---&gt; (reading data)
|        |    | (base64 reader) |    | (gzip reader) |
+--------+    +-----------------+    +---------------+
</code></pre>
<p>
You can construct a chain of stream for writing process, too.
</p>
<pre><code>import(gzip)
open('foo.gz.hex', 'w') {|fd_hex|
    fd_hex.base64writer().gzipwriter {|fd|
        // writing process to fd
    }
}
</code></pre>
<p>
Below shows a diagram of the process:
</p>
<pre><code>+--------+    +-----------------+    +---------------+
| stream |&lt;---|  filter stream  |&lt;---| filter stream |&lt;--- (writing data)
|        |    | (base64 writer) |    | (gzip writer) |
+--------+    +-----------------+    +---------------+
</code></pre>
<h3><span class="caption-index-3">15.3.9</span><a name="anchor-15-3-9"></a>Stream with Archive File and Network</h3>
<p>
After importing <code>tar</code> module, you can create a stream that reads an item stored in a TAR archive file. When a pathname contains a filename suffixed with <code>.tar</code>, <code>.tgz</code>, <code>.tar.gz</code> or <code>tar.bz2</code>, it would decompress the content in accordance with TAR format. The example below opens an item named <code>src/main.cpp</code> in a TAR file <code>foo/example.tar.gz</code>.
</p>
<pre><code>import(tar)
open('foo/example.tar.gz/src/main.cpp') {|fd|
    // reading process from fd
}
</code></pre>
<p>
Since all the works necessary to decompress content of archive files are encapsulated in Path Manager framework, you can access them just like an ordinary file in file systems. Below is an example to print content of <code>src/main.cpp</code> in <code>foo/example.tar.gz</code>.
</p>
<pre><code>import(tar)
print(readlines('foo/example.tar.gz/src/main.cpp'))
</code></pre>
<p>
After importing <code>zip</code> module, you can create a stream that reads an item stored in a ZIP archive file. When a pathname contains a filename suffixed with <code>.zip</code>, it would decompress the content in accordance with ZIP format. The example below opens an item named <code>src/main.cpp</code> in a TAR file <code>foo/example.zip</code>.
</p>
<pre><code>import(zip)
open('foo/example.zip/src/main.cpp') {|fd|
    // reading process from fd
}
</code></pre>
<p>
Importing <code>curl</code> module, which provides features to access network using <a href="http://curl.haxx.se/">curl</a> library, or importing <code>http</code> module would make Path Manager able to recognize URIs that begin with protocol names like "http" and "ftp".
</p>
<pre><code>import(curl)
open('http://www.example.com/doc/index.html') {|fd|
    // reading process from fd
}
</code></pre>
<h2><span class="caption-index-2">15.4</span><a name="anchor-15-4"></a>Directory</h2>
<h3><span class="caption-index-3">15.4.1</span><a name="anchor-15-4-1"></a>Operations</h3>
<p>
A Directory is a data object to seek a list of files and sub directories and is represented by <code>directory</code> class. But currently, there's few chance to utilize the <code>directory</code> instance explicitly since it is usually built in other objects like iterators and hidden from users. One thing you have to note about <code>directory</code> is that you can cast a <code>string</code> containing a pathname to <code>directory</code> instance, so you can pass a pathname to an argument declared with <code>directory</code> type.
</p>
<p>
There are three functions that searches items like files and sub directories: <code>path.dir()</code>, <code>path.glob()</code> and <code>path.glob()</code>. Consider the following directory structure to see how these functions work.
</p>
<pre><code>example
|
+--dir-A
|  +--file-4.txt
|  `--file-5.txt
+--dir-B
|  +--dir-C
|  |  +--file-6.doc
|  |  `--file-7.doc
|  `--dir-D
+--file-1.txt
+--file-2.doc
`--file-3.txt
</code></pre>
<p>
Function <code>path.dir()</code> creates an iterator that returns pathname of items that exists in the specified directory. For example, a call <code>path.dir('example')</code> create an iterator that returns following strings.
</p>
<pre><code>example/dir-A/
example/dir-B/
example/file-1.txt
example/file-2.doc
example/file-3.txt
</code></pre>
<p>
Function <code>path.glob()</code> creates an iterator that returns pathname of items matching the given pattern with wild cards. For example, a call <code>path.glob('example/*.txt')</code> create an iterator that returns following strings.
</p>
<pre><code>example/file-1.txt
example/file-3.txt
</code></pre>
<p>
Function <code>path.walk()</code> creates an iterator that seeks directory structure recursively and returns pathname of items. For example, a call <code>path.walk('example')</code> create an iterator that returns following strings.
</p>
<pre><code>example/dir-A/
example/dir-B/
example/file-1.txt
example/file-2.doc
example/file-3.txt
example/dir-A/file-4.txt
example/dir-A/file-5.txt
example/dir-B/dir-C/
example/dir-B/dir-D/
example/dir-B/dir-C/file-6.doc
example/dir-B/dir-C/file-7.doc
</code></pre>
<h3><span class="caption-index-3">15.4.2</span><a name="anchor-15-4-2"></a>Status Object</h3>
<p>
By default, functions <code>path.dir()</code>, <code>path.glob()</code> and <code>path.glob()</code> create an iterator that returns a string of pathname. Specifying <code>:stat</code> attribute would create an iterator generating an object called <code>stat</code> that contains more detail information about items.
</p>
<p>
There are several different <code>stat</code> instances depending on the container in which an item exists, which provide various properties for additional information as well as the item's name.
</p>
<p>
An item in file system returns <code>fs.stat</code> instance that has following properties.
</p>
<p>
<table>
<tr>
<th>
Property Name</th>
<th>
Data Type</th>
<th>
Content</th>
</tr>

<tr>
<td>
<code>pathname</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>dirname</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>filename</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>size</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>uid</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>gid</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>atime</code></td>
<td>
<code>datatime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>mtime</code></td>
<td>
<code>datatime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>ctime</code></td>
<td>
<code>datatime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>isdir</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>ischr</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>isblk</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>isreg</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>isfifo</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>islnk</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>issock</code></td>
<td>
<code>boolean</code></td>
<td>
</td>
</tr>

</table>

</p>
<p>
The code below shows an example that prints each filename and size of items under a directory <code>example</code>.
</p>
<pre><code>stats = path.dir('example'):stat
printf('%-16s %d\n', stats:*filename, stats:*size)
</code></pre>
<h3><span class="caption-index-3">15.4.3</span><a name="anchor-15-4-3"></a>Directory in Archive File</h3>
<p>
After importing <code>tar</code> module, you can get a list of items stored in a TAR archive file. The code below prints all the items stored in <code>example.tar.gz</code> by <code>path.walk()</code>.
</p>
<pre><code>println(path.walk('example.tar.gz/'))
</code></pre>
<p>
Note that you have to append a directory separator after the archive filename so that Path Manager recognize it as a container, not an ordinary file.
</p>
<p>
An item in TAR archive file returns <code>tar.stat</code> instance that has following properties.
</p>
<p>
<table>
<tr>
<th>
Property Name</th>
<th>
Data Type</th>
<th>
Content</th>
</tr>

<tr>
<td>
<code>name</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>filename</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>linkname</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>uname</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>gname</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>mode</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>uid</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>gid</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>size</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>mtime</code></td>
<td>
<code>datetime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>atime</code></td>
<td>
<code>datetime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>ctime</code></td>
<td>
<code>datetime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>chksum</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>typeflag</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>devmajor</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>devminor</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

</table>

</p>
<p>
After importing <code>zip</code> module, you can get a list of items stored in a ZIP archive file. The code below prints all the items stored in <code>example.tar.gz</code> by <code>path.walk()</code>.
</p>
<pre><code>println(path.walk('example.zip/'))
</code></pre>
<p>
An item in ZIP archive file returns <code>zip.stat</code> instance that has following properties.
</p>
<p>
<table>
<tr>
<th>
Property Name</th>
<th>
Data Type</th>
<th>
Content</th>
</tr>

<tr>
<td>
<code>filename</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>comment</code></td>
<td>
<code>string</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>mtime</code></td>
<td>
<code>datetime</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>crc32</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>compression_method</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>size</code></td>
<td>
<code></code></td>
<td>
number</td>
</tr>

<tr>
<td>
<code>compressed_size</code></td>
<td>
<code>number</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>attributes</code></td>
<td>
<code></code></td>
<td>
number</td>
</tr>

</table>

</p>
<h2><span class="caption-index-2">15.5</span><a name="anchor-15-5"></a>OS-specific Operations</h2>
<h3><span class="caption-index-3">15.5.1</span><a name="anchor-15-5-1"></a>Operation on File System</h3>
<p>
Module <code>fs</code> provides functions that work with file systems.
</p>
<p>
Function <code>fs.mkdir()</code> creates a directory. If there are non-existing directories in the specified pathname, it would occur an error. Specifying attribute <code>:tree</code> would create intermediate directories in the pathname if they don't exist.
</p>
<p>
Function <code>fs.rmdir()</code> removes a directory. If the specified directory contains files or sub directories, it would occur an error. Specifying attribute <code>:tree</code> would remove all such items before deleting the specified directory.
</p>
<p>
Function <code>fs.remove()</code> removes a file.
</p>
<p>
Function <code>fs.rename()</code> rename a file or a directory.
</p>
<p>
Function <code>fs.chmod()</code> modifies attribute of a file or a directory.
</p>
<p>
Function <code>fs.cpdir()</code> copies content of a directory to another directory.
</p>
<h3><span class="caption-index-3">15.5.2</span><a name="anchor-15-5-2"></a>Execute Other Process</h3>
<p>
Function <code>os.exec()</code> executes a process and waits until it finishes. While the process runs, its standard output and standard error are redirected to streams defined by variables <code>os.stdout</code> and <code>os.stderr</code>, and its standard input is redirected from <code>os.stdin</code>. By default, variables <code>os.stdin</code>, <code>os.stdout</code> and <code>os.stderr</code> are assigned with <code>sys.stdin</code>, <code>sys.stdout</code> and <code>sys.stderr</code> respectively. You can modify those variables to retrieve console output from the process and feed text data to it through standard input. Below is an example to run an executable <code>foo</code> after redirecting the standard output to a memory buffer.
</p>
<pre><code>buff = binary()
saved = os.stdout
os.stdout = buff.writer()
os.exec('foo')
os.stdout = saved
print(os.fromnative(buff))
</code></pre>
<p>
Function <code>os.fromnative()</code> converts <code>binary</code> instance that contains a raw data from the process to a string in UTF-8 format.
</p>
<p />

{% endraw %}
