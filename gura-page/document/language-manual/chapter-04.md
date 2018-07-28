---
layout: default
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">4</span><a name="anchor-4"></a>Data Type</h1>
<h2><span class="caption-index-2">4.1</span><a name="anchor-4-1"></a>Overview</h2>
<p>
A value has a corresponding Data Type that defines its behavior and properties.
</p>
<p>
Each Data Type is bound with a type name, which usually appears in argument list of function call.
</p>
<p>
Name spaces for Data Type are completely isolated from those for variable and function names.
</p>
<p>
As each Data Type has a one-to-one relationship with a corresponding Class, those terms have almost the same meaning within documents in many cases.
</p>
<p>
Data types are categorized into two types: <strong>Primitive Data Type</strong> and <strong>Object Data Type</strong>.
</p>
<p>
A value of Primitive Data Type holds its content in as small memory as possible. It doesn't include any Environment in it and doesn't have any methods with side effects. Among them are <code>nil</code>, <code>boolean</code>, <code>complex</code>, <code>number</code>, <code>rational</code>, <code>string</code> and <code>symbol</code> types.
</p>
<p>
A value of Object Data Type owns Object data that is a sort of Environment, which allows operations with side effects. Most Data Types except for what are picked up as Primitive Data Types above belong to this.
</p>
<h2><span class="caption-index-2">4.2</span><a name="anchor-4-2"></a>Primitive Data Types</h2>
<p>
Below is a list of Primitve Data Types, which also shows one of the typical ways to instantiate values of each type.
</p>
<ul>
<li><p>
<code>nil</code>
</p>
<p>
A value of <code>nil</code> type is used to indicate an invalid result or status. It is often used as a returned value of a function when it fails its expected work. A variable <code>nil</code> has a value of nil type.
</p>
<pre><code>nil
</code></pre>
<p>
Since <code>nil</code> is the only instance of <code>nil</code> type, the term <code>nil</code> can both mean the name of the value and its type.
</p>
</li>
<li><p>
<code>boolean</code>
</p>
<p>
Values of <code>boolean</code> type are used to determine whether something is in a true or a false state. Variables named <code>true</code> and <code>false</code> are assigned with a true value and a false value respectively.
</p>
<pre><code>true  false
</code></pre>
<p>
In a function like <code>if</code> having arguments to check true/false condition and in a logical calculation, <code>false</code> and <code>nil</code> only are determined as a false state while other values are treated as a true state. Note that a zero value of <code>number</code> type is recognized as a true, not a false.
</p>
</li>
<li><p>
<code>complex</code>
</p>
<p>
A number literal suffixed by <code>j</code> instantiates a value of <code>complex</code> type that represents a complex number.
</p>
<pre><code>3.14j  1000j  1e3j
</code></pre>
<p>
See chapter <a href="Mathematic-Functions.html">Mathematic Functions</a> for more detail.
</p>
</li>
<li><p>
<code>number</code>
</p>
<p>
A number literal without any suffix instantiates a value of <code>number</code> type.
</p>
<pre><code>3.14  1000  1e3  0xaabb
</code></pre>
</li>
<li><p>
<code>rational</code>
</p>
<p>
A number literal suffixed by <code>r</code> instantiates a value of <code>rational</code> type that represents a rational number.
</p>
<pre><code>3r  123r
</code></pre>
<p>
See chapter <a href="Mathematic-Functions.html">Mathematic Functions</a> for more detail.
</p>
</li>
<li><p>
<code>string</code>
</p>
<p>
A string literal without any suffix instantiates a value of <code>string</code> type.
</p>
<pre><code>'hello world'

R'''
message text
'''
</code></pre>
</li>
<li><p>
<code>symbol</code>
</p>
<p>
An identifier preceded by a back quote instantiates a value of <code>symbol</code> type.
</p>
<pre><code>`foo  `bar
</code></pre>
</li>
</ul>
<h2><span class="caption-index-2">4.3</span><a name="anchor-4-3"></a>Object Data Types Frequently Used</h2>
<h3><span class="caption-index-3">4.3.1</span><a name="anchor-4-3-1"></a>List</h3>
<p>
If one or more elements are surrounced by a pair of square brackets, it would instantiate a value of <code>list</code> type. Any type of value can be an element of lists.
</p>
<pre><code>[3, 1, 4, 1, 5, 9]
['hello', 'world', 3, 4, 5]
</code></pre>
<h3><span class="caption-index-3">4.3.2</span><a name="anchor-4-3-2"></a>Iterator</h3>
<p>
If one or more elements are surrounced by a pair of parentheses, it would instantiate a value of <code>iterator</code> type. Any type of value can be an element of iterators.
</p>
<pre><code>(3, 1, 4, 1, 5, 9)
('hello', 'world', 3, 4, 5)
</code></pre>
<p>
To create an iterator that contains only one element, be sure to put a comma afther the element like following:
</p>
<pre><code>(3,)
</code></pre>
<p>
An expression <code>(3)</code> is recognized as an ordinary value of number <code>3</code>.
</p>
<p>
Operator <code>..</code> creates an iterator that generates a sequence of numbers. An expression <code>x..y</code> creates an iterator that generates a sequence starting from <code>x</code> and being increased by one until <code>y</code>.
</p>
<pre><code>1..10
</code></pre>
<p>
An expression <code>x..</code> creates an iterator that generates a sequence starting from <code>x</code> and being increased by one indefinitely.
</p>
<pre><code>1..
</code></pre>
<p>
Lists and iterators are convertible to each other. For instance, a list can be converted to an iterator by using <code>list#each</code> method like following.
</p>
<pre><code>[3, 1, 4, 1, 5, 9].each()
</code></pre>
<p>
An iterator can be converted to an list by surrounding it with square brackets.
</p>
<pre><code>[1..10]
</code></pre>
<p>
In many cases, an iterator is generated as a value returned from a function, which represents a series of multiple results. The most commonly used function may be <code>readlines</code>, which creates an iterator that reads a stream and returns strings splitted by line.
</p>
<h3><span class="caption-index-3">4.3.3</span><a name="anchor-4-3-3"></a>Dictionary</h3>
<p>
<code>dict</code> is a dictionary that contains key-value pairs as its elements where a key is one of <code>number</code>, <code>string</code> or <code>symbol</code> and a value is of any type.
</p>
<p>
You can create a dictionary by surrounding key-value pairs by <code>%{</code> and <code>}</code>.
</p>
<p>
There are several ways to describe the pairs. The most recommended way is to use <code>=&gt;</code> operator between each key and value like following.
</p>
<pre><code>%{
    `symbol1 =&gt; 'value 1'
    `symbol2 =&gt; 'value 2'
    `symbol3 =&gt; 'value 3'
}
</code></pre>
<p>
A pair can also be described as a list containing a key and a value.
</p>
<pre><code>%{
    [`symbol1, 'value 1']
    [`symbol2, 'value 2']
    [`symbol3, 'value 3']
}
</code></pre>
<p>
You can also describe keys and values alternately in one-dimentional format.
</p>
<pre><code>%{
    `symbol1, 'value 1'
    `symbol2, 'value 2'
    `symbol3, 'value 3'
}
</code></pre>
<h3><span class="caption-index-3">4.3.4</span><a name="anchor-4-3-4"></a>Expression</h3>
<p>
Any expression preceded by a back quote instantiates a value of <code>expr</code> type.
</p>
<pre><code>`(x + y)  `func(x)  `{ println('hello'), x += 1 }
</code></pre>
<h3><span class="caption-index-3">4.3.5</span><a name="anchor-4-3-5"></a>Binary</h3>
<p>
A string literal preceded by <code>b</code> instantiates a value of <code>binary</code> type.
</p>
<pre><code>b'\x00\x01\0x02\0x03'
</code></pre>
<p />

{% endraw %}
