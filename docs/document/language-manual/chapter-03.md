---
layout: default
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">3</span><a name="anchor-3"></a>Syntax</h1>
<h2><span class="caption-index-2">3.1</span><a name="anchor-3-1"></a>Overview</h2>
<p>
Gura's parser consits of two parts: token parser and syntax parser.
</p>
<p>
The token parser is responsible of splitting a text into tokens that represent atomic factors in a program. Section "Token" explains about how the tokens should be described in a code and about their traits.
</p>
<p>
The syntax parser will build up expressions from tokens following Gura's syntax rule. While a program is running, the interpreter reads the expressions and executes them along with Environment status. Section "Expression" explains about what tokens compose each expression and about relationship between expressions using class diagrams.
</p>
<h2><span class="caption-index-2">3.2</span><a name="anchor-3-2"></a>Token</h2>
<h3><span class="caption-index-3">3.2.1</span><a name="anchor-3-2-1"></a>Symbol</h3>
<p>
A symbol is used as a name of variable, function, symbol, type name, attribute and suffix.
</p>
<p>
A symbol starts with a UTF-8 leading byte or one of following characters:
</p>
<pre><code>a b c d e f g h i j k l m n o p q r s t u v w x y z
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
_ $ @
</code></pre>
<p>
and is followed by UTF-8 leading or trailing byte or characters shown below:
</p>
<pre><code>a b c d e f g h i j k l m n o p q r s t u v w x y z
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
_ $ @
0 1 2 3 4 5 6 7 8 9
</code></pre>
<p>
Here are some valid symbols:
</p>
<pre><code>foo
test_result
$foo
@bar@
test_1_var
</code></pre>
<p>
Special symbols:
</p>
<pre><code>%

+  *  ?  -
</code></pre>
<h3><span class="caption-index-3">3.2.2</span><a name="anchor-3-2-2"></a>Number Literal</h3>
<p>
A decimal number is the most common number literal.
</p>
<pre><code>0 1234 999999
</code></pre>
<p>
A floating-point number that sometimes comes with an exponential expression is also acceptable.
</p>
<pre><code>3.14  10.  .001  1e100  3.14e-10  0e0
</code></pre>
<p>
A sequence of characters that starts with <code>0b</code> or <code>0B</code> and contains <code>0</code> or <code>1</code> represents a binary number.
</p>
<pre><code>0b01010101
</code></pre>
<p>
A sequence of characters that starts with <code>0</code> and contains digit characters between <code>0</code> and <code>7</code> represents an octal number.
</p>
<pre><code>01234567
</code></pre>
<p>
A sequence of characters that starts with <code>0x</code> or <code>0X</code> and contains digit characters and alphabet characters between <code>a</code> and <code>f</code> or between <code>A</code> and <code>F</code> represents a hexadecimal number.
</p>
<pre><code>0x7feaa00
0x7FEAA00
</code></pre>
<p>
A suffix symbol can be appended after a number literal to convert it into other types rather than <code>number</code>. Two suffix symbols are available as standard.
</p>
<p>
<table>
<tr>
<th>
Suffix Symbol</th>
<th>
Function</th>
</tr>

<tr>
<td>
<code>j</code></td>
<td>
Converts into <code>complex</code> type.
An expression <code>3j</code> is equivalent with <code>complex(0, 3)</code>.</td>
</tr>

<tr>
<td>
<code>r</code></td>
<td>
Converts into <code>rational</code> type.
An expression <code>3r</code> is equivalent with <code>rational(3, 0)</code>.</td>
</tr>

</table>

</p>
<p>
Importing modules may add other suffix symbols. For instance, importing a module named <code>gmp</code>, which calculates numbers in arbitrary precision, would add a suffix <code>L</code> that represents numbers that may consist of many digits.
</p>
<p>
You can also add your own suffix symbols by using Suffix Manager that is responsible for managing suffix symbols and their associated functions.
</p>
<h3><span class="caption-index-3">3.2.3</span><a name="anchor-3-2-3"></a>String Literal</h3>
<p>
A string literal is a sequence of characters surrounded by a pair of single or double quotations. A string surrounded by single quotations can contain double quotation characters in its body while a string with double quotations can have single quotation characters inside.
</p>
<pre><code>'Hello "World"'
"Hello 'World'"
</code></pre>
<p>
Although you can choose one of them case by case, single quotation is more preferable in general.
</p>
<p>
Within a string literal, you can use following escape characters.
</p>
<p>
<table>
<tr>
<th>
Escape Character</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>\\</code></td>
<td>
back slash</td>
</tr>

<tr>
<td>
<code>\'</code></td>
<td>
single quotation</td>
</tr>

<tr>
<td>
<code>\"</code></td>
<td>
double quotation</td>
</tr>

<tr>
<td>
<code>\a</code></td>
<td>
bell</td>
</tr>

<tr>
<td>
<code>\b</code></td>
<td>
back space</td>
</tr>

<tr>
<td>
<code>\f</code></td>
<td>
page feed</td>
</tr>

<tr>
<td>
<code>\r</code></td>
<td>
carriage return</td>
</tr>

<tr>
<td>
<code>\n</code></td>
<td>
line feed</td>
</tr>

<tr>
<td>
<code>\t</code></td>
<td>
tab</td>
</tr>

<tr>
<td>
<code>\v</code></td>
<td>
vertical tab</td>
</tr>

<tr>
<td>
<code>\0</code></td>
<td>
null character</td>
</tr>

<tr>
<td>
<code>\x<em>hh</em></code></td>
<td>
any byte of character code <code><em>hh</em></code> in hexadecimal</td>
</tr>

<tr>
<td>
<code>\u<em>hhhh</em></code></td>
<td>
Unicode character at codepoint <code><em>hhhh</em></code> in hexadecimal</td>
</tr>

<tr>
<td>
<code>\U<em>hhhhhhhh</em></code></td>
<td>
Unicode character at codepoint <code><em>hhhhhhhh</em></code> in hexadecimal</td>
</tr>

</table>

</p>
<p>
If a string is prefixed by <code>r</code>, a back slash is treated as a normal character, not one for escaping. This feature is convenient to describe a path name in Windows style and a regular expression that often uses back slash as a metacharacter.
</p>
<pre><code>r'C:\users\foo\bar.txt'
r'(\w+) (\d+):(\d+):(\d)'
</code></pre>
<p>
You can describe a string containing multiple lines by surrounding it with a triple sequence of single or double quotations.
</p>
<pre><code>'''
ABCD
EFGH
IJKL
'''

"""
ABCD
EFGH
IJKL
"""
</code></pre>
<p>
These codes are equivalent to an expression <code>'\nABCD\nEFGH\nIJKL\n'</code>, which contains a line-feed character at the beginning. If you want to eliminate the first line-feed, you need to begin the string body right after the starting quotations or put a back slash at that position followed by a line feed since a back slash placed at end of a line results in an elimination of the tailing line feed.
</p>
<pre><code>'''ABCD
EFGH
IJKL
'''

'''\
ABCD
EFGH
IJKL
'''
</code></pre>
<p>
Both of the examples above have the same result <code>'ABCD\nEFGH\nIJKL\n'</code>.
</p>
<p>
You can also specify <code>r</code> prefix for the multi-lined string so that it can contain back slash characters without escaping. In this case, you cannot use the second example shown above because a back slash doesn't work to eliminate a line feed. For such a case, a prefix <code>R</code> is useful, which eliminates a line feed that appears right after the starting quotation.
</p>
<pre><code>R'''
ABCD
EFGH
IJKL
'''
</code></pre>
<p>
This is parsed as <code>'ABCD\nEFGH\nIJKL\n'</code>.
</p>
<p>
The prefix <code>R</code> also removes indentation characters that appear at each line.
</p>
<pre><code>if (flag) {
    print(R'''
    ABCD
    EFGH
    IJKL
    ''')
}
</code></pre>
<p>
Assuming that there are four spaces before the expression <code>print(R'''</code>, the parser would remove four spaces at top of each line within the multi-lined string. This feature helps you describe multi-lined strings in indented blocks without disarranging the appearance.
</p>
<p>
A string literal prefixed by <code>b</code> would be treated as a sequence of binary data instead of character code.
</p>
<p>
A string literal prefixed by <code>e</code> would be treated as a string that may contain embedded scripts written in a manner for the template engine.
</p>
<p>
A string literal can also be appended by a suffix symbol that has been registered in Suffix Manager. There's no built-in suffix for string literals.
</p>
<h3><span class="caption-index-3">3.2.4</span><a name="anchor-3-2-4"></a>Operator</h3>
<p>
An Operator takes one or two values as its inputs and returns a calculation result. It's categorized in the following types:
</p>
<ul>
<li><p>
<strong>Prefixed Unary Operator</strong> takes an input value specified after it.
</p>
<pre><code>+  -  ~  !
</code></pre>
<p>
An example code of a Prefixed Unary Operator comes like "<code>+x</code>".
</p>
</li>
<li><p>
<strong>Suffixed Unary Operator</strong> takes an input value specified before it.
</p>
<pre><code>?  ..
</code></pre>
<p>
An example code of a Suffixed Unary Operator comes like "<code>x?</code>".
</p>
</li>
<li><p>
<strong>Binary Operator</strong> takes two input values specified on both sides of them.
</p>
<pre><code>+  -  *  /  %  **  ==  !=  &gt;  &lt;  &gt;=  &lt;=  &lt;=&gt;
in  &amp;  |  ^  &lt;&lt;  &gt;&gt;  ||  &amp;&amp;  ..  =&gt;
</code></pre>
<p>
An example code of a Binary Operator comes like "<code>x + y</code>".
</p>
</li>
</ul>
<p>
See section <a href="Operator.html">Operator</a> for more detail.
</p>
<h3><span class="caption-index-3">3.2.5</span><a name="anchor-3-2-5"></a>Bracket</h3>
<p>
Multiple expressions can be grouped by surronding them with a pair of brackets. There are three types of brackets as listed below.
</p>
<ul>
<li><p>
<strong>Square bracket</strong>: <code>[A, B, C]</code>
</p>
<p>
When it appears right after an expression that has a value as a result of evaluation, it works as an indexer that allows indexing access in the preceding value.
</p>
<pre><code>x[3]  foo['key']
</code></pre>
<p>
Otherwise, it forms a list of expressions that is set to create a <code>list</code> instance after evaluation.
</p>
<pre><code>[1, 2, 3, 4]
</code></pre>
</li>
<li><p>
<strong>Parenthesis</strong>: <code>(A, B, C)</code>
</p>
<p>
When it appears right after an expression that has a value as a result of evaluation, it's used as an argument list to evaluate the preceding value as a callable.
</p>
<pre><code>f(1, 2, 3)
</code></pre>
<p>
Otherwise, it forms a list of expressions that is set to create an <code>iterator</code> instance after evaluation.
</p>
<pre><code>(1, 2, 3, 4)
</code></pre>
</li>
<li><p>
<strong>Curly bracket</strong>: <code>{A, B, C}</code>
</p>
<p>
It forms a list of expressions called Block. In general, a Block is used as a body for function assignment or provides a procedual part in calling a function.
</p>
<pre><code>f() = { println('hello') }
</code></pre>
</li>
<li><p>
<strong>Vertical Bar</strong>: <code>|A, B, C|</code>
</p>
<p>
This only appears right after opening bracket of Block and is called Block Parameter.
</p>
<pre><code>repeat (3) {|i| println(i)}
</code></pre>
<p>
If an element contains an operator "<code>|</code>" in it, it must be embraced by parentheses to avoid the parser from mistaking the operator as Block Parameter's terminater.
</p>
<pre><code>|(a | b), c, d|
</code></pre>
</li>
</ul>
<p>
Expressions within brackets can be separated by a comma character or a line feed. The following two codes have the same result.
</p>
<pre><code>[1, 2, 3, 4]

[1
2
3
4
]
</code></pre>
<h3><span class="caption-index-3">3.2.6</span><a name="anchor-3-2-6"></a>Back Quote</h3>
<p>
A symbol preceded by a back quote creates an instance of <code>symbol</code> data type.
</p>
<pre><code>`foo  `bar
</code></pre>
<p>
Each values of <code>symbol</code> data type has a unique number that is assigned at parsing phase, which enables quick identification between them.
</p>
<p>
Any other expressions that have a back quote appended ahead create an instance of <code>expr</code> data type.
</p>
<pre><code>`(a + b)  `func()
</code></pre>
<p>
As an <code>expr</code> instance can hold any code without any evaluation, it can be used to pass a procedure itself to a function as one of the arguments.
</p>
<h3><span class="caption-index-3">3.2.7</span><a name="anchor-3-2-7"></a>Comment</h3>
<p>
There are two types of comments: line comment and block comment.
</p>
<p>
A line comment begins with a marker <code>#</code> or <code>//</code> and lasts until end of the line.
</p>
<pre><code># this is a comment

// and this is too

x = 10 // comment after code
</code></pre>
<p>
A block comment begins with a marker <code>/*</code> and ends with <code>*/</code>. It can contain multiple lines and even other block comments nested as long as pairs of the comment markers are matched.
</p>
<p>
Following are valid examples of block comment.
</p>
<pre><code>/* block comment */

/*
block comment
*/

/* /* /* nested comment */ */ */
</code></pre>
<h2><span class="caption-index-2">3.3</span><a name="anchor-3-3"></a>Expression</h2>
<h3><span class="caption-index-3">3.3.1</span><a name="anchor-3-3-1"></a>Class Diagram of Expression</h3>
<p>
The following figure shows a hierarchy of expressions.
</p>
<pre><code>Expr &lt;-+- Value
       +- EmbedString
       +- Identifier
       +- Suffixed
       +- Member
       +- Unary &lt;-----+- UnaryOp
       |              `- Quote
       +- Binary &lt;----+- BinaryOp
       |              `- Assign
       +- Collector &lt;-+- Lister
       |              +- Iterer
       |              +- Block
       |              `- Root
       `- Compound &lt;--+- Indexer
                      `- Caller
</code></pre>
<p>
All the expressions are derived from <code>Expr</code> that is an abstract expression.
</p>
<p>
Other abstract expressions, Unary, Binary, Collector and Compound, don't appear in the actual code either, but just provide common functions for their derivations.
</p>
<h3><span class="caption-index-3">3.3.2</span><a name="anchor-3-3-2"></a>Value</h3>
<p>
A <code>Value</code> expression holds a value of <code>number</code>, <code>string</code>, <code>binary</code> type.
</p>
<p>
The class diagram is:
</p>
<pre><code>+----------------------------------+
|              Value               |
|----------------------------------|
|- value: number, string or binary |
+----------------------------------+
</code></pre>
<p>
Those types of value are described with string literal, number literal and b-prefixed string literal in a script respectively.
</p>
<p>
Consider the following expressions:
</p>
<ul>
<li><p>
<code>3.141</code>
</p>
<p>
It has a value of <code>number</code> type.
</p>
</li>
<li><p>
<code>'hello'</code>
</p>
<p>
It has a value of <code>string</code> type.
</p>
</li>
<li><p>
<code>b'\x00\x01\x02\0x03'</code>
</p>
<p>
It has a value of <code>binary</code> type.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.3</span><a name="anchor-3-3-3"></a>EmbedString</h3>
<p>
A <code>EmbedString</code> expression is created when a string literal is prefixed by a character <code>e</code> and contains a <code>template</code> instance as a result of parsing the string.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+
|    EmbedString      |
|---------------------|
|- template: template |
|- str: string        |
+---------------------+
</code></pre>
<p>
When this expression is evaluated, the template is invoked with the current environment to comes up with a string result.
</p>
<h3><span class="caption-index-3">3.3.4</span><a name="anchor-3-3-4"></a>Identifier</h3>
<p>
An <code>Identifier</code> expression consists of a symbol and zero or more attributes trailing after it.
</p>
<p>
An <code>Identifer</code> expression can also contain attributes, where an attribute is a symbol preceded by a colon character. One or more attributes can be described after a symbol of the <code>Identifier</code>.
</p>
<p>
The class diagram is:
</p>
<pre><code>+----------------------------+
|          Identifier        |
|----------------------------|
|- symbol: symbol            |
|- attrs: set of symbol      |
|- attrFront: list of symbol |
|- attrsOpt: set of symbol   |
+----------------------------+
</code></pre>
<p>
Consider the following expressions:
</p>
<ul>
<li><p>
<code>foo</code>
</p>
<p>
It has a symbol <code>foo</code>. Other elements are all blank.
</p>
</li>
<li><p>
<code>foo:attr1:attr2</code>
</p>
<p>
It has a symbol <code>foo</code> and has symbols <code>attr1</code> and <code>attr2</code> as its attrs element.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.5</span><a name="anchor-3-3-5"></a>Suffixed</h3>
<p>
A <code>Suffixed</code> expression has a suffix symbol and a preceding literal of string or number.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+
|      Suffixed       |
|---------------------|
|- body: string       |
|- suffix: symbol     |
+---------------------+
</code></pre>
<p>
Even with a number literal, the body element is stored as a string.
</p>
<p>
Consider the following expressions:
</p>
<ul>
<li><p>
<code>123.45foo</code>
</p>
<p>
It has a string <code>'123.45'</code> as its body and a symbol <code>foo</code> as its suffix.
</p>
</li>
<li><p>
<code>'hello world'bar</code>
</p>
<p>
It has a string <code>'hello world'</code> as its body and a symbol <code>bar</code> as its suffix.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.6</span><a name="anchor-3-3-6"></a>Member</h3>
<p>
A <code>Member</code> expression is responsible for accessing variables in a property owner like instance, class and module. Below are available Member accessors.
</p>
<p>
The class diagram is:
</p>
<pre><code>                                    +----------------+
                              left  |      Expr      |
                           +--------+----------------|
+---------------------+    |        |                |
|       Member        *----+        +----------------+
|---------------------|
|- mode: mode         *----+        +----------------+
+---------------------+    |  right |      Expr      |
                           +--------+----------------|
                                    |                |
                                    +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>x.y</code>
</p>
<p>
It has a <code>normal</code> mode and owns an Identifer expression <code>x</code> as its left and also an Identifier expression <code>y</code> as its right.
</p>
</li>
</ul>
<p>
A Member expression may take one of the following modes.
</p>
<table>
<tr>
<th>
Expression</th>
<th>
Mode</th>
</tr>
<tr>
<td>
<code>x.y</code></td>
<td>
<code>normal</code></td>
</tr>
<tr>
<td>
<code>x::y</code></td>
<td>
<code>map-to-list</code></td>
</tr>
<tr>
<td>
<code>x:*y</code></td>
<td>
<code>map-to-iterator</code></td>
</tr>
<tr>
<td>
<code>x:&amp;y</code></td>
<td>
<code>map-along</code></td>
</tr>
</table>
<p>
Mode <code>normal</code> takes a reference to a property owner as its left's result value.
</p>
<p>
Others are for what is called Member Mapping and take a list or an iterator as its left's result value, each of which expressions is a reference to a property owner.
</p>
<h3><span class="caption-index-3">3.3.7</span><a name="anchor-3-3-7"></a>UnaryOp</h3>
<p>
A <code>UnaryOp</code> expression consists of a unary operator and a child expression on which the operator is applied.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+         +----------------+
|       UnaryOp       |   child |      Expr      |
|---------------------*---------+----------------|
|- operator: operator |         |                |
+---------------------+         +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>-foo</code>
</p>
<p>
It has an operator "<code>-</code>" and owns an Identifer expression as its child.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.8</span><a name="anchor-3-3-8"></a>Quote</h3>
<p>
A <code>Quote</code> expression consists of a back quotation and a child expression that is to be quoted by it.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+         +----------------+
|        Quote        |   child |      Expr      |
|---------------------*---------+----------------|
|                     |         |                |
+---------------------+         +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>`12345</code>
</p>
<p>
It owns an Value expression with a number value as its child.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.9</span><a name="anchor-3-3-9"></a>BinaryOp</h3>
<p>
A <code>BinaryOp</code> expression consists of a binary operator and two child expressions on which the operator is applied.
</p>
<p>
The class diagram is:
</p>
<pre><code>                                    +----------------+
                              left  |      Expr      |
                           +--------+----------------|
+---------------------+    |        |                |
|       BinaryOp      *----+        +----------------+
|---------------------|
|- operator: operator *----+        +----------------+
+---------------------+    |  right |      Expr      |
                           +--------+----------------|
                                    |                |
                                    +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>x + y</code>
</p>
<p>
It has an operator "<code>+</code>" and owns an Identifer expression <code>x</code> as its left and also an Identifier expression <code>y</code> as its right.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.10</span><a name="anchor-3-3-10"></a>Assign</h3>
<p>
An <code>Assign</code> expression consists of an equal symbol, an expression on the left side that is a target of the assignment and an expression on the right side that is an assignment source. An expresion that can be specified on the left is one of <code>Identifer</code>, <code>Lister</code>, <code>Indexer</code>, <code>Caller</code> and <code>Member</code>.
</p>
<p>
The class diagram is:
</p>
<pre><code>                                    +----------------+
                              left  |      Expr      |
                           +--------+----------------|
+---------------------+    |        |                |
|       Assign        *----+        +----------------+
|---------------------|
|- operator: operator *----+        +----------------+
+---------------------+    |  right |      Expr      |
                           +--------+----------------|
                                    |                |
                                    +----------------+
</code></pre>
<p>
The <code>Assign</code> expression also has an operator that is to be applied before assignment. For a normal assignment, that is set to invalid operator.
</p>
<p>
Consider the following expressions:
</p>
<ul>
<li><p>
<code>x = y</code>
</p>
<p>
It owns an Identifer expression <code>x</code> as its left and also an Identifier expression <code>y</code> as its right. The operator is set to invalid.
</p>
</li>
<li><p>
<code>x += y</code>
</p>
<p>
It owns an Identifer expression <code>x</code> as its left and also an Identifier expression <code>y</code> as its right. It also has an operator "<code>+</code>".
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.11</span><a name="anchor-3-3-11"></a>Lister</h3>
<p>
A <code>Lister</code> expression is a series of element expressions embraced by a pair of square brackets.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+           +----------------+
|        Lister       |  elements |      Expr      |
|---------------------*-----------+----------------|
|                     |         * |                |
+---------------------+           +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>[x, y, z]</code>
</p>
<p>
It contains three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its elements.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.12</span><a name="anchor-3-3-12"></a>Iterer</h3>
<p>
An <code>Iterer</code> expression is a series of element expressions embraced by a pair of parentheses.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+           +----------------+
|        Iterer       |  elements |      Expr      |
|---------------------*-----------+----------------|
|                     |         * |                |
+---------------------+           +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>(x, y, z)</code>
</p>
<p>
It contains three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its elements.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.13</span><a name="anchor-3-3-13"></a>Block</h3>
<p>
A <code>Block</code> expression is a series of element expressions embraced by a pair of curly brackets.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+            +----------------+
|        Block        |   elements |      Expr      |
|---------------------*------------+----------------|
|                     |          * |                |
+---------------*-----+            +----------------+
                |
                |                  +----------------+
                | block-parameters |      Expr      |
                +------------------+----------------|
                                 * |                |
                                   +----------------+
</code></pre>
<p>
The <code>Block</code> expression also has a list of block-parameters that appear in a code embraced by a pair of vertical bars right after block's opening curly bracket.
</p>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>{x, y, z}</code>
</p>
<p>
It contains three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its elements.
</p>
</li>
<li><p>
<code>{|a, b, c| x, y, z}</code>
</p>
<p>
It contains three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its elements. It also owns Identifier expressions <code>a</code>, <code>b</code> and <code>c</code> as its block-parameters.
</p>
</li>
</ul>
<p>
If a opening curly bracket appears at the top of a line, the preceding line break would be omitted. This means that the following two examples are identical:
</p>
<pre><code>foo {
}

foo
{
}
</code></pre>
<h3><span class="caption-index-3">3.3.14</span><a name="anchor-3-3-14"></a>Root</h3>
<p>
A <code>Root</code> expression represents a series of element expressions that appear in the top sequence.
</p>
<p>
The class diagram is:
</p>
<pre><code>+---------------------+           +----------------+
|        Root         |  elements |      Expr      |
|---------------------*-----------+----------------|
|                     |         * |                |
+---------------------+           +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>x, y, z</code>
</p>
<p>
It contains three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its elements.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.15</span><a name="anchor-3-3-15"></a>Indexer</h3>
<p>
An <code>Indexer</code> expression consists of a car element and a series of expressions that represent indices.
</p>
<p>
The class diagram is:
</p>
<pre><code>                                       +----------------+
                                   car |      Expr      |
                           +-----------+----------------|
+---------------------+    |           |                |
|       Indexer       *----+           +----------------+
|---------------------|
|                     *----+           +----------------+
+---------------------+    |   indices |      Expr      |
                           +-----------+----------------|
                                     * |                |
                                       +----------------+
</code></pre>
<p>
Consider the following expression:
</p>
<ul>
<li><p>
<code>a[x, y, z]</code>
</p>
<p>
It owns an Identifier expression <code>a</code> as its car element and three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its indices.
</p>
</li>
</ul>
<h3><span class="caption-index-3">3.3.16</span><a name="anchor-3-3-16"></a>Caller</h3>
<p>
A <code>Caller</code> expression consists of a car element and a series of expressions that represent arguments. It may optionally own a Block expression if a block is specified and may own a Caller expression as its trailer if that is described in a leader-trailer syntax.
</p>
<p>
As with an <code>Identifier</code> expression, a <code>Caller</code> expression can also have attributes. They can be described just after a closing parenthesis of an argument list.
</p>
<p>
The class diagram is:
</p>
<pre><code>                                              +----------------+
+----------------------------+            car |      Expr      |
|          Caller            |    +-----------+----------------|
|----------------------------|    |           |                |
|- symbol: symbol            *----+           +----------------+
|- attrs: set of symbol      |
|- attrFront: list of symbol *----+           +----------------+
|- attrsOpt: set of symbol   |    | arguments |      Expr      |
+--------*--------------*----+    +-----------+----------------|
         |              |                   * |                |
         |              +----+                +----------------+
   block | 0..1      trailer | 0..1
+--------+-------+  +--------+-------+
|      Block     |  |     Caller     |
+----------------|  +----------------|
|                |  |                |
+----------------+  +----------------+
</code></pre>
<p>
Consider the following expressions:
</p>
<ul>
<li><p>
<code>a(x, y, z)</code>
</p>
<p>
It owns an Identifier expression <code>a</code> as its car element and three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its arguments. Its block and trailer elements are both invalid.
</p>
</li>
<li><p>
<code>a()</code>
</p>
<p>
It owns an Identifier expression <code>a</code> as its car element. Its arguments is blank.
</p>
</li>
<li><p>
<code>a(x, y, z) {xx, yy, zz}</code>
</p>
<p>
It owns an Identifier expression <code>a</code> as its car element and three Identifier expressions <code>x</code>, <code>y</code> and <code>z</code> as its arguments. It also owns a Block expression as its block element.
</p>
</li>
</ul>
<p>
If two or more <code>Caller</code>s are described in the same line and the preceding one has a block, they have a leader-trailer relationship each other, in which the preceding <code>Caller</code> is dubbed a leader and following one a trailer. A <code>Caller</code> that acts as a leader is the owner of its trailing <code>Caller</code>.
</p>
<p>
Consider the following expressions:
</p>
<ul>
<li><p>
<code>a() {} b()</code>
</p>
<p>
The <code>Caller</code> expression <code>a()</code> owns a <code>Caller</code> expression of <code>b()</code> as its trailer.
</p>
</li>
<li><p>
<code>a() {} b() {} c()</code>
</p>
<p>
The <code>Caller</code> expression <code>a()</code> owns a Caller expression of <code>b()</code> as its trailer, and the Caller expression <code>b()</code> owns the Caller expression <code>c()</code> as well.
</p>
</li>
</ul>
<p>
You only have to put the closing curly bracket at the same line of the trailer, which means that the example below is a valid leader-trailer form.
</p>
<pre><code>a() {
} b()
</code></pre>
<p>
If a trailing caller is associated with a trailer function such as <code>elsif</code>, <code>else</code>, <code>catch</code> and <code>finally</code>, it doesn't need to be at the same line of a closing curly bracket to be treated as a trailer. This feature enables you to write <code>if-elsif-else</code> sequence in the following style:
</p>
<pre><code>if (cond)
{
    // ...
}
elsif (cond)
{
    // ...
}
elsif (cond)
{
    // ...
}
else
{
    // ...
}
</code></pre>
<p>
Also, you can write <code>try-catch-else-finally</code> sequence like followed:
</p>
<pre><code>try
{
    // ...
}
catch (error1)
{
    // ...
}
catch (error2)
{
    // ...
}
catch
{
    // ...
}
else
{
    // ...
}
finally
{
    // ...
}
</code></pre>
<p />

{% endraw %}
