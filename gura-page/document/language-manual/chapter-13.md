---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">13</span><a name="anchor-13"></a>String and Binary</h1>
<h2><span class="caption-index-2">13.1</span><a name="anchor-13-1"></a>Overview</h2>
<p>
A string is a sequence of character codes in UTF-8 format and is represented by <code>string</code> class. Class <code>string</code> is a primitive type, which means there's no operation that could modify the content of <code>string</code> instances. This leads to the following principles:
</p>
<ul>
<li>It's not allowed to edit each character in a string content through index access.</li>
<li>Modification methods are supposed to return a new <code>string</code> instance with modified result.</li>
</ul>
<p>
The interpreter itself provides fundamental operations for strings. Importing module named <code>re</code> expand the capability so that it can process string data using regular expressions.
</p>
<p>
Meanwhile, a binary is a byte sequence of data that has any format and is represented by <code>binary</code> class. Class <code>binary</code> is an object type, so you can modify the content of the instance. A <code>binary</code> instance can be used as a plain memory image capable of containing any data.
</p>
<h2><span class="caption-index-2">13.2</span><a name="anchor-13-2"></a>Operation on String</h2>
<h3><span class="caption-index-3">13.2.1</span><a name="anchor-13-2-1"></a>Character Manipulation</h3>
<p>
You can specify an index number starting from zero embraced by a pair of square brackets to retrieve a character as a sub string at the specified position. Multiple numbers for indexing can also be specified to get a list of sub strings.
</p>
<pre><code>str = 'abcdefghijklmnopqrstuvwxyz'
str[6]            // returns 'g'
str[20]           // returns 'u'
str[17]           // returns 'r'
str[0]            // returns 'a'
str[6, 20, 17, 0] // returns ['g', 'u', 'r', 'a']
</code></pre>
<p>
You can also specify iterators and lists to get a list of sub strings. Numbers and iterators can be mixed together as indexing items.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str[10..14]       // returns ['b', 'r', 'o', 'w', 'n']
str[4..8, 35..38] // returns ['q', 'u', 'i', 'c', 'k', 'l', 'a', 'z', 'y']
</code></pre>
<p>
If you specify an infinite iterator as an indexing item, you would get sub strings within an available range.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str[35..]       // returns ['l', 'a', 'z', 'y', ' ', 'd', 'o', 'g']
</code></pre>
<p>
An index with a negative number points the position from the bottom, where <code>-1</code> is the last position.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str[-3]         // returns 'd'
str[-2]         // returns 'o'
str[-1]         // returns 'g'
</code></pre>
<p>
Function <code>chr()</code> returns a string that contains a character of the given UTF-8 character code.
</p>
<pre><code>chr(65)         // returns 'A'
</code></pre>
<p>
Function <code>ord()</code> takes a string and returns UTF-8 character code of its first character.
</p>
<pre><code>ord('A')        // returns 65
</code></pre>
<h3><span class="caption-index-3">13.2.2</span><a name="anchor-13-2-2"></a>Iteration</h3>
<p>
Method <code>string#each()</code> creates an iterator that returns each character as a sub string.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
x = str.each()
// x is an iterator that returns 'T', 'h', 'e' ...
</code></pre>
<p>
A call of <code>string#each()</code> with attribute <code>:utf8</code> or <code>:utf32</code> would create an iterator that returns character code numbers in UTF-8 or UTF-32 instead of sub strings.
</p>
<pre><code>str = 'XXX'  // assumes it contains kanji characters 'ni-hon-go'
x = str.each():utf8
// x is an iterator that returns 0xe697a5, 0xe69cac and 0xe7aa9e

x = str.each():utf32
// x is an iterator that returns 0x65e5, 0x672c and 0x8a9e
</code></pre>
<p>
Method <code>string#eachline()</code> creates an iterator that splits a string by a newline character and returns strings of each line.
</p>
<pre><code>str = R'''
1st
2nd
3rd
'''
lines = str.eachline()
// lines is an iterator that returns '1st\n', '2nd\n' and '3rd\n'
</code></pre>
<p>
Method <code>string#chop()</code> is useful when you want to remove a newline character appended at the bottom.
</p>
<pre><code>x = str.eachline()
lines = x:*chop()  // an iterator to apply string#chop() to each value in x
// lines is an iterator that returns '1st', '2nd' and '3rd'
</code></pre>
<p>
Method <code>string#eachline()</code> and others that split a multi-lined text into strings of each line like <code>readlines()</code> are equipped with an attribute <code>:chop</code> that applies the same process as <code>string#chop()</code>.
</p>
<pre><code>lines = str.eachline():chop
// lines is an iterator that returns '1st', '2nd' and '3rd'
</code></pre>
<p>
Method <code>string#split()</code> creates an iterator that splits a string by a separator string specified in the argument.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
x = str.split(' ')
// x is an iterator that returns 'The', 'quick', 'brown', 'fox' ...
</code></pre>
<p>
If you want to split a string into segments with the same length, use <code>string#fold()</code> method.
</p>
<pre><code>str = 'abcdefghijklmnopqrstuvwxyz'
x = str.fold(5)
// x is an iterator that returns 'abcde', 'fghij', 'klmno', 'pqrst', 'uvwxy' and 'z'
</code></pre>
<h3><span class="caption-index-3">13.2.3</span><a name="anchor-13-2-3"></a>Modification and Conversion</h3>
<p>
Applying an operator <code>+</code> between two <code>string</code> instances would concatenate them together.
</p>
<pre><code>str1 = 'abcd'
str2 = 'efgh'
str1 + str2   // returns 'abcdefgh'
</code></pre>
<p>
An operator <code>*</code> between a <code>string</code> and a <code>number</code> value would concatenate the string the specified number of times.
</p>
<pre><code>str = 'abcd'
str * 3      // returns 'abcdabcdabcd'
</code></pre>
<p>
Method <code>list#join()</code> joins all the string in the list and returns the result. If it contains elements other than <code>string</code>, they're converted to strings before joined.
</p>
<pre><code>['abcd', 'efgh', 'ijkl'].join()    // returns 'abcdefghijkl'
</code></pre>
<p>
The method can take a separator string as its argument that is inserted between elements.
</p>
<pre><code>['abcd', 'efgh', 'ijkl'].join(', ') // returns 'abcd, efgh, ijkl'
</code></pre>
<p>
Method <code>string#capitalize()</code> returns a string with the top alphabet converted to uppper case.
</p>
<pre><code>str = 'hello, WORLD'
str.capitalize()  // returns 'Hello, WORLD'
</code></pre>
<p>
Methods <code>string#upper()</code> and <code>string#lower()</code> return a string after converting all the alphabet characters to upper and lower case respectively.
</p>
<pre><code>str = 'hello, WORLD'
str.upper()       // returns 'HELLO, WORLD'
str.lower()       // returns 'hello, world'
</code></pre>
<p>
Method <code>string#binary()</code> returns a <code>binary</code> instance that contains a binary sequence of the string in UTF-8 format.
</p>
<pre><code>str = 'XXX'    // assumes it contains kanji characters 'ni-hon-go'
str..binary()  // returns a binary b'\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e'
</code></pre>
<p>
You can use <code>string#encode()</code> to get a binary sequence in other codec other than UTF-8.
</p>
<pre><code>str = 'XXX'              // assumes it contains kanji characters 'ni-hon-go'
str.encode('shift_jis')  // returns a b'\x93\xfa\x96\x7b\x8c\xea'
</code></pre>
<p>
Method <code>string#reader()</code> returns a <code>stream</code> instance that reads a binary sequence of the string in UTF-8 format.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
x = str.reader()
// x is a stream instance for reading
</code></pre>
<p>
Method <code>string#encodeuri()</code> converts characters that can not be described in URI by a percent-encoding rule, while method <code>string#decodeuri()</code> converts such encoded string into normal characters.
</p>
<p>
Method <code>string#escapehtml()</code> escapes characters that can not be described in HTML with character entities prefixed by an ampersand, while method <code>string#unescapehtml()</code>converts such escaped ones into normal characters.
</p>
<h3><span class="caption-index-3">13.2.4</span><a name="anchor-13-2-4"></a>Extraction</h3>
<p>
Method <code>string#strip()</code> removes space characters that exist on both sides of the string. Attributes <code>:left</code> and <code>:right</code> would specify the side to remove spaces.
</p>
<pre><code>str = '    hello  '
str.strip()        // returns 'hello'
str.strip():left   // returns 'hello  '
str.strip():right  // returns '    hello'
</code></pre>
<p>
Method <code>string#left()</code> returns a sub string that has extracted specified number of characters from the left side, while method <code>string#right()</code>extracts from the right side.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str.left(3)  // returns 'The'
str.right(3) // returns 'dog'
</code></pre>
<p>
Method <code>string#mid()</code> returns a sub string that has extracted specified number of characters from the specified position.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str.mid(10, 5)  // returns 'brown'
</code></pre>
<h3><span class="caption-index-3">13.2.5</span><a name="anchor-13-2-5"></a>Search, Replace and Inspection</h3>
<p>
To see the length of a string, <code>string#len()</code> is available. Note that <code>string#len()</code> returns the number of characters, not the size in byte.
</p>
<pre><code>str = 'abcdefghijklmnopqrstuvwxyz'
n = str.len()
// n is 26
</code></pre>
<p>
Method <code>string#find()</code> searches the specified sub string in the target string and returns the found position starting from zero. If not found, it returns <code>nil</code>.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str.find('fox')  // returns 16
str.find('cat')  // returns nil
</code></pre>
<p>
Method <code>string#replace()</code> replaces the sub string with the specified one.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str.replace('fox', 'cat') // returns 'The quick brown cat jumps over the lazy dog'
</code></pre>
<p>
Method <code>string#startswith()</code> returns <code>ture</code> if the string starts with the specified sub string, and returns <code>false</code> otherwise. Method <code>string#endswith()</code> checks if the string ends with the specified sub string.
</p>
<pre><code>str = 'abcdefghijklmnopqrstuvwxyz'
str.startswith('abcde') // returns true
str.startswith('hoge')  // returns false
str.endswith('vwxyz')   // returns true
str.endswith('hoge')    // returns false
</code></pre>
<p>
Specifying an attribute <code>:rest</code> indicates that these functions return a string excluding the specified sub string when that matches the head or the bottom part. If the sub string doesn't match, they would return <code>nil</code>.
</p>
<pre><code>str.startswith('abcde):rest // returns 'fghijklmnopqrstuvwxyz'
str.startswith('hoge'):rest // returns nil
str.endswith('vwxyz'):rest  // returns 'abcdefghijklmnopqrstu'
str.endswith('hoge'):rest   // returns nil
</code></pre>
<h2><span class="caption-index-2">13.3</span><a name="anchor-13-3"></a>Formatter</h2>
<h2><span class="caption-index-2">13.4</span><a name="anchor-13-4"></a>Functions Equipped with Formatter</h2>
<p>
You can use format specifiers in some functions that are similar to what are realized in C language's <code>printf</code> to convert objects like numbers into readable strings.
</p>
<p>
Function <code>printf()</code> takes a string containing format specifiers and values you want to print in its argument list and put the result out to <code>sys.stdout</code> stream.
</p>
<pre><code>printf('x = %d, y = %d\n', x, y)
</code></pre>
<p>
Method <code>stream#printf()</code> has the same argument declaration with <code>printf()</code> and puts the result to the target stream capable of writing instead of <code>sys.stdout</code> stream.
</p>
<pre><code>open('foo.txt', 'w').printf('x = %d, y = %d\n', x, y)
</code></pre>
<p>
Method <code>list#printf()</code> is another form of <code>printf()</code>, which takes values to print in the list of the target instance, not in the argument list.
</p>
<pre><code>[x, y].printf('x = %d, y = %d\n')
</code></pre>
<p>
Function <code>format()</code> takes arguments in the same way as <code>printf()</code> but it returns the result as a <code>string</code> instance.
</p>
<pre><code>str = format('x = %d, y = %d\n', x, y)
</code></pre>
<p>
You can also use <code>%</code> operator to get the same result with <code>format()</code>, which takes a format string on the left and a list containing values for printing on the right.
</p>
<pre><code>str = 'x = %d, y = %d\n' % [x, y]
</code></pre>
<p>
If there's only one value for printing, you can even give the operator the value without a list.
</p>
<pre><code>str = 'x = %d\n' % x
</code></pre>
<h2><span class="caption-index-2">13.5</span><a name="anchor-13-5"></a>Syntax of Format Specifier</h2>
<p>
A format specifier begins with a percent character and has the syntax below, where optional fields are embraced by square brackets:
</p>
<pre><code>%[flags][width][.precision]specifier
</code></pre>
<p>
You always have to specify one of the following characters for the <code>specifier</code> field.
</p>
<p>
<table>
<tr>
<th>
specifier</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>d</code>, <code>i</code></td>
<td>
decimal integer number with a sign mark</td>
</tr>

<tr>
<td>
<code>u</code></td>
<td>
decimal integer number wihout a sign mark</td>
</tr>

<tr>
<td>
<code>b</code></td>
<td>
binary integer number without a sign mark</td>
</tr>

<tr>
<td>
<code>o</code></td>
<td>
octal integer number without a sign mark</td>
</tr>

<tr>
<td>
<code>x</code></td>
<td>
hexadecimal integer number in lower character without a sign mark</td>
</tr>

<tr>
<td>
<code>X</code></td>
<td>
hexadecimal integer number in upper character without a sign mark</td>
</tr>

<tr>
<td>
<code>e</code></td>
<td>
floating number in exponential form</td>
</tr>

<tr>
<td>
<code>E</code></td>
<td>
floating number in exponential form (in upper character)</td>
</tr>

<tr>
<td>
<code>f</code></td>
<td>
floating number in decimal form</td>
</tr>

<tr>
<td>
<code>g</code></td>
<td>
better form between e and f</td>
</tr>

<tr>
<td>
<code>G</code></td>
<td>
better form between E and F</td>
</tr>

<tr>
<td>
<code>s</code></td>
<td>
string</td>
</tr>

<tr>
<td>
<code>c</code></td>
<td>
character</td>
</tr>

</table>

</p>
<p>
You can specify one of the following characters for the optional <code>flags</code> field.
</p>
<p>
<table>
<tr>
<th>
flags</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>+</code></td>
<td>
<code>+</code> precedes for positive numbers</td>
</tr>

<tr>
<td>
<code>-</code></td>
<td>
adjust a string to left</td>
</tr>

<tr>
<td>
(space)</td>
<td>
space character precedes for positive numbers</td>
</tr>

<tr>
<td>
<code>#</code></td>
<td>
converted results of binary, octdecimal and hexadecimal are
  preceded by <code>'0b'</code>, <code>'0'</code> and <code>'0x'</code> respectively</td>
</tr>

<tr>
<td>
<code>0</code></td>
<td>
fill lacking columns with <code>'0'</code></td>
</tr>

</table>

</p>
<p>
The optional field <code>width</code> takes a decimal number that specifies a minimum width for the corresponding value. If the value's length is shorter than the specified width, the rest would be filled with space characters. If you specify <code>*</code> for that field, the formatter would try to get the minimum width from the argument list.
</p>
<p>
The optional field <code>precision</code> has different meanings depending on the specifier as below:
</p>
<p>
<table>
<tr>
<th>
specifier</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>d</code>, <code>i</code>, <code>u</code>, <code>b</code>, <code>o</code>, <code>x</code>, <code>X</code></td>

  <td>
It specifies the minimum number of digits. If the value is shorter than this number,
    lacking digits are filled with zero.</td>
</tr>

<tr>
<td>
<code>e</code>, <code>E</code>, <code>f</code></td>

  <td>
It specifies the number of digits after a decimal point.</td>
</tr>

<tr>
<td>
<code>g</code>, <code>G</code></td>

  <td>
It specifies the maximum number of digits for significand part.</td>
</tr>

<tr>
<td>
<code>s</code></td>

  <td>
It specifies the maximum number of characters to print.</td>
</tr>

</table>

</p>
<h2><span class="caption-index-2">13.6</span><a name="anchor-13-6"></a>Regular Expression</h2>
<p>
You can import module <code>re</code> to use regular expression for string search and substition, which supports a syntax based on POSIX Extended Regular Expression.
</p>
<p>
Importing module <code>re</code> would equip <code>string</code> class with methods that can handle regular expressions. See the sample code below:
</p>
<pre><code>import(re)

str = '12:34:56'

m = str.match(r'(\d\d):(\d\d):(\d\d)')
if (m) {
    printf('hour=%s, min=%s, sec=%s\n', m[1], m[2], m[3])
} else {
    println('not match')
}
</code></pre>
<p>
Method <code>string#match()</code> that is provided by <code>re</code> module takes a regular expression pattern. It would return <code>re.match</code> instance if the pattern matches, and return <code>nil</code> otherwise. As regular expressions often contain back slash as a meta character, it would be convenient to use an expression <code>r'</code> &hellip; <code>'</code> for a pattern string to avoid recognizing a backslash as an escaping character.
</p>
<p>
An instance of <code>re.match</code> contains information about matching result. It supports indexing access where <code>m[0]</code> has a string that matches the whole pattern and <code>m[1]</code>, <code>m[2]</code> &hellip; returns a string of each group. You can specify a string instead of a number to index each group when you use <code>?&lt;name&gt;</code> specifier for the group in a regular expression pattern.
</p>
<pre><code>m = str.match(r'(?&lt;hour&gt;\d\d):(?&lt;min&gt;\d\d):(?&lt;sec&gt;\d\d)')
if (m) {
    printf('hour=%s, min=%s, sec=%s\n', m['hour'], m['min'], m['sec'])
} else {
    println('not match')
}
</code></pre>
<p>
Although you can pass a string containing a pattern to method <code>string#match()</code>, it actually takes <code>re.pattern</code> instance in its argument that is capable of accepting a <code>string</code> instance through casting feature. Above example is equivalent with below:
</p>
<pre><code>pat = re.pattern(r'(\d\d):(\d\d):(\d\d)')
m = str.match(pat)
</code></pre>
<p>
When you give a string to a function or a method that expects <code>re.pattern</code>, it always compile the string to create <code>re.pattern</code> instance, which may cause some overhead in a process of huge amount of data. In such a case, it may be a good idea to call a function with a <code>re.pattern</code> instance that has explicitly been created by <code>re.pattern()</code> function in advance like shown above.
</p>
<p>
Method <code>string#sub()</code> takes a <code>re.pattern</code> instance and replaces the matched part with the given substitution value.
</p>
<p>
A subsitution item can be either a string or a function. When you give a string for it, the method replaces the matched part with the string.
</p>
<pre><code>str = 'The quick brown fox jumps over the lazy dog'
str.sub(r'[Tt]he', 'THE') // returns 'THE quick brown fox jumps over THE lazy dog'
</code></pre>
<p>
You can specify a group reference <code>\</code><em>n</em> in a subsitution string where <em>n</em> indicates the group index.
</p>
<p>
If you specify a function for the substitution value, which takes a <code>re.match</code> value as its argument and to return a substitution string, it would be called when the matching succeeds.
</p>
<pre><code>str = '### #### ##### ## #####'
f(m:re.match) = format('%d', m[0].len())
str.sub('#+', f)                             // returns '3 4 5 2 5'
</code></pre>
<p>
An anonymous function would make the code more simple.
</p>
<pre><code>str = '### #### ##### ## #####'
str.sub('#+', &amp;{format('%d', $m[0].len())})  // returns '3 4 5 2 5'
</code></pre>
<h2><span class="caption-index-2">13.7</span><a name="anchor-13-7"></a>Operation on Binary</h2>
<h3><span class="caption-index-3">13.7.1</span><a name="anchor-13-7-1"></a>Creation of Instance</h3>
<p>
You can create a <code>binary</code> instance by put a prefix <code>b</code> to a string literal.
</p>
<pre><code>b'AB\x01\x00\xff'
</code></pre>
<p>
The example above is a <code>binary</code> instance that contains a sequence of byte data: 0x41, 0x42, 0x01, 0x00 and 0xff. As an instance created by a string literal prefixed by <code>b</code> can not be modified, it would occur an error when you try some modification operations on such an instance.
</p>
<p>
There are several ways to create a <code>binary</code> instance that accepts modification.
</p>
<ul>
<li><p>
Constructor function <code>binary()</code> creates an empty <code>binary</code> instance.
</p>
<pre><code>  buff = binary()
</code></pre>
</li>
<li><p>
Class method <code>binary.alloc()</code> creates a <code>binary</code> instance of the specified size.
</p>
<pre><code>  buff = binary.alloc(1000)
  // buff has a memory of 1000 bytes
</code></pre>
</li>
<li><p>
Class method <code>binary.pack()</code> packs values into a binary sequence according to the packing specifier.
</p>
<pre><code>  buff = binary.pack('Bl', 0xaa, 0x12345678)
  // buff has a byte sequence: 0xaa, 0x78, 0x56, 0x34, 0x12.
</code></pre>
</li>
</ul>
<p>
You can use method <code>binary#dump()</code> to print out a content of a <code>binary</code> in a hexadecimal dump format.
</p>
<h3><span class="caption-index-3">13.7.2</span><a name="anchor-13-7-2"></a>Byte Manipulation</h3>
<p>
An index access on a <code>binary</code> would return a number value at the specified position.
</p>
<pre><code>buff = b'\xaa\xbb\xcc\xdd\xee'
buff[0] // returns 0xaa
buff[1] // returns 0xbb
</code></pre>
<p>
You can also specify an iterator as an indexing item for a binary just like a string.
</p>
<pre><code>buff[1..3] // returns [0xbb, 0xcc, 0xdd]
</code></pre>
<p>
Modification through an indexer on a writable binary is also possible.
</p>
<pre><code>buff = binary.alloc(8)
buff[0] = 0x12
buff[1] = 0x34
buff[3..] = 0..4
// buff has a byte sequence: 0x12, 0x34, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04.
</code></pre>
<p>
Method <code>binary#each()</code> creates an iterator that returns each 8-bit number value in the binary.
</p>
<pre><code>buff = b'\xaa\xbb\xcc\xdd\xee'
x = buff.each()
// x is an iterator that returns 0xaa, 0xbb, 0xcc, 0xdd and 0xee.
</code></pre>
<h3><span class="caption-index-3">13.7.3</span><a name="anchor-13-7-3"></a>Pack and Unpack</h3>
<p>
Using an indexer and <code>binary#each()</code> method, you can retrieve and modify the content of a binary by a unit of 8-bit number. To store and extract values such as number that consits of multiple octets and string that contains a sequence of character codes, the following methods are provided.
</p>
<ul>
<li>Class method <code>binary.pack()</code> to create a binary sequence that contains numbers and strings.</li>
<li>Method <code>binary#unpack()</code> to extract numbers and strings from a binary sequence.</li>
</ul>
<p>
Class method <code>binary.pack()</code> takes a formatter string containing specifiers and values to store as its argument. For example:
</p>
<pre><code>rtn = binary.pack('H', 0x1234)
</code></pre>
<p>
The specifier <code>H</code> means an unsigned 16-bit number, so the result <code>rtn</code> is a <code>binary</code> instance that contains a binary sequence of 0x34 and 0x12.
</p>
<p>
You can write any number of specifiers in the format.
</p>
<pre><code>rtn = binary.pack('HHH', 0x1234, 0xaabb, 0x5678)
</code></pre>
<p>
The result contains a binary sequence of 0x34, 0x12, 0xbb, 0xaa, 0x78 and 0x56.
</p>
<p>
If there's a sequence of the same specifier like above, you can brackets them together by specifying the number ahead of that specifier.
</p>
<pre><code>rtn = binary.pack('3H', 0x1234, 0xaabb, 0x5678)
</code></pre>
<p>
This has the same result as the previous example.
</p>
<p>
Meanwhile, method <code>binary#unpack()</code> takes a formatter string and returns a list containing unpacked result. For example:
</p>
<pre><code>buff = b'\x34\x12'
rtn = buff.unpack('H')
</code></pre>
<p>
The result <code>rtn</code> is a list <code>[0x1234]</code>. Note that you always get a list as the result even when it contains only one value.
</p>
<p>
Below is an example of a format that contains multiple specifiers:
</p>
<pre><code>buff = b'\x34\x12\xbb\xaa\x78\x56'
rtn = buff.unpack('HHH')
// rtn is [0x1234, 0xaabb, 0x5678]
</code></pre>
<p>
Just like the packing rule, you can specify the number of succeeding specifiers.
</p>
<pre><code>buff = b'\x34\x12\xbb\xaa\x78\x56'
rtn = buff.unpack('3H')
</code></pre>
<p>
Using an assignment to lister expression may often be helpful, since you can assign extracted values to independent variables.
</p>
<pre><code>buff = b'\x34\x12\xbb\xaa\x78\x56'
[x, y, z] = buff.unpack('3H')
</code></pre>
<p>
The table below summarizes specifiers that are used to pack or unpack number values.
</p>
<p>
<table>
<tr>
<th>
Specifier</th>
<th>
Unit Size</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>b</code></td>
<td>
1 byte</td>
<td>
Packs or unpacks a signed 8-bit number (-128 to 127).</td>
</tr>

<tr>
<td>
<code>B</code></td>
<td>
1 byte</td>
<td>
Packs or unpacks an unsigned 8-bit number (0 to 255)</td>
</tr>

<tr>
<td>
<code>h</code></td>
<td>
2 bytes</td>
<td>
Packs or unpacks a signed 16-bit number (-32768 to 32767)</td>
</tr>

<tr>
<td>
<code>H</code></td>
<td>
2 bytes</td>
<td>
Packs or unpacks an unsigned 16-bit number (0 to 65535)</td>
</tr>

<tr>
<td>
<code>i</code></td>
<td>
4 bytes</td>
<td>
Packs or unpacks a signed 32-bit number (-2147483648 to 2147483648)</td>
</tr>

<tr>
<td>
<code>I</code></td>
<td>
4 bytes</td>
<td>
Packs or unpacks an unsigned 32-bit number (0 to 4294967295)</td>
</tr>

<tr>
<td>
<code>l</code></td>
<td>
4 bytes</td>
<td>
Packs or unpacks a signed 32-bit number (-2147483648 to 2147483648)</td>
</tr>

<tr>
<td>
<code>L</code></td>
<td>
4 bytes</td>
<td>
Packs or unpacks an unsigned 32-bit number (0 to 4294967295)</td>
</tr>

<tr>
<td>
<code>q</code></td>
<td>
8 bytes</td>
<td>
Packs or unpacks a signed 64-bit number (-9223372036854775808 to 9223372036854775807)</td>
</tr>

<tr>
<td>
<code>Q</code></td>
<td>
8 bytes</td>
<td>
Packs or unpacks an unsigned 64-bit number (0 to 18446744073709551615)</td>
</tr>

<tr>
<td>
<code>f</code></td>
<td>
4 bytes</td>
<td>
Packs or unpacks a single precision floating point number.</td>
</tr>

<tr>
<td>
<code>d</code></td>
<td>
8 bytes</td>
<td>
Packs or unpacks a double precision floating point number.</td>
</tr>

</table>

</p>
<p>
By default, byte order of numbers in 16-bit, 32-bit and 64-bit size is a little endian. You can change the order by using the following specifiers:
</p>
<p>
<table>
<tr>
<th>
Specifier</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>@</code></td>
<td>
Turns to a system-dependent endian.</td>
</tr>

<tr>
<td>
<code>=</code></td>
<td>
Turns to a system-dependent endian.</td>
</tr>

<tr>
<td>
<code>&lt;</code></td>
<td>
Turns to a little endian.</td>
</tr>

<tr>
<td>
<code>&gt;</code></td>
<td>
Turns to a big endian.</td>
</tr>

<tr>
<td>
<code>!</code></td>
<td>
Turns to a big endian.</td>
</tr>

</table>

</p>
<pre><code>rtn = binary.pack('H&gt;H', 0x1234, 0x1234)
// rtn contains 0x34, 0x12, 0x12, 0x34.
</code></pre>
<p>
Specifier <code>x</code> only advances pointer ahead for specified size without packing or unpacking of values. When packing, the skipped area would be filled with zero.
</p>
<pre><code>rtn = binary.pack('H3xH', 0x1234, 0x1234)
// rtn contains 0x34, 0x12, 0x00, 0x00, 0x00, 0x34, 0x12.
</code></pre>
<p>
Specifiers <code>c</code> and <code>s</code> are prepared to pack or unpack string data.
</p>
<p>
<table>
<tr>
<th>
Specifier</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>c</code></td>
<td>
Packs a first character code in a string,
 or unpack a 8-bit number as a chracter code and returns a string containing it.</td>
</tr>

<tr>
<td>
<code>s</code></td>
<td>
Packs character codes in a string according to the specified codec,
 or unpack 8-bit numbers as character codes according the specified codec and returns a string containing them.</td>
</tr>

</table>

</p>
<p>
You can specify a codec for <code>s</code> specifier by surrounding its name with <code>{</code> and <code>}</code>.
</p>
<h3><span class="caption-index-3">13.7.4</span><a name="anchor-13-7-4"></a>Pointer</h3>
<p>
<code>binary#pointer()</code>
</p>
<p>
<code>pointer#unpack()</code>
</p>
<p>
<code>pointer#pack()</code>
</p>
<h3><span class="caption-index-3">13.7.5</span><a name="anchor-13-7-5"></a>Binary as Stream</h3>
<p>
<code>binary#writer()</code>
</p>
<p>
<code>binary#reader()</code>
</p>
<p>
cast from <code>binary</code> to <code>stream</code>
</p>
<p />

{% endraw %}
