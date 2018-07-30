---
layout: toppage
lang: en
title: top
---
<div class="jumbotron">
  <h1 class="display-4">Gura Programming Language</h1>
  <p class="lead">A programming language that comes with powerful operation on iterators.</p>
  <a class="btn btn-primary btn-lg" href="/download/" role="button">Download</a>
</div>

<div class="container-fluid">
  <div class="row">
	<div class="col-md-6">
	  <div class="card">
		<div class="card-body">
		  <h5 class="card-title">Latest News</h5>
		  <table>
			<tr><td style="white-space:nowrap">2017-07-04</td><td>
				<a href="Download.html">Gura v0.7.0</a> was released.
			</td></tr>

			<tr><td style="white-space:nowrap">2015-06-30</td><td>
				<a href="Documents.html">Documents</a> in PDF format were published.
			</td></tr>

			<tr><td style="white-space:nowrap">2015-06-24</td><td>
				<a href="Download.html">Gura v0.6.2</a> was released.
			</td></tr>

			<tr><td style="white-space:nowrap">2015-04-10</td><td>
				<a href="library-reference/index.html">Gura Library Reference</a> was published.
			</td></tr>

			<tr><td style="white-space:nowrap">2015-01-07</td><td>
				<a href="Download.html">Gura v0.6.1</a> was released.
			</td></tr>

		  </table>
		</div>
	  </div>
	</div>
	<div class="col-md-6">
	  <div class="card">
<div class="card-body" markdown="1">
<h5 class="card-title">What's This?</h5>
**Gura** is an **iterator-oriented** programming language
that focuses on iterators with improved functions for calculation and data processing.
It gives you a new possibility to write more elegant codes than ever,
but with a familiar appearance.

Take a look at a simple example.
The following code prints content of a text file along with line numbers.

    printf('%d %s', 1.., readlines('foo.txt'))

Apparently, there seems to be no special trick with this program.
But a new feature called **Implicit Mapping** is working internally,
which automatically repeats evaluation of `printf` function
after it's given with iterators, `1..` and `readlines('foo.txt')`, as its arguments.
</div>
	  </div>
	</div>
  </div>

  <div class="row mt-2">
	<div class="col-md-6">
	  <div class="card">
<div class="card-body" markdown="1">
<h5 class="card-title">Features</h5>
* It provides a variety of iterator operations including mapping process
  such as **Implicit Mapping** and **Member Mapping**.
* It supports object oriented programming with class and instance mechanism.
* It's being shipped with various modules including powerful GUI toolkits
  that enable you to develop practical applications.
  The site [http://app.gura-lang.org/](http://app.gura-lang.org/) introduces you
  some applications that makes use of Gura.
</div>
	  </div>
	</div>
	<div class="col-md-6">
	  <div class="card">
		<div class="card-header">
		  Featured
		</div>
		<div class="card-body">
		  <h5 class="card-title">Special title treatment</h5>
		  <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
		  <a href="#" class="btn btn-primary">Go somewhere</a>
		</div>
	  </div>
	</div>
  </div>
</div>
