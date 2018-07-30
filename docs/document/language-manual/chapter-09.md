---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">9</span><a name="anchor-9"></a>Flow Control</h1>
<h2><span class="caption-index-2">9.1</span><a name="anchor-9-1"></a>Branch</h2>
<p>
Branch may be the most common flow-control in a program. Just like other programming language, Gura also provides <code>if</code> - <code>elsif</code> - <code>else</code> sequence. However, they're realized as functions, not as statements.
</p>
<p>
These elements are implemented by the following functions.
</p>
<p>
Function <code>if()</code>:
</p>
<pre><code>if (`cond):leader {block}
</code></pre>
<p>
Function <code>elsif()</code>:
</p>
<pre><code>elsif (`cond):leader:trailer {block}
</code></pre>
<p>
Function <code>else()</code>:
</p>
<pre><code>else():trailer {block}
</code></pre>
<p>
They are concatenated with leader-trailer relationship, which means that a closing curly bracket of the preceding function must be in the same line as the top of the succceding one.
</p>
<pre><code>if (x) { /* branch 1 */ } elsif (y) { /* branch 2 */ } else { /* branch 3 */ }
</code></pre>
<p>
Of course, content in a block embraced by a pair of curly brackets may contain multiple lines. This enables you to write a script in a similar syntax as other languages.
</p>
<pre><code>if (x) {

    /* branch 1 */

} elsif (y) {

    /* branch 2 */

} else {

    /* branch 3 */

}
</code></pre>
<p>
Function <code>if()</code> and <code>elsif()</code> check the evaluated result of the expression <code>cond</code>. If it's determined as <code>true</code>, the block procedure will be evaluated, otherwise, the trailing function will be evaluated. Function <code>else()</code> always evaluates its block procedure.
</p>
<p>
Branch sequence has a result value as well. Consider the following code:
</p>
<pre><code>result = if (x &lt; 0) {
    'less than zero'
} elsif (x &gt; 0) {
    'greater than zero'
} else {
    'equal to zero'
}
</code></pre>
<p>
In this case, if <code>x</code> is less than zero, the sequence would have a string <code>'less than zero'</code> as its result. It would have <code>'greater than zero'</code> for <code>x</code> with number greater than zero and <code>'equal to zero'</code> otherwise.
</p>
<p>
If function <code>if()</code> and <code>elsif()</code> have no following <code>else()</code> and their conditions are not evaluated as <code>true</code>, the result value will be <code>nil</code>.
</p>
<pre><code>x = 3
result = if (x &lt; 0) {
    'less than zero'
}
// result is nil
</code></pre>
<h2><span class="caption-index-2">9.2</span><a name="anchor-9-2"></a>Repeat</h2>
<h3><span class="caption-index-3">9.2.1</span><a name="anchor-9-2-1"></a>Repeating Functions</h3>
<p>
This subsection explains about some representative functions that evaluate a procedure repeatedly while it meets a given condition.
</p>
<p>
A function <code>repeat()</code> repeats a procedure for a specific number of times.
</p>
<pre><code>repeat (n?:number) {block}
</code></pre>
<p>
If argument <code>n</code> is omitted, it will repeat the procedure indefinitely.
</p>
<p>
A function <code>while()</code> repeats a procedure while the condition is evaluated as <code>true</code>.
</p>
<pre><code>while (`cond) {block}
</code></pre>
<p>
As a variable <code>cond</code> is an expression, it will be evaluated each time in the loop. In the following example, the function is given with an expression <code>n &lt; 10</code>, which is to be evaluated during the repeating process.
</p>
<pre><code>n = 0
while (n &lt; 10) {
    println('hello')
    n += 1
}
</code></pre>
<p>
A function <code>for()</code> takes one or more expressions of iterable assignments, where an iterable means what can iterate elements including a list and an iterator instance.
</p>
<pre><code>for (`expr+) {block}
</code></pre>
<p>
An iterator assignment is expressed with an operator <code>in</code> like below.
</p>
<p>
<pre>
<code><em>symbol</em> in <em>iterable</em>
[<em>symbol1</em>, <em>symbol2</em> ..] in <em>iterable</em>
</code></pre>

</p>
<p>
In the first format, it assigns <code>symbol</code> with a value in <code>iterable</code> each time in the loop. Below is an example.
</p>
<pre><code>for (name in ['apple', 'grape', 'banana']) {
    // any process
}
</code></pre>
<p>
In the second format, if each element in the iterable is a list, corresponding values in the list are assigned to <code>symbol1</code>, <code>symbol2</code>, and so on. An example is shown below.
</p>
<pre><code>for ([name, yen] in [['apple', 100], ['grape', 200], ['banana', 90]]) {
    // any process
}
</code></pre>
<p>
When a function <code>for()</code> takes more than one iterable assignment, it advances all the iterables one by one at each loop and repeats a procedure until one of the iterables reaches to the end. This means that the loop count is limited up to the smallest length of the iterables. The example below repeats the process three times.
</p>
<pre><code>for (x in [1, 2, 3, 4], y in [1, 2, 3], z in [1, 2, 3, 4, 5]) {
    // any process
}
</code></pre>
<p>
A function <code>cross()</code> takes one or more expressions of iterable assignment and repeats a procedure with all the conceivable combination of elements from the iterables.
</p>
<pre><code>cross (`expr+) {block}
</code></pre>
<p>
In <code>cross()</code> function, an iterable on the right advances at each loop and, when it reaches to its end, it will be rounded up to its first and causes an iterable on its left advance.
</p>
<p>
See the example below:
</p>
<pre><code>cross (x in ['A', 'B', 'C'], y in [1, 2, 3, 4]) {
    print(x, '-', y, ' ')
}
</code></pre>
<p>
The result is:
</p>
<pre><code>A-1 A-2 A-3 A-4 B-1 B-2 B-3 B-4 C-1 C-2 C-3 C-4
</code></pre>
<p>
Using <code>for()</code> function, the above code can be writen like below.
</p>
<pre><code>for (x in ['A', 'B', 'C']) {
    for (y in [1, 2, 3, 4]) {
        print(x, '-', y, ' ')
    }
}
</code></pre>
<p>
Of course, you can specify any number of iterable assignments.
</p>
<pre><code>cross (x in ['A', 'B', 'C'], y in [1, 2, 3, 4], z in ['a', 'b', 'c']) {
    print(x, '-', y, '-', z, ' ')
}
</code></pre>
<h3><span class="caption-index-3">9.2.2</span><a name="anchor-9-2-2"></a>Block Parameter</h3>
<p>
When calling <code>for()</code>, <code>while()</code> and <code>for()</code>, you can specify a block parameter in a format of <code>|i:number|</code> that takes an index number of loop starting from zero. In the following example, the parameter <code>i</code> takes <code>0</code>, <code>1</code>, <code>2</code>, <code>3</code> and <code>4</code> at each loop.
</p>
<pre><code>repeat (5) {|i|
    // any process
}
</code></pre>
<p>
A block parameter for <code>cross()</code> function has a format of <code>|i:number, i1:number, i2:number, ..|</code> where <code>i</code> indicates an index number of loop, and each of <code>i1</code>, <code>i2</code> and so on takes an index number of corresponding iterable.
</p>
<pre><code>cross (x in ['A', 'B', 'C'], y in [1, 2, 3, 4], z in ['a', 'b', 'c']) {|i, ix, iy, iz|
    // any process
}
</code></pre>
<p>
If you don't need indices information, you can omit whole the block parameter or part of its parameters.
</p>
<h3><span class="caption-index-3">9.2.3</span><a name="anchor-9-2-3"></a>Result Value of Repeat</h3>
<p>
Like a branch sequence, a repeat sequence also has a result value that comes from an evaluation of the last expression in the block procedure.
</p>
<p>
In default, among result values that have been generated from each loop, only the last one becomes the final result.
</p>
<pre><code>x = repeat (10) {|i|
    // any process
    i * 10
}
// x is 90
</code></pre>
<p>
When you call a repeat function with <code>:list</code> attribute, it will return a list that contains result values in the loop.
</p>
<pre><code>x = repeat (10):list {|i|
    // any process
    i * 10
}
// x is [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
</code></pre>
<p>
With an attribute <code>:xlist</code>, you can remove <code>nil</code> value from the created list.
</p>
<pre><code>x = repeat (10):xlist {|i|
    // any process
    if (i % 2 == 0) {
        i * 10
    }
}
// x is [0, 20, 40, 60, 80]
</code></pre>
<p>
Using this feature, you can create a list that only contains elements that suit some conditions.
</p>
<p>
Attributes <code>:set</code> and <code>:xset</code> work in a similar way with <code>:list</code> and <code>:xlist</code> respectively, but they would create a list that contains unique values by rejecting a value that already exists in the list.
</p>
<h3><span class="caption-index-3">9.2.4</span><a name="anchor-9-2-4"></a>Flow Control in Repeat Sequence</h3>
<p>
If you want to quit a repeat sequence, you can use <code>break()</code> function. Aiming for a similar appearance with C and Java, you can call <code>break()</code> without a pair of parenthesis for an argument list.
</p>
<pre><code>repeat (10) {|i|
    // any process
    if (i == 5) {
        break
    }
    // not evaluated when break() is called
}
</code></pre>
<p>
The function <code>break()</code> takes an argument of any type that affects a result value of the repeat. When <code>break()</code> is called without an argument, the repeat's result doesn't contain a value of the last loop.
</p>
<pre><code>x = repeat (10):list {|i|
    if (i == 5) {
        break
    }
    i
}
// x is [0, 1, 2, 3, 4]
</code></pre>
<p>
If you call <code>break()</code> with a valid argument, that will be included in the repeat's result.
</p>
<pre><code>x = repeat (10):list {|i|
    if (i == 5) {
        break(99)
    }
    i
}
// x is [0, 1, 2, 3, 4, 99]
</code></pre>
<p>
If you need to go to the next turn of the loop after skipping remaining procedure, you can use <code>continue()</code> function. As with the function <code>break</code>, you can omit a pair of parentheses for an argument list when calling it.
</p>
<pre><code>repeat (10) {|i|
    // any process
    if (i % 2 == 0) {
        continue
    }
    // not evaluated when continue() is called
}
</code></pre>
<p>
When you call <code>continue()</code> with no argument, the repeat's result doesn't contain a value of that loop.
</p>
<pre><code>x = repeat (10):list {|i|
    if (i % 2 == 0) {
        continue
    }
    i
}
// x is [1, 3, 5, 7, 9]
</code></pre>
<p>
If you call <code>continue()</code> with a valid argument, that value will be included in the repeat's result.
</p>
<pre><code>x = repeat (10):list {|i|
    if (i % 2 == 0) {
        continue(99)
    }
    i
}
// x is [99, 1, 99, 3, 99, 5, 99, 7, 99, 9]
</code></pre>
<h3><span class="caption-index-3">9.2.5</span><a name="anchor-9-2-5"></a>Generate Iterator</h3>
<p>
As you've already seen in the above, appending an attribute <code>:list</code> causes the repeating process to create a list that contains evaluated result of each loop as its element. In the following example, <code>x</code> will be a list of <code>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90]</code>.
</p>
<pre><code>x = repeat (10):list {|i|
    // any process
     i * 10
}
</code></pre>
<p>
An attribute <code>:iter</code> would have a more interesting result. Take a look at the code below:
</p>
<pre><code>x = repeat (10):iter {|i|
    // any process
     i * 10
}
</code></pre>
<p>
In this case, repeating process is not executed when the <code>repeat</code> function is evaluated. <code>x</code> is an <em>iterator</em> that generates values of 0, 10, 20, 30, 40, 50, 60, 70, 80 and 90, and these values are available only when the iterator is actually evaluated.
</p>
<p>
The following code shows how to get values from the iterator using Implicit Mapping:
</p>
<pre><code>println(x)
</code></pre>
<p>
Following code evaluates <code>x</code> step by step to confirm that it actually works as an iterator.
</p>
<pre><code>println(x.next())
println(x.next())
println(x.next())
println(x.next())
println(x.next())
</code></pre>
<p>
An attribute <code>:xiter</code> works as <code>:iter</code> except that it will eliminate <code>nil</code> value from its element.
</p>
<pre><code>x = repeat (10):xiter {|i|
    // any process
    if (i % 2 == 0) {
        i * 10
    }
}
</code></pre>
<p>
In the above case, <code>x</code> is an <em>iterator</em> that generates values of 0, 20, 40, 60 and 80.
</p>
<p>
You can also use <code>break()</code> and <code>continue()</code> in an iterator created by a repeating function. Such an iterator yields elements in the same way as a repeating process that creates a list.
</p>
<p>
An iterator created by a repeat function and a closure generated within a function are similar in that they postpone their actual jobs. They also have similarity in a manner to handle variable environments. Consider the following code.
</p>
<pre><code>f() = {
    n = 0
    while (n &lt; 5):iter {
        n += 1
        n
    }
}
x = f()
</code></pre>
<p>
The function <code>f</code> returns an iterator created by <code>while</code>, which is expected to generate values of 1, 2, 3, 4 and 5. In this case, the repeat body has a reference to a variable named <code>n</code> that belongs to the scope of function <code>f</code>. Can an iterator refer to a variable that may be destroyed at the end of a function?
</p>
<p>
Actually, it's OK. An iterator created by a repeating function owns an environment in which that function has been called. In the above example, the variable <code>n</code> is owned by the returned iterator.
</p>
<p>
You'll see more practical usage of this feature in <a href="../articles/Script-to-Generate-Prime-Numbers.html">this</a>.
</p>
<p>
You can also implement a nested loop in an iterator created by a repeat function.
</p>
<pre><code>x = for (a in ['A', 'B', 'C']):iter {

    // any process

    for (b in [0, 1, 2]):iter {
        a + b
    }
}
// x will generate 'A0', 'A1', 'A2', 'B0', 'B1', 'B2', 'C0', 'C1' and 'C2'
</code></pre>
<p>
A nested loop with an iterator generation must be placed at the last in the repeat procedure.
</p>
<p>
You can also place any iterators in the repeat function that are to be iterated when the outer iterator is evaluated. But, there's one point you have to be careful with. See the following code:
</p>
<pre><code>x = repeat (2):iter {
    range(3)
}
</code></pre>
<p>
It's expected that the iterator <code>x</code> will generate numbers of 0, 1, 2, 0, 1 and 2 after the outer iterator iterates an iterator created by <code>range(3)</code> for twice. But, in reality, it will just generate two iterator instances without iterating them.
</p>
<p>
Iterators created by repeat functions have a "repeater" flag that enable them to be iterated in a nested block. Since other ordinary interators don't have this flag, you have to call <code>iterator#repeater()</code> method to turn it on as shown below.
</p>
<pre><code>x = repeat (2):iter {
    range(3).repeater()
}
</code></pre>
<h3><span class="caption-index-3">9.2.6</span><a name="anchor-9-2-6"></a>Repeat Process with Function that Creates Iterator</h3>
<p>
Many of functions that creates an iterator as their result may take an optional block procedure. For such functions, you can specify a block that is to be evaluated repeatedly while iterating values in the created iterator.
</p>
<p>
For instance, consider a function <code>readlines()</code>, which creates an iterator that reads content of a stream and returns strings of each line. Without a block, it simply returns the created iterator.
</p>
<pre><code>x = readlines('foo.txt')
</code></pre>
<p>
Specifying a block would evaluate the block procedure repeatedly.
</p>
<pre><code>readlines('foo.txt') {
    // any process
}
</code></pre>
<p>
You can get each value from the iterator by specifying a block parameter.
</p>
<pre><code>readlines('foo.txt') {|line|
    print(line)
}
</code></pre>
<p>
A second argument in the block parameter takes an index number of the loop.
</p>
<pre><code>readlines('foo.txt') {|line, i|
    printf('%d: %s', i + 1, line)
}
</code></pre>
<p>
When you specify a block procedure to an iterator creating function, it behaves in the same way as repeating functions such as <code>for()</code> and <code>repeat()</code>. This means that you can use flow control functions <code>break()</code> and <code>continue()</code> in that loop.
</p>
<pre><code>readlines('foo.txt') {|line|
    // any process
    if (line.chop() == '') {
        break
    }
    // any process
}
</code></pre>
<p>
You can also specify attributes <code>:list</code>, <code>:xlist</code>, <code>:set</code> and <code>:xset</code> to indicate it to create a list.
</p>
<pre><code>x = readlines('foo.txt'):list {|line|
    line.upper()
}
// x is a list containing each line's string in uppercase.
</code></pre>
<p>
And attributes <code>:iter</code> and <code>:xiter</code> that create an iterator are also available.
</p>
<pre><code>x = readlines('foo.txt'):iter {|line|
    line.upper()
}
// x is an iterator that generates each line's string in uppercase.
</code></pre>
<h2><span class="caption-index-2">9.3</span><a name="anchor-9-3"></a>Error Handling</h2>
<p>
You can use <code>try-catch</code> sequence to capture errors. Any process that may occur errors is written in a block of <code>try()</code> function and error handling processes are written in blocks of <code>catch()</code> function trailing after that.
</p>
<pre><code>try {
    // any process
} catch (error.ValueError) {
    // handling ValueError
} catch (error.IndexError, error.IOError) {
    // handling IndexError and IOError
} catch {
    // handling of other errors
}
</code></pre>
<p>
A function <code>catch()</code> takes one or more arguments that specify <code>error</code> instances that are to be handled. If no argument is specified, any type of errors are handled in the function.
</p>
<p>
Here are some of the <code>error</code> instances that can be specified for <code>catch()</code> argument.
</p>
<p>
<table>
<tr>
<th>
Error Instance</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>error.ValueError</code></td>
<td>
Invalid argument is specified.</td>
</tr>

<tr>
<td>
<code>error.IndexError</code></td>
<td>
Invalid value for indexing.</td>
</tr>

<tr>
<td>
<code>error.IOError</code></td>
<td>
Error occurs while accessing I/O devices.</td>
</tr>

</table>

</p>
<p>
A block in the <code>catch()</code> function has a block parameter in a format of <code>|err:error|</code> where <code>err</code> takes a value of <code>error</code> type that contains error information such as an error message and a file name and a line position at which the error occurs.
</p>
<p>
<table>
<tr>
<th>
Property</th>
<th>
Data Type</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>error#lineno</code></td>
<td>
<code>number</code></td>
<td>
Line number</td>
</tr>

<tr>
<td>
<code>error#source</code></td>
<td>
<code>string</code></td>
<td>
Source of the code that occurs an error</td>
</tr>

<tr>
<td>
<code>error#text</code></td>
<td>
<code>string</code></td>
<td>
Error message</td>
</tr>

</table>

</p>
<p>
An example code is shown below:
</p>
<pre><code>try {
    // any process
} catch {|err|
    printf('%s at %s:%d\n', err.text, err.source, err.lineno)
}
</code></pre>
<p />

{% endraw %}
