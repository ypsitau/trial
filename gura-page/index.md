---
layout: toppage
lang: en
title: top
---
<div class="jumbotron">
  <h1 class="display-4">Gura Programming Language</h1>
  <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
  <hr class="my-4">
  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
  <a class="btn btn-primary btn-lg" href="/download/" role="button">Download</a>
</div>

<div class="container-fluid">
  <div class="row">
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
  <div class="row">
    <nav class="col-md-2 col-md-2 hidden-xs-down bg-faded sidebar">
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="#">Top <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Document</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Download</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Gallery</a>
        </li>
      </ul>
	</nav>
	<!-- class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3"> -->
    <div class="col-sm-10 pt-3">
	{% for i in (0..100) %}
	  hello {{ i }}
	{% endfor %}
	</div>
  </div>
</div>

<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" href="#">Active</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">Link</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">Link</a>
  </li>
  <li class="nav-item">
    <a class="nav-link disabled" href="#">Disabled</a>
  </li>
</ul>

<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
	<li class="breadcrumb-item"><a href="#">Home</a></li>
	<li class="breadcrumb-item"><a href="#">Library</a></li>
	<li class="breadcrumb-item active" aria-current="page">Data</li>
  </ol>
</nav>
<div class="border-bottom border-danger mb-3">
  hello
  <span class="border rounded-circle">
	hello
  </span>
</div>
<div class="border-bottom border-danger mb-3">
  hello
  <span class="border rounded-circle">
	hello
  </span>
</div>
<div class="btn-group">
  <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Action
  </button>
  <div class="dropdown-menu">
    <a class="dropdown-item" href="#">Action</a>
    <a class="dropdown-item" href="#">Another action</a>
    <a class="dropdown-item" href="#">Something else here</a>
    <div class="dropdown-divider"></div>
    <a class="dropdown-item" href="#">Separated link</a>
  </div>
</div>

