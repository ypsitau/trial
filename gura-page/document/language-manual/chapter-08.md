---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">8</span><a name="anchor-8"></a>Function</h1>
<h2><span class="caption-index-2">8.1</span><a name="anchor-8-1"></a>Definition and Evaluation</h2>
<p>
The figure below shows an example of function definition with each part's designation.
</p>
<pre><code>    +-- declaration
    |
----------
f(x, y, z) = printf('x = %s, y = %s, z = %s\n', x, y, z)
- -------    -------------------------------------------
|   |                            |
|   +-- argument list            +-- body
+-- identifier
</code></pre>
<p>
It composes of a declaration and a body with an assignment operator, and the declaration is made up with an identifier and an argument list.
</p>
<p>
The body must be a single expression. If you want to describe more than one expression, you have to use a Block expression embracing them like following.
</p>
<pre><code>f(x, y, z) = {
    printf('x = %s, y = %s, z = %s\n', x, y, z)
}
</code></pre>
<p>
After defining a function, a <code>function</code> instance is assigned in the scope environment with the identifier. If the same identifier already exists in the environment, the existing one is overwritten no matter whether it's a <code>function</code> instance or other.
</p>
<p>
You can see a function's declaration by simply printing the instance like following.
</p>
<pre><code>println(f)
</code></pre>
<p>
The argument list is a list of Identifier expressions. If no argument is necessary, specify an empty list.
</p>
<pre><code>g() = { /* body */ }
</code></pre>
<p>
You can evaluate a <code>function</code> instance by passing it values as its arguments. The number of passed values must be the same as that of declared arguments.
</p>
<pre><code>f(1, 2, 3)    // OK
f(1, 2, 3, 4) // Error; too many arguments
f(1, 2)       // Error; insufficient arguments
</code></pre>
<p>
If the Caller doesn't pass any argument for evaluation, specify an empty list.
</p>
<pre><code>g()
</code></pre>
<h2><span class="caption-index-2">8.2</span><a name="anchor-8-2"></a>Returned Value</h2>
<p>
An evaluation result of the last expression in a function body becomes its returned value.
</p>
<p>
The function below returns a string <code>'hello'</code> as its result:
</p>
<pre><code>f() = {
    // any process
    'hello'
}
</code></pre>
<p>
The function below returns a returned value of <code>g()</code> as its result:
</p>
<pre><code>f() = {
    // any process
    g()
}
</code></pre>
<p>
A function can return any types of value including <code>list</code>. This feature enables a function to return more than one value.
</p>
<pre><code>f() = {
    // any process
    [3, 4, 5]
}

[a, b, c] = f()  // a = 3, b = 4, c = 5
</code></pre>
<p>
You can also use a function <code>return()</code> to explicitly specify the returned value even though its use is not recommended unless you need to quit a process in the middle.
</p>
<pre><code>f() = {
    // any process
    return('hello')
}
</code></pre>
<p>
An attribute <code>:void</code> indicates that the function always return <code>nil</code> no matter what value is resulted at last in the process. A call for a function below returns <code>nil</code>, not a string <code>'hello'</code>.
</p>
<pre><code>f():void = {
    'hello'
}
</code></pre>
<p>
You should put <code>:reduce</code> attribute if the function is supposed to return a unchanged value. Attributes <code>:void</code> and <code>:reduce</code> have a significant effect with Implicit Mapping.
</p>
<h2><span class="caption-index-2">8.3</span><a name="anchor-8-3"></a>Arguments</h2>
<h3><span class="caption-index-3">8.3.1</span><a name="anchor-8-3-1"></a>Type Name Declaration</h3>
<p>
You can specify a type name by describing it as an attribute after an Identifier's symbol.
</p>
<pre><code>f(x:number) = {
    // any process
}
</code></pre>
<p>
When calling a function that has arguments with type name, the Interpreter first check the data type of the given value and try to cast it into specified data type if possible. If the type doesn't match and also fails to be casted correctly, it would occur an error.
</p>
<p>
If you expect an argument to take a list, specify a pair of square brackets that has no content after an Identifer's symbol.
</p>
<pre><code>f(x[]) = {
    // any process
}
</code></pre>
<p>
A type name can be described after the bracket pair.
</p>
<pre><code>f(x[]:number) = {
    // any process
}
</code></pre>
<p>
In this case, the interpreter checks types of all the items in the list and applies casting on them if possible.
</p>
<p>
You can also specify how many elements the list should contain by declaring the number in the square brackets.
</p>
<pre><code>f(x[8]) = {
    // any process
}
</code></pre>
<p>
In the example above, only a list that contains eight elements could be accepted and an error would occur otherwise.
</p>
<h3><span class="caption-index-3">8.3.2</span><a name="anchor-8-3-2"></a>Data Type Casting</h3>
<p>
If the data type of a value given as an argument doesn't match with that that is specified in an argument list, the value will be casted to the expected data type if possible.
</p>
<p>
For instance, a value of <code>string</code> type can be casted to <code>number</code> if the string contains a valid text of number.
</p>
<pre><code>f(n:number) = {
    // any process
}
f('100')  // string will be casted to number
</code></pre>
<p>
Casting feature can also be applied to other data types. Consider the following function:
</p>
<pre><code>f(in:stream) = {
    // process to read data from in
}
</code></pre>
<p>
Since it expects to take a <code>stream</code> instance as its argument, you can call it with the instance created by <code>open()</code> function like below.
</p>
<pre><code>f(open('foo.txt'))
</code></pre>
<p>
Now, you can also call it much easily using a casting feature that converts from <code>string</code> to <code>stream</code>.
</p>
<pre><code>f('foo.txt')
</code></pre>
<p>
If a <code>string</code> value is passed to an argument that expects a <code>stream</code> value, the Interpreter opens a stream with a path name specified by the string and creates a <code>stream</code> instance for it.
</p>
<p>
In default, casting opens a stream with reading mode. You need to append <code>:w</code> attribute in a function declaration to get a stream with writing mode.
</p>
<pre><code>g(out:stream:w) = {
    // process to write data to out
}
</code></pre>
<p>
An attribute <code>:r</code> is also prepared to explicitly indicate the stream is to be opened for reading.
</p>
<pre><code>f(in:stream:r) = {
    // process to read data from in
}
</code></pre>
<p>
Let's see another case of casting. Consider a function that takes a value of <code>image</code> type, which also has a casting ability from <code>stream</code> data type.
</p>
<pre><code>f(img:image) = {
    // process on img
}
</code></pre>
<p>
A function <code>image()</code> takes a value of <code>stream</code> data type and creates an <code>image</code> instance. With the most explicit way, the function above can be called as below.
</p>
<pre><code>f(image(open('foo.jpg')))
</code></pre>
<p>
An <code>image</code> data type can be casted from a value of <code>stream</code> type.
</p>
<pre><code>f(open('foo.jpg'))
</code></pre>
<p>
Using a feature to convert <code>string</code> to <code>stream</code>, it will be rewritten like following.
</p>
<pre><code>f('foo.jpg')
</code></pre>
<p>
This means that, if a function expects <code>image</code> data type, you can call it with a value of either <code>image</code>, <code>stream</code> or <code>string</code> data type.
</p>
<p>
You can find information about what data type can be casted from which data type in <strong>Gura Library Reference</strong>.
</p>
<h3><span class="caption-index-3">8.3.3</span><a name="anchor-8-3-3"></a>Optional Argument</h3>
<p>
You can declare an optional argument by putting <code>?</code> right after an Identifier's symbol.
</p>
<pre><code>f(x?) = { /* body */ }
</code></pre>
<p>
If you want to declare a type name for an optional argument, specify it like following.
</p>
<pre><code>f(x?:number) = { /* body */ }
</code></pre>
<p>
For such a function, you can call it like following.
</p>
<pre><code>f(3)
f()
</code></pre>
<p>
If the Caller omits a value for an optional argument, a variable for the argument would be in undefined state. You can use <code>isdefined()</code> function to check if the variable is defined or not.
</p>
<pre><code>f(x?) = {
    if (isdefined(x)) {
        // when x is specified
    } else {
        // when x is omitted
    }
}
</code></pre>
<p>
You can specify more than one optional argument. Note that it's inhibited to declare any non-optional arguments following after optional one.
</p>
<pre><code>f(x?, y?, z?) = { /* body */ }  // OK
f(x, y?, z?)  = { /* body */ }  // OK
f(x?, y?, z)  = { /* body */ }  // Error
</code></pre>
<h3><span class="caption-index-3">8.3.4</span><a name="anchor-8-3-4"></a>Argument with Default Value</h3>
<p>
An argument with a default value can be declared with an operator <code>=&gt;</code>.
</p>
<pre><code>f(x =&gt; -1) = { /* body */ }
</code></pre>
<p>
If you want to declare a type name for an argument with a default value, specify it like following.
</p>
<pre><code>f(x:number =&gt; -1) = { /* body */ }
</code></pre>
<p>
For such a function, you can call it like following.
</p>
<pre><code>f(3)
f()
</code></pre>
<p>
If the Caller omits a value for an argument with a default value, a variable for the argument would be set to the specified default value.
</p>
<p>
You can specify more than one arguments with default value. Note that any arguments that don't have a default value can not follow after one with a default value.
</p>
<pre><code>f(x =&gt; 1, y =&gt; 2, z =&gt; 3) = { /* body */ }  // OK
f(x, y =&gt; 2, z =&gt; 3)      = { /* body */ }  // OK
f(x =&gt; 1, y =&gt; 2, z)      = { /* body */ }  // Error
</code></pre>
<p>
Optional arguments and arguments with default value follow the same positioning rule each other in an argument list.
</p>
<pre><code>f(x =&gt; 1, y =&gt; 2, z?) = { /* body */ }  // OK
</code></pre>
<h3><span class="caption-index-3">8.3.5</span><a name="anchor-8-3-5"></a>Variable-length Argument</h3>
<p>
You can declare a variable-length argument by putting <code>+</code> or <code>*</code> right after an Identifier's symbol.
</p>
<pre><code>f(x+) = { /* body */ }
g(x*) = { /* body */ }
</code></pre>
<p>
For the first one, the Caller can call it with <strong>one</strong> or more values. If it doesn't specify any value for the argument, it would occur an error.
</p>
<pre><code>f(1)           // OK
f(1, 2, 3, 4)  // OK
f()            // Error
</code></pre>
<p>
For the second one, the Caller can call it with <strong>zero</strong> or more values. It can even call it without any argument.
</p>
<pre><code>g(1)           // OK
g(1, 2, 3, 4)  // OK
g()            // OK
</code></pre>
<p>
If you want to declare a type name for a variable-length argument, specify it like following.
</p>
<pre><code>f(x+:number) = { /* body */ }
</code></pre>
<p>
The variable-length argument can only be declared once and must be placed at the last.
</p>
<pre><code>f(x, y, z+)  = { /* body */ }  // OK
f(x, y+, z+) = { /* body */ }  // Error
f(x, y+, z)  = { /* body */ }  // Error
</code></pre>
<p>
In the function body, a variable of variable-length argument takes a list of values.
</p>
<pre><code>f(x*) = {
    println('number of arguments: ', x.len())
    for (item in x) {
        sum += item
    }
}
</code></pre>
<p>
If there are other arguments before a variable-length one, variables of those arguments are assigned in order before the rests are stored in a variable-length argument. For instance, consider the code below:
</p>
<pre><code>f(x, y, z+) = { /* body */ }
f(1, 2, 3, 4, 5)
</code></pre>
<p>
In function <code>f</code>, variables <code>x</code>, <code>y</code> and <code>z</code> are set to <code>1</code>, <code>2</code> and <code>[3, 4, 5]</code> respectively.
</p>
<h3><span class="caption-index-3">8.3.6</span><a name="anchor-8-3-6"></a>Named Argument</h3>
<p>
Consider the following function:
</p>
<pre><code>f(x, y, z) = { /* body */ }
</code></pre>
<p>
To evaluate it, you can explicitly specify variable names in the argument list like below:
</p>
<pre><code>f(x =&gt; 1, y =&gt; 2, z =&gt; 3)
</code></pre>
<p>
Such arguments are called named arguments, which are useful when you want to specify only relevant one among many optional arguments.
</p>
<p>
If a function declaration contains an argument suffixed by <code>%</code>, it can take a all the values of named arguments that are not assigned to other arguments.
</p>
<p>
Consider the following function:
</p>
<pre><code>f(a, b, x%) = { /* body */ }
</code></pre>
<p>
When you evaluate it like below:
</p>
<pre><code>f(a =&gt; 1, b =&gt; 2, c =&gt; 3, d =&gt; 4)
</code></pre>
<p>
Then, variables <code>a</code>, <code>b</code> and <code>x</code> are set to <code>1</code>, <code>2</code> and <code>%{c =&gt; 3, d =&gt; 4}</code>.
</p>
<h3><span class="caption-index-3">8.3.7</span><a name="anchor-8-3-7"></a>Argument Expansion</h3>
<pre><code>f(x*)

f(1, 2, 3, 4)


f(x%)
</code></pre>
<h3><span class="caption-index-3">8.3.8</span><a name="anchor-8-3-8"></a>Quoted Argument</h3>
<p>
Sometimes, there's a need to pass a function a procedure, not an evaluated result. For such a purpose, you can use a Quote operator that creates <code>expr</code> instance from any code,
</p>
<p>
See an exmple below:
</p>
<pre><code>f(x:expr) = {
    x.eval()
}

x = `println('hello')
f(x)
</code></pre>
<p>
The variable <code>x</code> that holds an <code>expr</code> instance contaning expression of <code>println('hello')</code> will be passed to function <code>f</code> as its argument, which then actually evaluates it.
</p>
<p>
Of course, you can also specify the quoted value directly in the argument.
</p>
<pre><code>f(`println('hello'))
</code></pre>
<p>
There's another way to pass an expression in a function call, and that is to put a Quoted operator in an argument list of a function definition like below.
</p>
<pre><code>g(`x) = {
    x.eval()
}
</code></pre>
<p>
For such a function, the Caller doesn't have to put a Quote operator for the expression that you want to pass.
</p>
<pre><code>g(println('hello'))
</code></pre>
<h2><span class="caption-index-2">8.4</span><a name="anchor-8-4"></a>Block</h2>
<p>
A block can be seen as a special form of an argument. It appears after an argument list and contains a procedure embraced by a pair of curly braces.
</p>
<p>
A function definition with a block comes like below:
</p>
<pre><code>f() {block} = { /* body */ }
</code></pre>
<p>
And you can call the function like folowing:
</p>
<pre><code>f() { /* block procedure */ }
</code></pre>
<p>
The function <code>f</code> takes a function instance of a block procedure with a variable named <code>block</code>, and it can call the procedure just like an ordinary function.
</p>
<p>
Consider the following function:
</p>
<pre><code>three_times() {block} = {
    block()
    block()
    block()
}
</code></pre>
<p>
Then, you can call it like following:
</p>
<pre><code>three_times() {
    println('hello world')
}
</code></pre>
<p>
This results in three print-outs of <code>'hello world'</code>.
</p>
<p>
As for a function that is declared to take a mandatory block, a call without specifying a block procedure would occur an error.
</p>
<pre><code>three_times()  // Error because of lacking block
</code></pre>
<p>
The block procedure can have a list of block parameters that appears right after the opening curly brace and is embraced by a pair of vertical bars.
</p>
<pre><code>f() {|/* block parameters */| /* block procedure */ }
</code></pre>
<p>
A declaration of block parameters is almost the same with that of function arguments. In fact, a function created from a block procedure has an argument list that are specified as block parameters.
</p>
<p>
Consider the following function:
</p>
<pre><code>three_times() {block} = {
    block(0, 'zero')
    block(1, 'one')
    block(2, 'two')
}
</code></pre>
<p>
The function provides two block parameters, values of <code>number</code> and <code>string</code> type.
</p>
<p>
The function can be called like below:
</p>
<pre><code>three_times() {|idx, str|
    println(idx, ' ', str)
}
</code></pre>
<p>
The caller can also specify a value type for each block parameter just like function's arguments.
</p>
<pre><code>three_times() {|idx:number, str:string|
    println(idx, ' ', str)
}
</code></pre>
<p>
The caller doesn't have to declare all the block parameters that are provided by the function if it doesn't require them. In the case of calling the above function, declaraing only one block parameter like below is permitted:
</p>
<pre><code>three_times() {|idx|
    println(idx)
}
</code></pre>
<p>
And having no block parameter like below is also allowed:
</p>
<pre><code>three_times() {
    println('hello')
}
</code></pre>
<p>
You can specify an optional block by putting <code>?</code> after an identifier for the block procedure.
</p>
<pre><code>f() {block?} = { /* body */ }
</code></pre>
<p>
You can call such a function either with or without a block.
</p>
<pre><code>f() {}  // OK
f()     // OK
</code></pre>
<p>
If a block is not specified, the variable <code>block</code> takes <code>nil</code> value.
</p>
<pre><code>f() {block?} = {
    if (block) {
        // block is specified
    } else {
        // block is not specified
    }
}
</code></pre>
<p>
If an Identifer for the block procedure is prefixed by Quote operator, the variable takes the procedure as an <code>expr</code> instance, not an <code>function</code> one.
</p>
<pre><code>f() {`block} = { /* body */ }
</code></pre>
<p>
You need to use <code>expr#eval()</code> method to evaluate the block.
</p>
<pre><code>f() {`block} = {
    block.eval()
}
</code></pre>
<p>
This feature is useful when you need to delegate a block to other function. If a Caller specifies a block that only has a block parameter containing a value of <code>expr</code> type, that value would be passed as a block procedure.
</p>
<p>
See a sample code below:
</p>
<pre><code>repeat_delegate(n) {`block} = {
    println('begin')
    repeat(n) {|block|}
    println('end')
}
</code></pre>
<p>
Function <code>repeat_delegate()</code> takes a block procedure in <code>expr</code> type, which is passed to <code>repeat()</code> function in a delegation manner.
</p>
<p>
In general, a function call must be accompanied with an argument list even if it's empty. Though, if the call doesn't have any argument but has a block procedure, you can omit the list like below.
</p>
<pre><code>f { /* body */ }
</code></pre>
<h2><span class="caption-index-2">8.5</span><a name="anchor-8-5"></a>Attribute</h2>
<h3><span class="caption-index-3">8.5.1</span><a name="anchor-8-5-1"></a>User-defined Attribute</h3>
<p>
An attribute works as another way to pass information to a function. In a function definition, acceptable attributes are listed within a pair of square brackets that follow after an argument list and a colon character.
</p>
<pre><code>f():[attr1,attr2,attr3] = { /* body */ }
</code></pre>
<p>
You can call such a function like below. You can specify any number of attributes in any order.
</p>
<pre><code>f():attr1
f():attr2
f():attr1:attr3
</code></pre>
<p>
In a function body, a variable named <code>__args__</code> of <code>args</code> type is defined, and you can use <code>args#isset()</code> method to check if an attribute is set.
</p>
<pre><code>f():[foo,bar] = {
    if (__args__.isset(`foo)) {
        // :foo is specified
    }
    if (__args__.isset(`bar)) {
        // :bar is specified
    }
}
</code></pre>
<h3><span class="caption-index-3">8.5.2</span><a name="anchor-8-5-2"></a>Predefined Attributes</h3>
<p>
<table>
<tr>
<th>
Attribute</th>
<th>
Note</th>
</tr>

<tr>
<td>
<code>:map</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:nomap</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:flat</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:noflat</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:list</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:xlist</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:iter</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:xiter</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:set</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:xset</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:void</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:reduce</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:xreduce</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:static</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:dynamic_scope</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:symbol_func</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:leader</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:trailer</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:finalizer</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:end_marker</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:public</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:private</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:nonamed</code></td>
<td>
</td>
</tr>

<tr>
<td>
<code>:closure</code></td>
<td>
</td>
</tr>

</table>

</p>
<h2><span class="caption-index-2">8.6</span><a name="anchor-8-6"></a>Help Block</h2>
<p>
You can add a help block to a function by appending <code>%%</code> and a block containing help information to a function declaration.
</p>
<pre><code>add(x, y) = {
    x + y
} %% {
    `en, 'Takes two numbers and returns an added result.'
}
</code></pre>
<p>
The content in the block has a format of <code>{lang:symbol, help:string}</code> which contains following elements:
</p>
<ul>
<li><code>lang</code> .. Specifies a symbol of language that describes the help document: <code>en</code> for English and <code>ja</code> for Japanese, etc.</li>
<li><code>help</code> .. Help string written in Markdown format.</li>
</ul>
<p>
You can access the help information by following ways:
</p>
<ul>
<li>In the interactive mode, evaluating the operator <code>~</code> with a function instance would print its help information on the console.</li>
<li>Calling function <code>help@function()</code> would return a <code>help</code> instance that provides information about the used language, syntax format and help string.</li>
</ul>
<p>
A function may have multiple help blocks that contain explanatory texts written in different languages. Below is a function example that has helps written in English and Japanese:
</p>
<pre><code>add(x, y) = {
    x + y
} %% {`en, R'''

    ---- help document in English ----

'''
} %% {`ja, R'''

    ---- help document in Japanese ----

'''
} %% {`de, R'''

    ---- help document in German ----

'''
}
</code></pre>
<p>
A predefined variable <code>sys.langcode</code> determines which help should be printed by default. If a function doesn't have a help in the specified language, what appears at first in the declaration will be used.
</p>
<p>
You can also pass a language symbol to <code>help@function</code> function as below.
</p>
<pre><code>help@function(add, `en)
help@function(add, `ja)
help@function(add, `de)
</code></pre>
<h2><span class="caption-index-2">8.7</span><a name="anchor-8-7"></a>Anonymous Function</h2>
<p>
A function <code>function()</code> creates an anonymous function instance from an argument list and a block that contains its function body.
</p>
<pre><code>function(x, y, z) { /* body */ }
</code></pre>
<p>
When the function instance is assigned to a variable, that symbol is bound to the instance. The following two codes are equivalent each other.
</p>
<pre><code>f = function(x, y, z) { /* body */ }
f(x, y, z) = { /* body */ }
</code></pre>
<p>
If you create a function that doesn't have arguments, you can call <code>function()</code> without an argument list like below.
</p>
<pre><code>function { /* body */ }
</code></pre>
<p>
When <code>function()</code> creates a function instance, it seeks variable symbols in the function body that start with <code>$</code> character, which are used as argument variables. For instance, see the following code:
</p>
<pre><code>function { printf('x = %s, y = %s, z = %s\n', $x, $y, $z) }
</code></pre>
<p>
In this case, the order of arguments is the same with the order in which the variables appear in the body. So, the example above is equivalent with the function that is created like below:
</p>
<pre><code>function($x, $y, $z) { printf('x = %s, y = %s, z = %s\n', $x, $y, $z) }
</code></pre>
<p>
Since a special symbol <code>&amp;</code> is also bound to the <code>function()</code> function, you can create a function instance as below:
</p>
<pre><code>&amp;{ /* body */ }
</code></pre>
<p>
The example above can be written like this:
</p>
<pre><code>&amp;{ printf('x = %s, y = %s, z = %s\n', $x, $y, $z) }
</code></pre>
<p>
Exlicit arguments may be specified as block parameters. The following example creates a function that takes arguments named <code>x</code>, <code>y</code> and <code>z</code>.
</p>
<pre><code>&amp;{|x, y, z| /* body */ }
</code></pre>
<p>
Of course, like an argument list in an ordinary function declartion, you can declare them with value types.
</p>
<pre><code>&amp;{|x:number, y:string, z:string| /* body */ }
</code></pre>
<h2><span class="caption-index-2">8.8</span><a name="anchor-8-8"></a>Closure</h2>
<p>
You can define a function inside another function body. In that case, the inner function can access variables in the outer function.
</p>
<pre><code>f() = {
    x = 3
    g() = {
        println('x = ', x)
    }
    g()  // evaluate the function
}
</code></pre>
<p>
A function can also return a <code>function</code> instance that it creates as its result. The environment of the outer function will be held in the inner function.
</p>
<pre><code>f():closure = {
    x = 3
    g() = {
        println('x = ', x)
    }
    g
}

h = f()
h()
</code></pre>
<p>
Make sure that a function that returns a <code>function</code> instance must be declared with <code>:closure</code> attribute.
</p>
<h2><span class="caption-index-2">8.9</span><a name="anchor-8-9"></a>Leader-trailer Relationship</h2>
<p>
When a Caller expression is described at the same line with the end of a preceding one, they have a leader-trailer relationship with the preceding one as a leader and the following one as a trailer.
</p>
<pre><code>f() g()
--- ---
 |   |
 |   +-- trailer
 +-- leader
</code></pre>
<p>
In an ordinary case, these functions are evaluated sequentially in the same way that they're described in different lines.
</p>
<p>
The leader function has a right to control whether the trailer one should be evaluated or not. A method <code>args#quit_trailer()</code> will quit its trailer from being evaluated. Take a look at the following simple function to see how a trailer is controlled.
</p>
<pre><code>do_trailer(flag:boolean) = {
    if (!flag) {
        __args__.quit_trailer()
    }
}
</code></pre>
<p>
Then the following code will print <code>hello</code> but no <code>good-bye</code>.
</p>
<pre><code>do_trailer(true) println('hello')
do_trailer(false) println('good-bye')
</code></pre>
<p>
Some functions that govern sequence flow like <code>if-elsif-else</code> and <code>try-catch</code> utilizes this trailer control mechanism.
</p>
<p />

{% endraw %}
