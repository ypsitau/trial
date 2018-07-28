---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">10</span><a name="anchor-10"></a>Object Oriented Programming</h1>
<h2><span class="caption-index-2">10.1</span><a name="anchor-10-1"></a>Class and Instance</h2>
<p>
A <strong>class</strong> is a kind of environment that contains properties such as functions and variables, and has an ability to create <strong>instances</strong> that share these properties. A class is associated with a data type one by one, which means that all the values in a script are bound to certain classes. For example, a value <code>3.14</code> is associated with <code>number</code> class, and <code>'hello world'</code> with <code>string</code> class.
</p>
<p>
A class contains functions called <strong>method</strong> that operate with a class or an instance. A method that belongs to a class is called <strong>class method</strong> and is described as below, where <code>Foo</code> and <code>func</code> are names of the class and the class method respectively.
</p>
<pre><code>Foo.func()
</code></pre>
<p>
A method that works on an instance is called <strong>instance method</strong> and is described as below, where <code>Foo</code> and <code>func</code> are names of the class and the instance method respectively.
</p>
<pre><code>Foo#func()
</code></pre>
<p>
The symbol <code>#</code> is not used for an actual instance operation and only appears in documentation to describe instance methods. You can call an instance method like below, where <code>foo</code> is an instance of class <code>Foo</code>.
</p>
<pre><code>foo.func()
</code></pre>
<p>
A class also owns variables called  <strong>class variable</strong>, which are shared by instances from the class. Each instance can contain its own variables that are called <strong>instance variable</strong>.
</p>
<p>
A class variable is described as below, where <code>Foo</code> and <code>value</code> are names of the class the class variable respectively:
</p>
<pre><code>Foo.value
</code></pre>
<p>
An instance variable is described as below, where <code>Foo</code> and <code>value</code> are names of the class the instance variable respectively:
</p>
<pre><code>Foo#value
</code></pre>
<p>
You can use <code>dir()</code> function to see what methods and variables are available with a value.
</p>
<pre><code>&gt;&gt;&gt; x = 3.14
3.14
&gt;&gt;&gt; dir(x)
[`__call__, `__iter__, `clone, `getprop!, `is, `isinstance, `isnil, `istype, `nomap, `roundoff, `setprop!, `tonumber, `tostring]
</code></pre>
<h2><span class="caption-index-2">10.2</span><a name="anchor-10-2"></a>User-defined Class</h2>
<p>
You can use <code>class</code> function to create a user-defined class. The code below creates a class named <code>A</code> with empty properties.
</p>
<pre><code>A = class {}
</code></pre>
<p>
This assignment would create a class named <code>A</code> and also define a constructor function <code>A()</code> that generates an instance of the class. You can call the constructor function like below:
</p>
<pre><code>a = A()
</code></pre>
<p>
A block of the <code>class</code> function should contain Assign and Caller expressions. Existance of other expressions would cause an error. They're evaluated just one time when the class is created. Actual jobs in these expressions are summarized below:
</p>
<ul>
<li><p>
<strong>Assign expression</strong>
</p>
<p>
A function assigned in the block becomes a method that belong to the class. If the function is declared with <code>:static</code> attribute appended right after the argument list, it would become a class method that you can call along with the class name. Otherwise, it would become an instance method that works with an instance created from the class.
</p>
<p>
A variable assigned in the block are registered as a class variable that belong to the class itself, not to an instance.
</p>
<p>
The assigned value is actually evaluated at the timing of assignment, which means you can even call a function to get the value.
</p>
</li>
<li><p>
<strong>Caller expression</strong>
</p>
<p>
A function or another callable is evaluated within the class as its environment.
</p>
</li>
</ul>
<p>
Here's a sample script to see details about factors in the block.
</p>
<pre><code>Person = class {

    __init__(name:string, age:number, role:string) = {
        this.name = name
        this.age = age
        this.role = role
    }

    fmt = 'name: %s, age: %d, role:%s\n'  // class variable

    Print() =  {
        // A class variable doesn't need 'this' or class name when accessing it
        // while an instance variable does.
        printf(fmt, this.name, this.age, this.role)
    }

    Test():static = {
        println('test of class method')
    }

}
</code></pre>
<p>
In an instance method, a variable named <code>this</code> is defined, which contains a reference to the instance itself. You always need to specify <code>this</code> variable to access instance variables and instance methods.
</p>
<p>
As for a class variable, a method can refer to it without specifying <code>this</code> or the class name.
</p>
<p>
An instance method <code>__init__()</code> is a special one that defines a constructor function. Its arguments are reflected on that of the constructor. The sample above creates a function named <code>Person</code> that has a declaration shown below:
</p>
<pre><code>Person(name:string, age:number, role:string) {block?}
</code></pre>
<p>
You can create an instance by calling it like below:
</p>
<pre><code>p = Person('Taro Yamada', 27, 'engineer')
</code></pre>
<p>
If you specify an optional block, the block procedure will be evaluated with a block parameter that takes the created instance.
</p>
<pre><code>Person('Taro Yamada', 27, 'engineer') {|p|
    // any process
}
</code></pre>
<p>
After an instance is created, you can call an instance method with it. Below is an example to call an instance method <code>Print()</code>, where <code>p</code> is the created instance:
</p>
<pre><code>p.Print()
</code></pre>
<p>
You can call a class method <code>Test()</code> like below:
</p>
<pre><code>Person.Test()
</code></pre>
<p>
You can also call a class method by specifying an instance.
</p>
<pre><code>p.Test()
</code></pre>
<h2><span class="caption-index-2">10.3</span><a name="anchor-10-3"></a>Inheritance</h2>
<h3><span class="caption-index-3">10.3.1</span><a name="anchor-10-3-1"></a>Basic</h3>
<p>
You can create an inherited class by specifying a super class in an argument of <code>class()</code>.
</p>
<pre><code>Person2 = class(Person) {
    // class variable and methods
}
</code></pre>
<p>
If you don't declare <code>__init__()</code> method in the derived class, it would inherit a constructor of the super class.
</p>
<h3><span class="caption-index-3">10.3.2</span><a name="anchor-10-3-2"></a>Constructor in Derived Class</h3>
<p>
When you declare <code>__init__()</code> method in the derived class, you have to specify block parameters that satisfies the argument declaration of the super class's constructor.
</p>
<pre><code>Teacher = class(Person) {
    __init__(name:string, age:number) = {|name, age, 'teacher'|
    }
    Work() = {
        println('give lectures to others')
    }
}

Student = class(Person) {
    __init__(name:string, age:number) = {|name, age, 'student'|
    }
    Work() = {
        println('learn about something')
    }
}
</code></pre>
<p>
As block parameters are just like oridinary arguments in a function call, you can describe any expressions in them. Though, take notice that you have to surround an expression including bitwise OR operation "<code>|</code>" with parentheses to avoid it from being confused with border characters around block parameters. See the example below:
</p>
<pre><code>A = class {
    __init__(name:string, bitflags:number) = {
        // any jobs
    }
}

B = class(A) {
    __init__() = {|'hello', (1 | 4 | 8)|
        // any jobs
    }
}
</code></pre>
<h3><span class="caption-index-3">10.3.3</span><a name="anchor-10-3-3"></a>Method Override</h3>
<p>
Take a look at a behavior of instance methods in an inherited class. Consider the following script:
</p>
<pre><code>A = class {
    func() = {
        println('A.func()')
    }
}

B = class(A) {
    func() = {
        println('B.func()')
    }
    test() = {
        this.func()  // calls B#func()
    }
}

b = B()
b.test()
</code></pre>
<p>
Both class A and B have a method with the same name <code>func()</code>. When the method <code>B#test()</code> evaluates <code>this.func()</code>, it actually calls <code>B#func()</code>.
</p>
<p>
You can use <code>super()</code> function to call a method that belongs to a super class. Below is a sample code to show how to use it.
</p>
<pre><code>B = class(A) {
    func() = {
        println('B.func()')
    }
    test() = {
        super(this).func()  // calls A#func()
    }
}
</code></pre>
<h2><span class="caption-index-2">10.4</span><a name="anchor-10-4"></a>Encapsulation</h2>
<p>
By default, instance and class variables are only accessible through <code>this</code> variable. Such variables are called <strong>private variable</strong>. You can make them accessible through other instance variables by specifying <code>:public</code> attribute in their assignment expressions. Those variables are called <strong>public variable</strong>.
</p>
<pre><code>X = class {

    c = 3
    d:public = 4

    __init__() = {
        this.a = 1
        this.b:public = 2
    }
}

x = X()
println(x.a)    // private instance variable .. Error
println(x.b)    // public instance variable  .. OK
println(x.c)    // private class variable    .. Error
println(x.d)    // public class variable     .. OK
</code></pre>
<p>
You can also call <code>public()</code> function within a block of <code>class()</code> function that indicates which variables are to be publicized. The <code>public()</code> function takes a block that contains two types of expressions: Identifier and Assign. An Identifer expression only declares a variable symbol for publication. An Assign expression creates a public class variable with the specified value.
</p>
<p>
The script below is equivalent with the above but uses <code>public()</code> function.
</p>
<pre><code>X = class {

    c = 3
    public {
        b
        d = 4
    }
    __init__() = {
        this.a = 1
        this.b = 2
    }
}
</code></pre>
<p>
Different from variables, methods are accessible through variables other than <code>this</code> by default. Such methods are called <strong>public method</strong>. You can make them only accessible through <code>this</code> variable by specifying <code>:private</code> attribute in their assignment expressions. Those methods are called <strong>private method</strong>.
</p>
<h2><span class="caption-index-2">10.5</span><a name="anchor-10-5"></a>Structure</h2>
<p>
A structure is a kind of a class, but offers a simple way to implement a constructor. Function <code>struct</code> takes variable declarations as its arguments that are reflected on the generated constructor. Below is an example:
</p>
<pre><code>Point = struct(x:number, y:number)
</code></pre>
<p>
This generates a constructor shown below:
</p>
<pre><code>Point(x:number, y:number)
</code></pre>
<p>
You can call it like below:
</p>
<pre><code>pt = Point(3, 4)
</code></pre>
<p>
A created instance from this class will have members named <code>x</code> and <code>y</code>.
</p>
<pre><code>printf('%d, %d\n', pt.x, pt.y)
</code></pre>
<p>
The code above that uses <code>struct</code> can be written using <code>class</code> like below:
</p>
<pre><code>Point = class {
    __init__(x:number, y:number) = {
        this.x:public = x
        this.y:public = y
    }
}
</code></pre>
<p>
A structure can also have methods by describing them in a block of <code>struct</code> function.
</p>
<pre><code>Point = struct(x:number, y:number) {
    Move(xdiff:number, ydiff:number) = {
        this.x += xdiff
        this.y += ydiff
    }
    Print() = {
        printf('%d, %d\n', this.x, this.y)
    }
}
</code></pre>
<h2><span class="caption-index-2">10.6</span><a name="anchor-10-6"></a>Creation of Multiple Instances</h2>
<p>
How can we create a list of instances from a certain class? Below is an example to create a list of <code>Person</code> instances.
</p>
<pre><code>people = [
    Person('Kikuo Ochiai',     24, 'teacher')
    Person('Seiji Miki',       33, 'engineer')
    Person('Haruka Nakao',     28, 'sales')
    Person('Takashi Sugimura', 21, 'student')
]
</code></pre>
<p>
Obviously, it's cumbersome to describe a function name <code>Person()</code> for each item. Using a list creation function <code>@</code> enables you to write more simple code.
</p>
<pre><code>people = @(Person) {
    { 'Kikuo Ochiai',     24, 'teacher'  }
    { 'Seiji Miki',       33, 'engineer' }
    { 'Haruka Nakao',     28, 'sales'    }
    { 'Takashi Sugimura', 21, 'student'  }
}
</code></pre>
<p>
Function <code>@</code> takes a function such as a constructor, and its block contains a set of argument lists fed into that function.
</p>
<h2><span class="caption-index-2">10.7</span><a name="anchor-10-7"></a>Forward Declaration</h2>
<p>
Within a block of the <code>class</code> function, it would be no problem for argument declarations to refer to its own class being currently declared.
</p>
<pre><code>A = class {
    func(a:A) = {     // This is OK.
        // ...
    }
}
</code></pre>
<p>
It's not allowed to refer to a class which declaration appears afterwards.
</p>
<pre><code>A = class {
    func(b:B) = {     // *** error ***
        // ...
    }
}

B = class {

}
</code></pre>
<p>
For such a case, you need to prepare a forward declaration of the referenced class before the referencing point by creating an empty class like below:
</p>
<pre><code>B = class()           // B's forward declaration.

A = class {
    func(b:B) = {     // This is OK.
        // ...
    }
}

B = class {           // B's actual declaration.
    // ...
}
</code></pre>
<p />

{% endraw %}
