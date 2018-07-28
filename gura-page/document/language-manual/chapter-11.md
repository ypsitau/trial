---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">11</span><a name="anchor-11"></a>Mapping Process</h1>
<h2><span class="caption-index-2">11.1</span><a name="anchor-11-1"></a>About This Chapter</h2>
<p>
This chapter explains about Gura's mapping process, Implicit Mapping and Member Mapping. In the documentation, following terms are used to describe species of values.
</p>
<ul>
<li>scalar &mdash; an instance of any type except for <code>list</code> and <code>iterator</code></li>
<li>list &mdash; an instance of <code>list</code></li>
<li>iterator &mdash; an instance of <code>iterator</code></li>
<li>iterable &mdash; list or iterator</li>
</ul>
<h2><span class="caption-index-2">11.2</span><a name="anchor-11-2"></a>Implicit Mapping</h2>
<h3><span class="caption-index-3">11.2.1</span><a name="anchor-11-2-1"></a>Overview</h3>
<p>
<strong>Implicit Mapping</strong> is a feature that evaluates a function or an operator repeatedly when it's given with a list or an iterator.
</p>
<p>
A function that is capable of Implicit Mapping is marked with an attribute <code>:map</code>. Consider a function <code>f(n:number):map</code> that takes a number value and returns a squared number of it. You can call it like <code>f(3)</code>, which is expected to return a number <code>9</code>. Here, using Implicit Mapping, you can call it with a list of numbers like below:
</p>
<pre><code>f([2, 3, 4])
</code></pre>
<p>
This will result in a list <code>[4, 9, 16]</code> after evaluating each number in the list.
</p>
<p>
Implicit Mapping also works with operators. The example below applies an operation that adds three to each value in the list using Implicit Mapping:
</p>
<pre><code>[2, 3, 4] + 3
</code></pre>
<p>
This will result in <code>[5, 6, 7]</code>. Of course, you can also apply Implicit Mapping on an operation between two lists. See the following example:
</p>
<pre><code>[2, 3, 4] + [3, 4, 5]
</code></pre>
<p>
As you might expect, it returns a list <code>[5, 7, 9]</code>.
</p>
<p>
The above example may just look like a vector calculation. Actually, this type of operation, which applies some operations on a set of numbers at once, is known as "vectorization", and has been implemented in languages and libraries that compute vectors and matrices.
</p>
<p>
Implicit Mapping enhances that idea so that it has the following capabilities:
</p>
<ol>
<li><p>
Implicit Mapping can handle any type of objects other than number.
</p>
<p>
Consider a function <code>g(str:string):map</code> that takes a string and returns a result after converting alphabet characters in the string to upper case. When you call it with a single value, it will return one result.
</p>
<pre><code>str = 'hello'
x = g(str)
// x is 'HELLO'
</code></pre>
<p>
You can call it with a list of string to get a list of results by using Implicit Mapping feature.
</p>
<pre><code>strs = ['hello', 'Gura', 'world']
x = g(strs)
// x is ['HELLO', 'GURA', 'WORLD']
</code></pre>
</li>
<li><p>
Implicit Mapping can operate with an iterator as well.
</p>
<p>
Consider the function <code>g(str:string):map</code> that has been mentioned above. If you call it with an iterator, it will return an iterator as its result.
</p>
<pre><code>strs = ('hello', 'Gura', 'world') // creates an iterator
x = g(strs)
// x is an iterator that equivalent with ('HELLO', 'GURA', 'WORLD')
</code></pre>
<p>
It means that the actual evaluation of the function <code>g()</code> will be postponed by the time when the created iterator is evaluated or destroyed. This is important because using an iterator will enable you to avoid unnecessary calculation and memory consumption.
</p>
</li>
<li><p>
You can use Implicit Mapping to repeat a function call without an explicit repeat procedure.
</p>
<p>
A built-in function <code>println():map</code> prints a content of the given value before putting out a line-feed. Consider a case that you need to print each value in the list <code>strs</code> that contains <code>['hello', 'Gura', 'world']</code>. With an ordinary idea, you may use <code>for()</code> to process each item in a list.
</p>
<pre><code>for (str in strs) {
    println(str)
}
</code></pre>
<p>
Using Implicit Mapping, you can simply do it like below:
</p>
<pre><code>println(strs)
</code></pre>
</li>
<li><p>
Implicit Mapping can work on any number of lists and iterators given in an argument list of a function call.
</p>
<p>
Consider that there's a function <code>f(a:string, b:number, c:string):map</code>, and you give it lists as its arguments like below:
</p>
<pre><code>as = ['first', 'second', 'third', 'fourth']
bs = [1, 2, 3, 4]
cs = ['one', 'two', 'three', 'four']
f(as, bs, cs)
</code></pre>
<p>
This has the same effect as below:
</p>
<pre><code>f('first', 1, 'one')
f('second', 2, 'two')
f('third', 3, 'three')
f('fourth', 4, 'four')
</code></pre>
</li>
</ol>
<h3><span class="caption-index-3">11.2.2</span><a name="anchor-11-2-2"></a>Mapping Rule with Operator</h3>
<p>
Implicit Mapping works on most of the operators even though there are several exceptions. In the description below, a symbol <code>o</code> is used to represent a certain operator.
</p>
<p>
With a Prefixed Unary Operator, species of the result is the same as that of the given value. Below is a summary table:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>o scalar</code></td>
<td>
scalar</td>
</tr>
<tr>
<td>
<code>o list</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>o iterator</code></td>
<td>
iterator</td>
</tr>
</table>
<p>
Examples are shown below:
</p>
<table>
<tr>
<th>
Example</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>!true</code></td>
<td>
<code>false</code></td>
</tr>
<tr>
<td>
<code>![true, true, false, true]</code></td>
<td>
<code>[false, false, true, false]</code></td>
</tr>
<tr>
<td>
<code>!(true, true, false, true)</code></td>
<td>
<code>(false, false, true, false)</code></td>
</tr>
</table>
<p>
With a Suffixed Unary Operator, species of the result is the same as that of the given value. Below is a summary table:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>scalar o</code></td>
<td>
scalar</td>
</tr>
<tr>
<td>
<code>list o</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>iterator o</code></td>
<td>
iterator</td>
</tr>
</table>
<p>
With a Binary Operator, the folloiwing rules are applied.
</p>
<ul>
<li>If both of left and right values are of scalar species, the result becomes a scalar.</li>
<li>If either of left or right value is of iterator species, the result becomes an iterator.</li>
<li>Otherwise, the result becomes a list.</li>
</ul>
<p>
Below is a summary table:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>scalar o scalar</code></td>
<td>
scalar</td>
</tr>
<tr>
<td>
<code>scalar o list</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>scalar o iterator</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>list o scalar</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>list o list</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>list o iterator</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>iterator o scalar</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>iterator o list</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>iterator o iterator</code></td>
<td>
iterator</td>
</tr>
</table>
<p>
If both of left and right values are iterable and they have different length, Implicit Mapping would be applied on a range of a shorter length.
</p>
<p>
Some operators expect lists or iterators in their own operations and inhibit Implicit Mapping. See the table below:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Note</th>
</tr>
<tr>
<td>
<code>x?</code></td>
<td>
It deters Implicit Mapping because it needs to check if <code>x</code> itself can be determined as <code>true</code> or not.</td>
</tr>
<tr>
<td>
<code>x*</code></td>
<td>
It expects <code>x</code> may take an iterator or a list.</td>
</tr>
<tr>
<td>
<code>x * y</code> where <code>x</code> is <code>function</code></td>
<td>
It may take a list as a value of <code>y</code>.</td>
</tr>
<tr>
<td>
<code>x % y</code> where <code>x</code> is <code>string</code></td>
<td>
It may take a list as a value of <code>y</code>.</td>
</tr>
<tr>
<td>
<code>x in y</code></td>
<td>
It expects <code>x</code> and <code>y</code> may take list values.</td>
</tr>
<tr>
<td>
<code>x =&gt; y</code></td>
<td>
It expects <code>y</code> may take a list value.</td>
</tr>
</table>
<h3><span class="caption-index-3">11.2.3</span><a name="anchor-11-2-3"></a>Mapping Rule with Function</h3>
<p>
A function with <code>:map</code> attribute in its declaration is capable of Implicit Mapping.
</p>
<p>
Here are function definitions that return a square value of the given number to see the effect of <code>:map</code> attribute.
</p>
<pre><code>f_nomap(x:number) = x * x
f_map(x:number):map = x * x
</code></pre>
<p>
The function delcared with <code>:map</code> attribute is capable of Implicit Mapping and can take a list for an argument that expects a <code>number</code> value.
</p>
<pre><code>f_nomap([1, 2, 3]) // Error
f_map([1, 2, 3])   // Implicit Mapping works on each item and returns [1, 4, 9]
</code></pre>
<p>
As for a function <code>f(x):map</code> that takes one argument, the mapping rule is the same as that of Unary Operator. See the following summary table:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>f(scalar)</code></td>
<td>
scalar</td>
</tr>
<tr>
<td>
<code>f(list)</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>f(iterator)</code></td>
<td>
iterator</td>
</tr>
</table>
<p>
A function <code>f(x, y):map</code> that takes two arguments behaves in the same manner with Binary Operator. Below is a summary table:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>f(scalar, scalar)</code></td>
<td>
scalar</td>
</tr>
<tr>
<td>
<code>f(scalar, list)</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>f(scalar, iterator)</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>f(list, scalar)</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>f(list, list)</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>f(list, iterator)</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>f(iterator, scalar)</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>f(iterator, list)</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>f(iterator, iterator)</code></td>
<td>
iterator</td>
</tr>
</table>
<p>
In general, if a function takes more than one argument, the following rules are appplied.
</p>
<ul>
<li>If all of the argument values are of scalar species, the result becomes a scalar.</li>
<li>If one of the argument values is of iterator species, the result becomes an iterator.</li>
<li>Otherwise, the result becomes a list.</li>
</ul>
<p>
Here are some example cases with a function <code>f(x, y, z):map</code>:
</p>
<table>
<tr>
<th>
Operation</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>f(scalar, scalar, sholar)</code></td>
<td>
scalar</td>
</tr>
<tr>
<td>
<code>f(scalar, scalar, list)</code></td>
<td>
list</td>
</tr>
<tr>
<td>
<code>f(scalar, scalar, iterator)</code></td>
<td>
iterator</td>
</tr>
<tr>
<td>
<code>f(scalar, list, iterator)</code></td>
<td>
iterator</td>
</tr>
</table>
<p>
If an argument list contains iterables that have different length each other, Implicit Mapping would be applied on a range of the shortest length. For example, the code below repeats the process three times.
</p>
<pre><code>f([1, 2, 3], ['a', 'b', 'c', 'd'], [4, 5, 6])
</code></pre>
<p>
Implicit Mapping does not work with arguments that match the following case:
</p>
<ul>
<li><p>
If a function contains an argument that expects <code>list</code> or <code>iterator</code>, Implicit Mapping would not work with that argument. In the following example, putting a list or an iterator to argument <code>z</code>, which expects a list or an iterator as its value, is not considered as a criteria for Implicit Mapping.
</p>
<pre><code>f(x, y, z:list):map     = { /* body */ }
f(x, y, z:iterator):map = { /* body */ }
f(x, y, z[]):map        = { /* body */ }
</code></pre>
</li>
<li><p>
Putting an attribute <code>:nomap</code> to an argument declaration would exclude it from Implicit Mapping criteria. In the example below, specifying a list or an iterator to argument <code>z</code> is not considered as a criteria for Implicit Mapping.
</p>
<pre><code>f(x, y, z:nomap):map = { /* body */ }
</code></pre>
</li>
</ul>
<h3><span class="caption-index-3">11.2.4</span><a name="anchor-11-2-4"></a>Result Control on List</h3>
<p>
Consider a function <code>f(n:number):map</code> that is defined as below:
</p>
<pre><code>f(n:number):map = println('n = ', n)
</code></pre>
<p>
It takes a number value and just prints it.
</p>
<pre><code>f(3)  // prints 'n = 3'
</code></pre>
<p>
Here, function <code>println()</code> is defined with an attribute <code>:void</code> that is meant to always return <code>nil</code> as its result. So, the function <code>f()</code> that evaluates <code>println()</code> at last would return <code>nil</code> as well.
</p>
<p>
As the function <code>f()</code> is capable of Implicit Mapping, you can call it with a list for repeating process.
</p>
<pre><code>f([1, 2, 3])  // prints 'n = 1', 'n = 2' and 'n = 3'
</code></pre>
<p>
As you've already seen above, when a function with <code>:map</code> attribute takes a list, it will evaluate each value in the list immediately and returns a list containing the results. Considering that rule, you may think the calling it as above could return <code>[nil, nil, nil]</code>.
</p>
<p>
But, in reality, it returns a single <code>nil</code>.
</p>
<p>
Implicit Mapping is designed to work as a generic repeating mechanism. If a function is expected to always return some meaningless value such as <code>nil</code>, creating a list that contains such values through a repeating process absolutely makes no sense. To avoid that vain process, Implicit Mapping would only create a list when a valid value appears in the result.
</p>
<p>
Consider a function below that simply returns the given value as its result.
</p>
<pre><code>g(n):map = n
</code></pre>
<p>
The table below summarizes what result you get from <code>g()</code> when it's given with a list containing valid and <code>nil</code> values.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([])</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil])</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil])</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3])</code></td>
<td>
<code>[nil, nil, 3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5])</code></td>
<td>
<code>[nil, nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3])</code></td>
<td>
<code>[nil, nil, 3, 5, 3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil])</code></td>
<td>
<code>[nil, nil, 3, 5, 3, nil]</code></td>
</tr>
</table>
<p>
Note that, when you give an empty list to a function with Implicit Mapping, it would return an empty list as its result.
</p>
<p>
There are some attributes that control how Implicit Mapping generates the result even when it's expected to generate a list by default.
</p>
<ul>
<li><p>
Attribute <code>:list</code> always creates a list even if it only contains <code>nil</code> values.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):list</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil]):list</code></td>
<td>
<code>[nil]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):list</code></td>
<td>
<code>[nil, nil]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):list</code></td>
<td>
<code>[nil, nil, 3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):list</code></td>
<td>
<code>[nil, nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):list</code></td>
<td>
<code>[nil, nil, 3, 5, 3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):list</code></td>
<td>
<code>[nil, nil, 3, 5, 3, nil]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xlist</code> always creates a list after excluding <code>nil</code> value from the result.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):xlist</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil]):xlist</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):xlist</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):xlist</code></td>
<td>
<code>[3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):xlist</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):xlist</code></td>
<td>
<code>[3, 5, 3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):xlist</code></td>
<td>
<code>[3, 5, 3]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:set</code> always creates a list after excluding duplicated values.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):set</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil]):set</code></td>
<td>
<code>[nil]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):set</code></td>
<td>
<code>[nil]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):set</code></td>
<td>
<code>[nil, 3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):set</code></td>
<td>
<code>[nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):set</code></td>
<td>
<code>[nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):set</code></td>
<td>
<code>[nil, 3, 5]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xset</code> always creates a list after excluding <code>nil</code> and duplicated values.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):xset</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil]):xset</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):xset</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):xset</code></td>
<td>
<code>[3]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):xset</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):xset</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):xset</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:iter</code> creates an iterator.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):iter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g([nil]):iter</code></td>
<td>
equivalent of <code>(nil,)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):iter</code></td>
<td>
equivalent of <code>(nil, nil)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):iter</code></td>
<td>
equivalent of <code>(nil, nil, 3)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):iter</code></td>
<td>
equivalent of <code>(nil, nil, 3, 5)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):iter</code></td>
<td>
equivalent of <code>(nil, nil, 3, 5, 3)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):iter</code></td>
<td>
equivalent of <code>(nil, nil, 3, 5, 3, nil)</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xiter</code> creates an iterator that excludes <code>nil</code> value from the result.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):xiter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g([nil]):xiter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):xiter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):xiter</code></td>
<td>
equivalent of <code>(3,)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):xiter</code></td>
<td>
equivalent of <code>(3, 5)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):xiter</code></td>
<td>
equivalent of <code>(3, 5, 3)</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):xiter</code></td>
<td>
equivalent of <code>(3, 5, 3)</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:void</code> indicates the function always returns <code>nil</code> regardless of its original result.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil]):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):void</code></td>
<td>
<code>nil</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:reduce</code> indicates the function returns the last evaluated value and doesn't create a list.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil]):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):reduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):reduce</code></td>
<td>
<code>5</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):reduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xreduce</code> indicates the function returns the last evaluated value and doesn't create a list. The returned value is updated only when the result is valid.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([]):xreduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil]):xreduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil]):xreduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3]):xreduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5]):xreduce</code></td>
<td>
<code>5</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3]):xreduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g([nil, nil, 3, 5, 3, nil]):xreduce</code></td>
<td>
<code>3</code></td>
</tr>
</table>
</li>
</ul>
<h3><span class="caption-index-3">11.2.5</span><a name="anchor-11-2-5"></a>Result Control on Iterator</h3>
<p>
Consider a function below that simply returns the given value as its result.
</p>
<pre><code>g(n):map = n
</code></pre>
<p>
When you give it an iterator, it would return an iterator as well following after Implicit Mapping rule.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each())</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g((nil,))</code></td>
<td>
equivalent of <code>(nil,)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil))</code></td>
<td>
equivalent of <code>(nil, nil)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3))</code></td>
<td>
equivalent of <code>(nil, nil, 3)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5))</code></td>
<td>
equivalent of <code>(nil, nil, 3, 5)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3))</code></td>
<td>
equivalent of <code>(nil, nil, 3, 5, 3)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil))</code></td>
<td>
equivalent of <code>(nil, nil, 3, 5, 3, nil)</code></td>
</tr>
</table>
<p>
There are some attributes that control how Implicit Mapping generates the result even when it's expected to generate an iterator by default.
</p>
<ul>
<li><p>
Attribute <code>:list</code> creates a list.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):list</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil,)):list</code></td>
<td>
<code>[nil]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):list</code></td>
<td>
<code>[nil, nil]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):list</code></td>
<td>
<code>[nil, nil, 3]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):list</code></td>
<td>
<code>[nil, nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):list</code></td>
<td>
<code>[nil, nil, 3, 5, 3]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):list</code></td>
<td>
<code>[nil, nil, 3, 5, 3, nil]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xlist</code> creates a list after excluding <code>nil</code> value from the result.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):xlist</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil,)):xlist</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):xlist</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):xlist</code></td>
<td>
<code>[3]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):xlist</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):xlist</code></td>
<td>
<code>[3, 5, 3]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):xlist</code></td>
<td>
<code>[3, 5, 3]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:set</code> creates a list after excluding duplicated values.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):set</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil,)):set</code></td>
<td>
<code>[nil]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):set</code></td>
<td>
<code>[nil]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):set</code></td>
<td>
<code>[nil, 3]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):set</code></td>
<td>
<code>[nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):set</code></td>
<td>
<code>[nil, 3, 5]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):set</code></td>
<td>
<code>[nil, 3, 5]</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xset</code> creates a list after excluding <code>nil</code> and duplicated values.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):xset</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil,)):xset</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):xset</code></td>
<td>
<code>[]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):xset</code></td>
<td>
<code>[3]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):xset</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):xset</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):xset</code></td>
<td>
<code>[3, 5]</code></td>
</tr>
</table>
</li>
<li>Attribute <code>:iter</code> creates an iterator. This is a default behavior of Implicit Mapping for an iterator.</li>
<li><p>
Attribute <code>:xiter</code> creates an iterator that excludes <code>nil</code> value from the result.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):xiter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g((nil,)):xiter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):xiter</code></td>
<td>
equivalent of <code>[].each()</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):xiter</code></td>
<td>
equivalent of <code>(3,)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):xiter</code></td>
<td>
equivalent of <code>(3, 5)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):xiter</code></td>
<td>
equivalent of <code>(3, 5, 3)</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):xiter</code></td>
<td>
equivalent of <code>(3, 5, 3)</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:void</code> indicates the function will always return <code>nil</code> regardless of its original result.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil,)):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):void</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):void</code></td>
<td>
<code>nil</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:reduce</code> indicates the function returns the last evaluated value and doesn't create an iterator.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil)):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):reduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):reduce</code></td>
<td>
<code>5</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):reduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):reduce</code></td>
<td>
<code>nil</code></td>
</tr>
</table>
</li>
<li><p>
Attribute <code>:xreduce</code> indicates the function returns the last evaluated value and doesn't create an iterator. The returned value is updated only when the result is valid.
</p>
<table>
<tr>
<th>
Script</th>
<th>
Result</th>
</tr>
<tr>
<td>
<code>g([].each()):xreduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil)):xreduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil)):xreduce</code></td>
<td>
<code>nil</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3)):xreduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5)):xreduce</code></td>
<td>
<code>5</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3)):xreduce</code></td>
<td>
<code>3</code></td>
</tr>
<tr>
<td>
<code>g((nil, nil, 3, 5, 3, nil)):xreduce</code></td>
<td>
<code>3</code></td>
</tr>
</table>
</li>
</ul>
<p>
An iterator created by Implicit Mapping has a special feature; it will be evaluated automatically when it's destroyed. Consider the following function:
</p>
<pre><code>f(n:number):map = println('n = ', n)
</code></pre>
<p>
And call it as below:
</p>
<pre><code>f((3, 1, 4))
</code></pre>
<p>
In Implicit Mapping rule, the call above would simply return an iterator and is supposed not do any process unless the iterator is actually evaluated. But usually, the above case is expected to print values in the iterator at the timing of the function call.
</p>
<p>
Actually, the code above works as expected because the returned iterator loses any reference from others and is evaluated before destroyed. The script below shows what happens in the above.
</p>
<pre><code>x = f((3, 1, 4))
x = nil  // iterator is destroyed after printing 'n = 3', 'n = 1' and 'n = 4'.
</code></pre>
<p>
However, the timing to destroy an instance is sometimes unpredictable. It's recommended that you specify <code>:void</code> attribute for an instant evaluation.
</p>
<pre><code>f((3, 1, 4)):void
</code></pre>
<p>
Attributes <code>:void</code>, <code>:reduce</code> and <code>:xreduce</code> don't return an iterator, which cause the actual process on given values done immediately.
</p>
<p>
It may be the best that you specify <code>:void</code>, <code>:reduce</code> or <code>:xreduce</code> attribute in the function definition if you know beforehand that the function always returns <code>nil</code> or other unchanged value.
</p>
<pre><code>f(n:number):map:void = println('n = ', n)
</code></pre>
<p>
Then, you can call the function with an iterator through Implicit Mapping without any worry.
</p>
<pre><code>f((3, 1, 4))
</code></pre>
<h3><span class="caption-index-3">11.2.6</span><a name="anchor-11-2-6"></a>Suspend Implicit Mapping</h3>
<p>
A function call with an attribute <code>:nomap</code> would suspend Implicit Mapping.
</p>
<p>
Consider a case that you need to print a content of <code>x</code> that contains <code>[1, 2, 3, 4]</code> as a list instance. Simply executing <code>println(x)</code> would just print each value in the list through Implicit Mapping. To avoid it, put <code>:nomap</code> for the call as below.
</p>
<pre><code>println(x):nomap
</code></pre>
<h2><span class="caption-index-2">11.3</span><a name="anchor-11-3"></a>Member Mapping</h2>
<h3><span class="caption-index-3">11.3.1</span><a name="anchor-11-3-1"></a>Overview</h3>
<p>
<strong>Member Mapping</strong> is a feature to access members of instances that are stored in a list or are generated from an iterator.
</p>
<p>
There's an instance method <code>string#len()</code> that retrieves a length of a string. With a single instance, you can call it like below:
</p>
<pre><code>x = 'first'
n = x.len()
// n is 5
</code></pre>
<p>
Using a member accessor <code>::</code>, you can apply the method on multiple instances in a list.
</p>
<pre><code>xs = ['first', 'second', 'third', 'fourth']
ns = xs::len()
// ns is [5, 6, 5, 6]
</code></pre>
<p>
A member accessor <code>:*</code> creates an iterator that gets results of member access.
</p>
<pre><code>xs = ['first', 'second', 'third', 'fourth']
ns = xs:*len()
// ns is an iterator that generates (5, 6, 5, 6)
</code></pre>
<h3><span class="caption-index-3">11.3.2</span><a name="anchor-11-3-2"></a>Mapping Rule</h3>
<p>
There are three member accessors in Member Mapping as shown below:
</p>
<table>
<tr>
<th>
Member Accessor</th>
<th>
Name</th>
</tr>
<tr>
<td>
<code>::</code></td>
<td>
map-to-list</td>
</tr>
<tr>
<td>
<code>:*</code></td>
<td>
map-to-iterator</td>
</tr>
<tr>
<td>
<code>:&amp;</code></td>
<td>
map-along</td>
</tr>
</table>
<p>
A map-to-list accessor <code>::</code> applies a member method or looks up a member variable on instances in an iterable, a list or an iterator, and creates a list of the results. Below shows examples:
</p>
<pre><code>xs::variable
xs::func()
</code></pre>
<p>
A map-to-iterator accessor <code>:*</code> creates an iterator that applies a member method or looks up a member variable on instances in an iterable, a list or an iterator. Below shows examples:
</p>
<pre><code>xs:*variable
xs:*func()
</code></pre>
<p>
A map-along accessor <code>:&amp;</code> only has effect with a member method. It iterates the iterable on the left along with iterables in its argument list following after Iterator Mapping rule. See the following example:
</p>
<pre><code>xs = [x1, x2, x3]
as = ['first', 'second', 'third']
bs = [3, 1, 4]
xs:&amp;func(as, bs)
</code></pre>
<p>
This has the same effect with shown below:
</p>
<pre><code>[x1.func('first', 3), x2.func('second', 1), x3.func('third', 4)]
</code></pre>
<p>
The mapping rule with map-along accessor is summarized below:
</p>
<ul>
<li>If the target iterable or one of the argument values is of iterator species, the result becomes an iterator.</li>
<li>Otherwise, the result becomes a list.</li>
</ul>
<p />

{% endraw %}
