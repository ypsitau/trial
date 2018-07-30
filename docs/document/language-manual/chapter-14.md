---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">14</span><a name="anchor-14"></a>Iterator/List Operation</h1>
<h2><span class="caption-index-2">14.1</span><a name="anchor-14-1"></a>Overview</h2>
<p>
An iterator and a list are quite similar in terms of handling multiple values in a flat structure. In fact, many of their methods share the same names and functions each other.
</p>
<p>
The difference is that a list is a container that actually owns its element values while an iterator only provides a method that retrieves a "next" value of a sequence and doesn't necessarily have to own values. This feature leads to the following principles:
</p>
<ul>
<li>An iterator can handle a sequence of data that continues indefinitely because it doesn't need to keep all the values in it.</li>
<li>An iterator consumes less memory than a list in many cases.</li>
<li>A list provides an indexing method that enables random access for its elements.</li>
<li>A list provides methods to append or remove values.</li>
</ul>
<p>
Note that Gura makes it a rule to implement most functions to return an iterator by default if they have multiple values as its result. Even with such functions, you can easily get a list as their result by calling it with <code>:list</code> attribute.
</p>
<h2><span class="caption-index-2">14.2</span><a name="anchor-14-2"></a>Iteration on Iterators and Lists</h2>
<p>
Consider a task that prints elements in the list shown below:
</p>
<pre><code>words = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten']
</code></pre>
<p>
There are several ways to iterate elements in an iterator or a list.
</p>
<ul>
<li><p>
As you've already seen a previous chapter, iterators and lists can work with functions, methods and operators through Implicit Mapping. You can simply call <code>printf()</code> function with iterators or lists that causes a repetitive evaluation of the function.
</p>
<pre><code>printf('%s\n', words)
</code></pre>
<p>
A function with Implicit Mapping is capable of iterating multiple iterables provided as its arguments. In addition to the list of words, you can specify an iterator that generates numbers starting from zero to print indexing numbers as shown below.
</p>
<pre><code>printf('%d: %s\n', 0.., words)
</code></pre>
</li>
<li><p>
Using <code>for()</code> function, you can iterate a list or an iterator in a way that you may have been familiar with in other languages.
</p>
<pre><code>for (word in words) {
    printf('%s\n', word)
}
</code></pre>
<p>
You can get a loop index starting from zero by specifying a block parameter.
</p>
<pre><code>for (word in words) {|i|
    printf('%d: %s\n', i, word)
}
</code></pre>
</li>
<li><p>
You can also use method <code>iterator#each()</code> or <code>list#each()</code> to iterate elements on them. In this case, the block parameter contains an iterated element as its first value.
</p>
<pre><code>words.each {|word|
    printf('%s\n', word)
}
</code></pre>
<p>
It provides a loop index as the second value in the block parameters as below.
</p>
<pre><code>words.each {|word, i|
    printf('%d: %s\n', i, word)
}
</code></pre>
</li>
</ul>
<p>
Most functions and methods that return an iterator as their result are designed to iterate elements when they take a block. Actually, methods <code>iterator#each()</code> and <code>list#each()</code>, which are mentioned above, simply return an iterator when they're called without a block.
</p>
<pre><code>rtn = words.each()
// rtn is an iterator that iterates each element in words
</code></pre>
<p>
To see other examples that have the same feature, consider methods <code>iterator#filter()</code> and <code>list#filter()</code>, which returns an iterator that pick up elements satisfying a criteria specified in the argument.
</p>
<pre><code>rtn = words.filter(&amp;{$word.startswith('t')})
// rtn is an iterator that generates 'two', 'three' and 'ten'
</code></pre>
<p>
Specifying a block with the method would repetitively evaluate it while iterating elements of the result.
</p>
<pre><code>words.filter(&amp;{$word.startswith('t')}) {|word, i|
    printf('%d: %s\n', i, word)
}
</code></pre>
<p>
The result comes as below:
</p>
<pre><code>0: two
1: three
2: ten
</code></pre>
<h2><span class="caption-index-2">14.3</span><a name="anchor-14-3"></a>Iterator-specific Manipulation</h2>
<h3><span class="caption-index-3">14.3.1</span><a name="anchor-14-3-1"></a>About This Section</h3>
<p>
This section explains about methods and ohter manipulation that are specific to iterators.
</p>
<h3><span class="caption-index-3">14.3.2</span><a name="anchor-14-3-2"></a>Finite Iterator vs. Infinite Iterator</h3>
<p>
Iterators that generate a limited numer of elements are called Finite Iterator. An iterator <code>0..5</code> is a representative one that is definitely expected to generate 6 elements. It's possible that you convert a Finite Iterator into a list.
</p>
<p>
Iterators that generate elements indefinitely or couldn't predict when elements drain out are called Infinite Iterator. Among them, there's an iterator <code>0..</code> that generates numbers starting from 0 and increasing for ever. It would occur an error if you try to convert Infinite Iterator into a list.
</p>
<p>
You can use method <code>iterator#isinfinite()</code> to check if an iterator is an infinite one or not.
</p>
<pre><code>(0..5).isinfinite()  // returns false
(0..).isinfinite()   // returns true
</code></pre>
<p>
Some functions may possibly create either Finite or Infinite Iterator depending on their arguments. The second argument in function <code>rands()</code> specify how many random values it should generate, and, if omitted, the function would generate values without end.
</p>
<pre><code>rands(100)     // returns an Infinite Iterator
rands(100, 80) // returns a Finite Iterator that is expected to generate 80 elements
</code></pre>
<p>
Infinity of the result of function <code>readlines()</code> depends on the attribute of the source stream: it would be an Infinite Iterator if the stream is infinite while it would be a Finite Iterator for a finite stream.
</p>
<p>
An iterator's infinity may be derived from one to another. This happens with iterators that are designed to manipulate values after retrieving them from other source iterator. For example, method <code>iterator#filter()</code> returns an iterator that picks up elements based on the given criteria. In the following code, <code>y</code> is a Finite Iterator that generates numbers 0, 2, 4, 6, 8 and 10.
</p>
<pre><code>tbl = 0..10
rtn = tbl.filter(&amp;{$x % 2 == 0})
// rtn is finite
</code></pre>
<p>
If the source iterator is infinite, the result iterator will be infinite too. In the code below, <code>y</code> is an Infinite Iterator that generates even numbers indefinitely.
</p>
<pre><code>tbl = 0..
rtn = tbl.filter(&amp;{$x % 2 == 0})
// rtn is infinite
</code></pre>
<h3><span class="caption-index-3">14.3.3</span><a name="anchor-14-3-3"></a>Conversion into List</h3>
<p>
Embracing iterators with a pair of square brackets would make a list from them.
</p>
<pre><code>[0..5]               // creates [0, 1, 2, 3, 4, 5]
</code></pre>
<p>
You can specify any numbers of iterators in it as below.
</p>
<pre><code>[0..2, 5..7, 8..10]  // creates [0, 1, 2, 5, 6, 7, 8, 9, 10]
</code></pre>
<p>
It would occur an error if you try to create a list from Infinite Iterators.
</p>
<pre><code>[0..]                // error!
</code></pre>
<p>
Another way to create a list from an iterator is to use <code>iterator#each()</code> method with <code>:list</code> attribute.
</p>
<pre><code>tbl = 0..5
tbl.each():list      // returns [0, 1, 2, 3, 4, 5]
</code></pre>
<h3><span class="caption-index-3">14.3.4</span><a name="anchor-14-3-4"></a>Operation on Elements</h3>
<p>
You can retrieve elements from an iterator by using method <code>iterator#next()</code>.
</p>
<pre><code>tbl = 0..5
tbl.next()   // returns 0
tbl.next()   // returns 1
tbl.next()   // returns 2
</code></pre>
<h2><span class="caption-index-2">14.4</span><a name="anchor-14-4"></a>List-specific Manipulation</h2>
<h3><span class="caption-index-3">14.4.1</span><a name="anchor-14-4-1"></a>About This Section</h3>
<p>
This section explains about methods and ohter manipulation that are specific to lists.
</p>
<h3><span class="caption-index-3">14.4.2</span><a name="anchor-14-4-2"></a>Indexing Read from List</h3>
<p>
You can specify an index number starting from zero embraced by a pair of square brackets to retrieve an element at the specified position. Multiple numbers for indexing can also be specified to get a list of elements.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[2]        // returns 'two'
tbl[4]        // returns 'four'
tbl[1, 3, 5]  // returns ['one', 'three', 'five']
</code></pre>
<p>
You can also specify iterators and lists to get a list of elements. Numbers and iterators can be mixed together as indexing items.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[2..4]        // returns ['two', 'three', 'four']
tbl[1..3, 5..7]  // returns ['one', 'two', 'three', 'five', 'six', 'seven']
</code></pre>
<p>
If you specify an infinite iterator as an indexing item, you would get elements within an available range.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[5..]        // returns ['five', 'six', 'seven']
</code></pre>
<p>
An index with a negative number points the position from the bottom, where <code>-1</code> is the last position.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[-1]         // returns 'seven'
tbl[-2]         // returns 'six'
</code></pre>
<p>
Method <code>list#first()</code> returns the first item in the list and method <code>list#last()</code> the last item. These have the same effect with index accesses by numbers 0 and -1 respectively.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl.first()     // returns 'zero'
tbl.last()      // returns 'seven'
</code></pre>
<p>
You can use method <code>list#get()</code> for index access, which would be useful when used with Member Mapping.
</p>
<pre><code>tbl = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
tbl::get(0)     // returns [1, 4, 7]
</code></pre>
<h3><span class="caption-index-3">14.4.3</span><a name="anchor-14-4-3"></a>Indexing Modification on List</h3>
<p>
An assignment to elements in a list through indexing access is also available.
</p>
<p>
If an indexing item is a single number, the element at the specified position will be modified.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[2] = '2'
tbl[4] = '4'
// tbl is ['zero', 'one', '2', 'three', '4', 'five', 'six', 'seven']
</code></pre>
<p>
Multiple numbers can also be specified for indexing. In this case, if the assigned value is an iterable, each element in the iterable will be stored at the specified positions in the target list.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[1, 3, 5] = ['1', '3', '5']
// tbl is ['zero', '1', 'two', '3', 'four', '5', 'six', 'seven']
</code></pre>
<p>
If the assigned value is a scalar, the same value is stored at the positions.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[1, 3, 5] = '1'
// tbl is ['zero', '1', 'two', '1', 'four', '1', 'six', 'seven']
</code></pre>
<p>
You can also specify an iterator as indexing item.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[1..3, 5..7] = ['1', '2', '3', '5', '6', '7']
// tbl is ['zero', '1', '2', '3', 'four', '5', '6', '7']
</code></pre>
<p>
When you specify an Infinite Iterator for an indexing item, all the elements in the assigned iterable are stored at the specified position.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[5..] = ['5', '6']
// tbl is ['zero', 'one', 'two', 'three', 'four', '5', '6', 'seven']
</code></pre>
<p>
Negative number can also be specified for indexing.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl[-1] = '7'
tbl[-2] = '6'
// tbl is ['zero', 'one', 'two', 'three', 'four', 'five', '6', '7']
</code></pre>
<p>
You can use method <code>list#put()</code> for index modification, which would be useful when used with Member Mapping.
</p>
<pre><code>tbl = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
tbl::put(2, 99)
// tbl is [[1, 2, 99], [4, 5, 99], [7, 8, 99]]
</code></pre>
<h3><span class="caption-index-3">14.4.4</span><a name="anchor-14-4-4"></a>Conversion into Iterator</h3>
<p>
Method <code>list#each()</code> returns an iterator that generates values based on the list's elements.
</p>
<pre><code>tbl = ['one', 'two', 'three', 'four']
rtn = tbl.each()
// rtn is an iterator that generates 'one', 'two', 'three' and 'four'.
</code></pre>
<h3><span class="caption-index-3">14.4.5</span><a name="anchor-14-4-5"></a>Operation on Elements</h3>
<p>
Method <code>list#isempty()</code> will check if a list is empty or not.
</p>
<pre><code>tbl = []
tbl.isempty()    // returns true
</code></pre>
<p>
Both of methods <code>list#add()</code> and <code>list#append()</code> will add values to the target list. They have the same behavior when they try to add a scalar value. Below is a sample of <code>list#add()</code>:
</p>
<pre><code>tbl = ['one', 'two', 'three']
tbl.add('four')
// tbl is ['one', 'two', 'three', 'four']
</code></pre>
<p>
And a sample of <code>list#append()</code> is shown below:
</p>
<pre><code>tbl = ['one', 'two', 'three']
tbl.append('four')
// tbl is ['one', 'two', 'three', 'four']
</code></pre>
<p>
They have different results when they're given with a list as an element to add. Method <code>list#add()</code> adds the list itself to the target list as one of its elements.
</p>
<pre><code>tbl = ['one', 'two', 'three']
tbl.add(['four', 'five', 'six'])
// tbl is ['one', 'two', 'three', ['four', 'five', 'six']]
</code></pre>
<p>
Method <code>list#append()</code> adds each of the list's element to the target list.
</p>
<pre><code>tbl = ['one', 'two', 'three']
tbl.append(['four', 'five', 'six'])
// tbl is ['one', 'two', 'three', 'four', 'five', 'six']
</code></pre>
<p>
Method <code>list#clear()</code> will create all the contet of the target list.
</p>
<pre><code>tbl = ['one', 'two', 'three']
tbl.clear()
// tbl is []
</code></pre>
<p>
Method <code>list#erase()</code> will erase elements at positions specified by its arguments. You can specify multiple indices at which elements are erased.
</p>
<pre><code>tbl = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven']
tbl.erase(2, 4, 6)
// tbl is ['zero', 'one', 'three', 'five', 'seven']
</code></pre>
<p>
Method <code>list#shift()</code> erase the first element before it returns that value.
</p>
<pre><code>tbl = ['one', 'two', 'three']
rtn = tbl.shift()  // returns 'one'
// tbl is ['two', 'three']
</code></pre>
<p>
<code>list#flat()</code>
</p>
<p>
<code>list.zip()</code>
</p>
<h2><span class="caption-index-2">14.5</span><a name="anchor-14-5"></a>Common Manipulation for Iterator and List</h2>
<h3><span class="caption-index-3">14.5.1</span><a name="anchor-14-5-1"></a>About This Section</h3>
<p>
This section explains about methods that are prepared for both iterators and lists. To make descriptions simple, a pseudo class name <code>iterable</code> is used to represent <code>list</code> or <code>iterator</code> class. For example, <code>iterable#len()</code> is an inclusive term for <code>list#len()</code> and <code>iterator#len()</code>.
</p>
<h3><span class="caption-index-3">14.5.2</span><a name="anchor-14-5-2"></a>Inspection and Reduce</h3>
<p>
Method <code>iterable#len()</code> return the number of elements in the iterable.
</p>
<p>
Method <code>iterable#count()</code> takes an optional argument <code>criteria</code> with which elements would be filtered out, and return the number of elements matching it. The method behaves differently depends on a value given to <code>criteria</code>.
</p>
<ul>
<li><p>
If no value is specified for <code>criteria</code>, it would return the number of elements that can be determined as <code>true</code>.
</p>
<pre><code>[true, false, true, true}.count()          // returns 3
</code></pre>
</li>
<li><p>
If it takes a <code>function</code>, which takes one argument and returns a boolean value, it would call the given function with each element's value and count the number of <code>true</code> returned from it.
</p>
<pre><code>[3, 1, 4, 1, 5, 9, 2, 6].count(&amp;{$x &lt; 4}) // returns 4
</code></pre>
</li>
<li><p>
If it takes a value other than <code>function</code>, it would return the number of elements that equals to the given value.
</p>
<pre><code>[3, 1, 4, 1, 5, 9, 2, 6].count(1)         // returns 2
</code></pre>
</li>
</ul>
<p>
Method <code>iterable#contains()</code> checks if the iterable contains the specified value in it.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2, 6]
tbl.contains(1)  // return true
tbl.contains(7)  // return false
</code></pre>
<p>
Methods <code>iterable#and()</code> and <code>iterable#or()</code> calculate logical AND and OR on the iterable's elements repectively. It regards <code>false</code> and <code>nil</code> as a false state, and other values as a true.
</p>
<pre><code>[true, true, true].and()   // returns true
[true, false, true].and()  // returns false
[3, 1, 4, 1, 5].and()      // returns true
[true, false, true].or()   // returns true
[nil, false, nil].or()     // returns false
</code></pre>
<p>
Classes <code>list</code> and <code>iterator</code> are equipped with some statistical operations described below:
</p>
<ul>
<li><code>iterable#sum()</code> calculates summation of elements in the iterable.</li>
<li><code>iterable#average()</code> calculates an average of elements in the iterable.</li>
<li><code>iterable#stddev()</code> calculates a standard deviation value of elements in the iterable.</li>
<li><code>iterable#variance()</code> calculates a variance value of elements in the iterable.</li>
<li><code>iterable#max()</code> and <code>iterable#min()</code> returns maximum and minimum value in the iterable.</li>
</ul>
<p>
Method <code>iterable#join()</code> would join all the strings in the iterable and returns the result. If an element is not a <code>string</code> instance, it would be converted to a string before joined. It takes an optional argument that specifies a string inserted between adjacent elements.
</p>
<pre><code>['abc', 'def', 'ghi'].join()      // returns 'abcdefhij'
['abc', 'def', 'ghi'].join('#')   // returns 'abc#def#hij'
</code></pre>
<p>
Method <code>iterable#reduce()</code> is a generic one to summarize information from elements. It takes a block procedure that is evaluated for each element with block parameters <code>|x, accum|</code>, where <code>x</code> takes each element value and <code>accum</code> the result of the previous evaluation of the block. The initial value of <code>accum</code> is specified by the method's argument. For example, you can use <code>iterable#reduce()</code> to implement a function that works similar with <code>iterable#sum()</code> as below.
</p>
<pre><code>my_sum(iter) = iter.reduce(0) {|x, accum| x + accum }
</code></pre>
<p>
<code>iterable#find()</code>
</p>
<h3><span class="caption-index-3">14.5.3</span><a name="anchor-14-5-3"></a>Mapping Method</h3>
<p>
Method <code>iterable#nilto()</code> returns an iterator that replaces <code>nil</code> existing in the iterable into a specified value. Note that this method doesn't modify the target list.
</p>
<pre><code>rtn = [nil, 1, 2, nil, 3, 4].nilto(99)
// rtn is an iterator that generates 99, 1, 2, 99, 3, 4.
</code></pre>
<p>
Method <code>iterable#replace()</code> returns an iterator that replaces elements matching to its first argument with the value of its second argument. Note that this method doesn't modify the target list.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6].replace(1, 99)
// rtn is an iterator that generates 3, 99, 4, 99, 5, 9, 2, 6.
</code></pre>
<p>
Method <code>iterable#rank()</code> returns an iterator that generates ranked number for each element after sorted. The argument <code>directive</code> specifies sorting rule, which is described in a document of <code>iterable#sort()</code>.
</p>
<pre><code>rtn = ['apple', 'grape', 'orange', 'banana'].rank()
// rtn is an iterator that generates 0, 2, 3, 1
</code></pre>
<p>
Method <code>iterable#map()</code> returns an iterator that applies a function on each element. In general, you can use Implicit Mapping to get the same result with this method.
</p>
<h3><span class="caption-index-3">14.5.4</span><a name="anchor-14-5-4"></a>Element Manipulation</h3>
<p>
This subsection explains about methods that changes the order of elements and extracts elements by a certain condition.
</p>
<p>
Method <code>iterable#align()</code> creates an iterator that picks up the specified number of elements from the iterable.
</p>
<pre><code>rtn = [3, 1. 4, 1, 5, 9].align(3)
// rtn is an iterator that generates 3, 1, 4.
</code></pre>
<p>
If the specified number is more than the length of the source iterable, the rests are filled with <code>nil</code> value.
</p>
<pre><code>rtn = [3, 1. 4, 1, 5, 9].align(10)
// rtn is an iterator that generates 3, 1, 4, 1, 5, 9, nil, nil, nil, nil.
</code></pre>
<p>
Method <code>iterable#fold()</code> creates an iterator that segments the iterable into group of lists containing the specified number of elements.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3].fold(3)
// rtn is an iterator that generates [3, 1, 4], [1, 5, 9], [2, 6, 5], [3].
</code></pre>
<p>
Method <code>iterable#filter()</code> returns an iterator that picks up elements where the given argument <code>criteria</code>, a function or an iterable, is evaluated as <code>true</code>.
</p>
<p>
A function for <code>criteria</code> has a single argument that takes each element value and returns <code>true</code> when it wants the value picked up.
</p>
<pre><code>f(x) = x &lt; 4
tbl = [3, 1, 4, 1, 5, 9, 2]
rtn = tbl.filter(f)
// rtn is an iterator that generates 3, 1, 1, 2.
</code></pre>
<p>
Using an anonymous function would make the code more simple.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2]
rtn = tbl.filter(&amp;{$x &lt; 4})
// rtn is an iterator that generates 3, 1, 1, 2.
</code></pre>
<p>
Method <code>iterable#filter()</code> can also take an iterator or a list of <code>boolean</code> elements as the <code>criteria</code>. Using this feature, you can call the function as below:
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2]
rtn = tbl.filter(tbl &lt; 4)
// rtn is an iterator that generates 3, 1, 1, 2.
</code></pre>
<p>
Implicit Mapping works on the expression <code>tbl &lt; 4</code> that creates a list <code>[true, true, false, true, false, false, true]</code>. Then, the method picks up elements of which corresponding boolean value is <code>true</code>.
</p>
<p>
Method <code>iterable#skipnil()</code> creates an iterator that skips <code>nil</code> value.
</p>
<pre><code>rtn = [3, 1, nil, 4, 1, nil, nil, 5].skipnil()
// rtn is an iterator that generates 3, 1, 4, 1, 5.
</code></pre>
<p>
Method <code>iterable#skip()</code> creates an iterator that skip the specified number between elements.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3].skip(2)
// rtn is an iterator that generates 3, 1, 2, 3.
</code></pre>
<p>
Method <code>iterable#head()</code> creates an iterator that picks up the specified number of elements from the top.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3].head(4)
// rtn is an iterator that generates 3, 1, 4, 1.
</code></pre>
<p>
Method <code>iterable#tail()</code> creates an iterator that picks up the specified number of elements from the bottom.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3].tail(4)
// rtn is an iterator that generates 2, 6, 5, 3.
</code></pre>
<p>
Method <code>iterable#offset()</code> creates an iterator that skip the specified number of elements from the top.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3].offset(5)
// rtn is an iterator that generates 9, 2, 6, 5, 3.
</code></pre>
<p>
Method <code>iterable#pingpong()</code> creates an iterator that seeks elements from the top to the bottom, then from the bottom to the top, and repeats.
</p>
<pre><code>rtn = [1, 2, 3, 4, 5].pingpong()
// rtn is an iterator that generates 1, 2, 3, 4, 5, 4, 3, 2, 1, 2, 3, ...
</code></pre>
<p>
Method <code>iterable#cycle()</code> creates an iterator that repeatedly seeks elements from the top to the bottom.
</p>
<pre><code>rtn = [1, 2, 3, 4, 5].cycle()
// rtn is an iterator that generates 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, ...
</code></pre>
<p>
Method <code>iterable#reverse()</code> creates an iterator that seeks elements from the bottom to the top.
</p>
<pre><code>rtn = [1, 2, 3, 4, 5].reverse()
// rtn is an iterator that generates 5, 4, 3, 2, 1.
</code></pre>
<p>
Method <code>iterable#runlength()</code> examines how many times the same values continue. It creates an iterator that generates a pair containing the number of how many times a value appears and the value itself.
</p>
<pre><code>rtn = ['A', 'A', 'B', 'B', 'B', 'C', 'D', 'D'].runlength()
// rtn is an iterator that generates [2, 'A'], [3, 'B'], [1, 'C'], [2, 'D']
</code></pre>
<p>
Method <code>iterable#sort()</code> sorts iterable's elements in an ascending order.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6].sort()
// rtn is an iterator that generates 1, 1, 2, 3, 4, 5, 6, 9.
</code></pre>
<p>
Specifying a symbol <code>`descend</code> in an argument of the method will sort elements in a descending order.
</p>
<pre><code>rtn = [3, 1, 4, 1, 5, 9, 2, 6].sort(`descend)
// rtn is an iterator that generates 9, 6, 5, 4, 3, 2, 1, 1.
</code></pre>
<p>
Methods <code>iterable#after()</code>, <code>iterable#since()</code>, <code>iterable#before()</code>, <code>iterable#until()</code> and <code>iterable#while()</code> create an iterator that picks up elements within a certain range. They take an argument <code>criteria</code> that prompts where the range begins and ends. The <code>criteria</code> is the same as that of <code>iterable#filter()</code> and may take a function or an iterable.
</p>
<ul>
<li><p>
An iterator by <code>iterable#after()</code> starts extraction of elements right after the <code>criteria</code> is evaluated as <code>true</code>.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2, 6, 5]
rtn = tbl.after(&amp;{$x &gt;= 5})
// rtn is an iterator that generates 9, 2, 6, 5.
</code></pre>
</li>
<li><p>
An iterator by <code>iterable#since()</code> starts extraction of elements at the point where the <code>criteria</code> is evaluated as <code>true</code>.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2, 6, 5]
rtn = tbl.since(&amp;{$x &gt;= 5})
// rtn is an iterator that generates 5, 9, 2, 6, 5.
</code></pre>
</li>
<li><p>
An iterator by <code>iterable#before()</code> carrys on extraction of elements until right before the <code>criteria</code> is evaluated as <code>true</code>.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2, 6, 5]
rtn = tbl.before(&amp;{$x &gt;= 5})
// rtn is an iterator that generates 3, 1, 4, 1.
</code></pre>
</li>
<li><p>
An iterator by <code>iterable#until()</code> carrys on extraction of elements until the point where the <code>criteria</code> is evaluated as <code>true</code>.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2, 6, 5]
rtn = tbl.until(&amp;{$x &gt;= 5})
// rtn is an iterator that generates 3, 1, 4, 1, 5.
</code></pre>
</li>
<li><p>
An iterator by <code>iterable#while()</code> carrys on extraction of elements while the <code>criteria</code> is evaluated as <code>true</code>.
</p>
<pre><code>tbl = [3, 1, 4, 1, 5, 9, 2, 6, 5]

rtn = tbl.while(&amp;{$x &lt; 5})
// rtn is an iterator that generates 3, 1, 4, 1.
</code></pre>
</li>
</ul>
<p>
Method <code>list#combination()</code> creates an iterator that returns a group of all combinations of elements extracted from the target list. It takes an argument that specifies the number of elements to extarct.
</p>
<pre><code>rtn = [1, 2, 3, 4].combination(3)
// rtn is an iterator that generates [1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]
</code></pre>
<p>
Method <code>list#permutation()</code> creates an iterator that returns a group of all permutations of elements extracted from the target list. It takes an argument that specifies the number of elements to extarct.
</p>
<pre><code>rtn = [1, 2, 3].permutation(2)
// rtn is an iterator that generates [1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]
</code></pre>
<p>
If it omits the argument, all the elements would be extracted.
</p>
<pre><code>rtn = [1, 2, 3].permutation()
// rtn is an iterator that generates [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]
</code></pre>
<p>
Method <code>list#shuffle()</code> returns a list in which elements are shuffled in a random order.
</p>
<h2><span class="caption-index-2">14.6</span><a name="anchor-14-6"></a>Iterator Generation</h2>
<p>
Function <code>range()</code> returns an iterator that generates numbers within the specified range.
</p>
<pre><code>range(10)          // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
range(4, 10)       // 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
range(0, 10, 2)    // 0, 2, 4, 6, 8
</code></pre>
<p>
Function <code>interval()</code> returns an iterator that generates the specified number of <code>number</code> values between the prescribed range.
</p>
<pre><code>interval(1, 3, 5)  // 1, 1.5, 2, 2.5, 3
</code></pre>
<p>
Function <code>consts()</code> returns an iterator that generates the specified number of a constant value of any type.
</p>
<pre><code>consts('foo', 3)   // 'foo', 'foo', 'foo'
</code></pre>
<p>
Function <code>rands()</code> returns an iterator that generates random number values.
</p>
<pre><code>rands(100)         // random numbers between 0 and 99
</code></pre>
<p />

{% endraw %}
