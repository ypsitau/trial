---
layout: default
lang: en
title: Gura Language Manual
---
<h1>Gura Language Manual</h1>

<div><span class="toc-index-1">1</span><a href="chapter-01.html#anchor-1">Introduction</a></div>
<div><span class="toc-index-1">2</span><a href="chapter-02.html#anchor-2">Launch Program</a></div>
<div><span class="toc-index-2">2.1</span><a href="chapter-02.html#anchor-2-1">Program Files</a></div>
<div><span class="toc-index-2">2.2</span><a href="chapter-02.html#anchor-2-2">Interactive Mode</a></div>
<div><span class="toc-index-2">2.3</span><a href="chapter-02.html#anchor-2-3">Run Script File</a></div>
<div><span class="toc-index-2">2.4</span><a href="chapter-02.html#anchor-2-4">Composite File</a></div>
<div><span class="toc-index-2">2.5</span><a href="chapter-02.html#anchor-2-5">Command Line Options</a></div>
<div><span class="toc-index-2">2.6</span><a href="chapter-02.html#anchor-2-6">System Directory</a></div>
<div><span class="toc-index-2">2.7</span><a href="chapter-02.html#anchor-2-7">Working Directory</a></div>
<div><span class="toc-index-1">3</span><a href="chapter-03.html#anchor-3">Syntax</a></div>
<div><span class="toc-index-2">3.1</span><a href="chapter-03.html#anchor-3-1">Overview</a></div>
<div><span class="toc-index-2">3.2</span><a href="chapter-03.html#anchor-3-2">Token</a></div>
<div><span class="toc-index-2">3.3</span><a href="chapter-03.html#anchor-3-3">Expression</a></div>
<div><span class="toc-index-1">4</span><a href="chapter-04.html#anchor-4">Data Type</a></div>
<div><span class="toc-index-2">4.1</span><a href="chapter-04.html#anchor-4-1">Overview</a></div>
<div><span class="toc-index-2">4.2</span><a href="chapter-04.html#anchor-4-2">Primitive Data Types</a></div>
<div><span class="toc-index-2">4.3</span><a href="chapter-04.html#anchor-4-3">Object Data Types Frequently Used</a></div>
<div><span class="toc-index-1">5</span><a href="chapter-05.html#anchor-5">Operator</a></div>
<div><span class="toc-index-2">5.1</span><a href="chapter-05.html#anchor-5-1">Overview</a></div>
<div><span class="toc-index-2">5.2</span><a href="chapter-05.html#anchor-5-2">Precedence</a></div>
<div><span class="toc-index-2">5.3</span><a href="chapter-05.html#anchor-5-3">Calculation Operators</a></div>
<div><span class="toc-index-2">5.4</span><a href="chapter-05.html#anchor-5-4">Other Operators</a></div>
<div><span class="toc-index-2">5.5</span><a href="chapter-05.html#anchor-5-5">Operator Overload</a></div>
<div><span class="toc-index-1">6</span><a href="chapter-06.html#anchor-6">Environment</a></div>
<div><span class="toc-index-2">6.1</span><a href="chapter-06.html#anchor-6-1">Overview</a></div>
<div><span class="toc-index-2">6.2</span><a href="chapter-06.html#anchor-6-2">Frame</a></div>
<div><span class="toc-index-1">7</span><a href="chapter-07.html#anchor-7">Interpreter</a></div>
<div><span class="toc-index-2">7.1</span><a href="chapter-07.html#anchor-7-1">How Interpreter Works</a></div>
<div><span class="toc-index-2">7.2</span><a href="chapter-07.html#anchor-7-2">Evaluation Stage</a></div>
<div><span class="toc-index-2">7.3</span><a href="chapter-07.html#anchor-7-3">Assignment Stage</a></div>
<div><span class="toc-index-1">8</span><a href="chapter-08.html#anchor-8">Function</a></div>
<div><span class="toc-index-2">8.1</span><a href="chapter-08.html#anchor-8-1">Definition and Evaluation</a></div>
<div><span class="toc-index-2">8.2</span><a href="chapter-08.html#anchor-8-2">Returned Value</a></div>
<div><span class="toc-index-2">8.3</span><a href="chapter-08.html#anchor-8-3">Arguments</a></div>
<div><span class="toc-index-2">8.4</span><a href="chapter-08.html#anchor-8-4">Block</a></div>
<div><span class="toc-index-2">8.5</span><a href="chapter-08.html#anchor-8-5">Attribute</a></div>
<div><span class="toc-index-2">8.6</span><a href="chapter-08.html#anchor-8-6">Help Block</a></div>
<div><span class="toc-index-2">8.7</span><a href="chapter-08.html#anchor-8-7">Anonymous Function</a></div>
<div><span class="toc-index-2">8.8</span><a href="chapter-08.html#anchor-8-8">Closure</a></div>
<div><span class="toc-index-2">8.9</span><a href="chapter-08.html#anchor-8-9">Leader-trailer Relationship</a></div>
<div><span class="toc-index-1">9</span><a href="chapter-09.html#anchor-9">Flow Control</a></div>
<div><span class="toc-index-2">9.1</span><a href="chapter-09.html#anchor-9-1">Branch</a></div>
<div><span class="toc-index-2">9.2</span><a href="chapter-09.html#anchor-9-2">Repeat</a></div>
<div><span class="toc-index-2">9.3</span><a href="chapter-09.html#anchor-9-3">Error Handling</a></div>
<div><span class="toc-index-1">10</span><a href="chapter-10.html#anchor-10">Object Oriented Programming</a></div>
<div><span class="toc-index-2">10.1</span><a href="chapter-10.html#anchor-10-1">Class and Instance</a></div>
<div><span class="toc-index-2">10.2</span><a href="chapter-10.html#anchor-10-2">User-defined Class</a></div>
<div><span class="toc-index-2">10.3</span><a href="chapter-10.html#anchor-10-3">Inheritance</a></div>
<div><span class="toc-index-2">10.4</span><a href="chapter-10.html#anchor-10-4">Encapsulation</a></div>
<div><span class="toc-index-2">10.5</span><a href="chapter-10.html#anchor-10-5">Structure</a></div>
<div><span class="toc-index-2">10.6</span><a href="chapter-10.html#anchor-10-6">Creation of Multiple Instances</a></div>
<div><span class="toc-index-2">10.7</span><a href="chapter-10.html#anchor-10-7">Forward Declaration</a></div>
<div><span class="toc-index-1">11</span><a href="chapter-11.html#anchor-11">Mapping Process</a></div>
<div><span class="toc-index-2">11.1</span><a href="chapter-11.html#anchor-11-1">About This Chapter</a></div>
<div><span class="toc-index-2">11.2</span><a href="chapter-11.html#anchor-11-2">Implicit Mapping</a></div>
<div><span class="toc-index-2">11.3</span><a href="chapter-11.html#anchor-11-3">Member Mapping</a></div>
<div><span class="toc-index-1">12</span><a href="chapter-12.html#anchor-12">Module</a></div>
<div><span class="toc-index-2">12.1</span><a href="chapter-12.html#anchor-12-1">Module as Environment</a></div>
<div><span class="toc-index-2">12.2</span><a href="chapter-12.html#anchor-12-2">Importing Module File</a></div>
<div><span class="toc-index-2">12.3</span><a href="chapter-12.html#anchor-12-3">Creating Module File</a></div>
<div><span class="toc-index-2">12.4</span><a href="chapter-12.html#anchor-12-4">Extensions by Module</a></div>
<div><span class="toc-index-2">12.5</span><a href="chapter-12.html#anchor-12-5">List of Bundled Modules</a></div>
<div><span class="toc-index-2">12.6</span><a href="chapter-12.html#anchor-12-6">Creating Binary Module File</a></div>
<div><span class="toc-index-1">13</span><a href="chapter-13.html#anchor-13">String and Binary</a></div>
<div><span class="toc-index-2">13.1</span><a href="chapter-13.html#anchor-13-1">Overview</a></div>
<div><span class="toc-index-2">13.2</span><a href="chapter-13.html#anchor-13-2">Operation on String</a></div>
<div><span class="toc-index-2">13.3</span><a href="chapter-13.html#anchor-13-3">Formatter</a></div>
<div><span class="toc-index-2">13.4</span><a href="chapter-13.html#anchor-13-4">Functions Equipped with Formatter</a></div>
<div><span class="toc-index-2">13.5</span><a href="chapter-13.html#anchor-13-5">Syntax of Format Specifier</a></div>
<div><span class="toc-index-2">13.6</span><a href="chapter-13.html#anchor-13-6">Regular Expression</a></div>
<div><span class="toc-index-2">13.7</span><a href="chapter-13.html#anchor-13-7">Operation on Binary</a></div>
<div><span class="toc-index-1">14</span><a href="chapter-14.html#anchor-14">Iterator/List Operation</a></div>
<div><span class="toc-index-2">14.1</span><a href="chapter-14.html#anchor-14-1">Overview</a></div>
<div><span class="toc-index-2">14.2</span><a href="chapter-14.html#anchor-14-2">Iteration on Iterators and Lists</a></div>
<div><span class="toc-index-2">14.3</span><a href="chapter-14.html#anchor-14-3">Iterator-specific Manipulation</a></div>
<div><span class="toc-index-2">14.4</span><a href="chapter-14.html#anchor-14-4">List-specific Manipulation</a></div>
<div><span class="toc-index-2">14.5</span><a href="chapter-14.html#anchor-14-5">Common Manipulation for Iterator and List</a></div>
<div><span class="toc-index-2">14.6</span><a href="chapter-14.html#anchor-14-6">Iterator Generation</a></div>
<div><span class="toc-index-1">15</span><a href="chapter-15.html#anchor-15">File Operation</a></div>
<div><span class="toc-index-2">15.1</span><a href="chapter-15.html#anchor-15-1">Overview</a></div>
<div><span class="toc-index-2">15.2</span><a href="chapter-15.html#anchor-15-2">Pathname</a></div>
<div><span class="toc-index-2">15.3</span><a href="chapter-15.html#anchor-15-3">Stream</a></div>
<div><span class="toc-index-2">15.4</span><a href="chapter-15.html#anchor-15-4">Directory</a></div>
<div><span class="toc-index-2">15.5</span><a href="chapter-15.html#anchor-15-5">OS-specific Operations</a></div>
<div><span class="toc-index-1">16</span><a href="chapter-16.html#anchor-16">Network Operation</a></div>
<div><span class="toc-index-2">16.1</span><a href="chapter-16.html#anchor-16-1">Overview</a></div>
<div><span class="toc-index-2">16.2</span><a href="chapter-16.html#anchor-16-2">Client-side Operation</a></div>
<div><span class="toc-index-2">16.3</span><a href="chapter-16.html#anchor-16-3">Server-side Operation</a></div>
<div><span class="toc-index-1">17</span><a href="chapter-17.html#anchor-17">Image Operation</a></div>
<div><span class="toc-index-2">17.1</span><a href="chapter-17.html#anchor-17-1">Overview</a></div>
<div><span class="toc-index-2">17.2</span><a href="chapter-17.html#anchor-17-2">Image Instance</a></div>
<div><span class="toc-index-2">17.3</span><a href="chapter-17.html#anchor-17-3">Format-specific Operations</a></div>
<div><span class="toc-index-2">17.4</span><a href="chapter-17.html#anchor-17-4">JPEG</a></div>
<div><span class="toc-index-2">17.5</span><a href="chapter-17.html#anchor-17-5">GIF</a></div>
<div><span class="toc-index-2">17.6</span><a href="chapter-17.html#anchor-17-6">Cairo</a></div>
<div><span class="toc-index-2">17.7</span><a href="chapter-17.html#anchor-17-7">OpenGL</a></div>
<div><span class="toc-index-1">18</span><a href="chapter-18.html#anchor-18">Graphical User Interface</a></div>
<div><span class="toc-index-2">18.1</span><a href="chapter-18.html#anchor-18-1">Overview</a></div>
<div><span class="toc-index-2">18.2</span><a href="chapter-18.html#anchor-18-2">wxWidgets</a></div>
<div><span class="toc-index-2">18.3</span><a href="chapter-18.html#anchor-18-3">Tk</a></div>
<div><span class="toc-index-2">18.4</span><a href="chapter-18.html#anchor-18-4">SDL</a></div>
<div><span class="toc-index-1">19</span><a href="chapter-19.html#anchor-19">Mathematic Functions</a></div>
<div><span class="toc-index-2">19.1</span><a href="chapter-19.html#anchor-19-1">Complex Number</a></div>
<div><span class="toc-index-2">19.2</span><a href="chapter-19.html#anchor-19-2">Rational Number</a></div>
<div><span class="toc-index-2">19.3</span><a href="chapter-19.html#anchor-19-3">Big Number</a></div>
<div><span class="toc-index-2">19.4</span><a href="chapter-19.html#anchor-19-4">Differentiation Formula</a></div>
<div><span class="toc-index-1">20</span><a href="chapter-20.html#anchor-20">Template Engine</a></div>
<div><span class="toc-index-2">20.1</span><a href="chapter-20.html#anchor-20-1">Overview</a></div>
<div><span class="toc-index-2">20.2</span><a href="chapter-20.html#anchor-20-2">How to Invoke Template Engine</a></div>
<div><span class="toc-index-2">20.3</span><a href="chapter-20.html#anchor-20-3">Embedded Script</a></div>
<div><span class="toc-index-2">20.4</span><a href="chapter-20.html#anchor-20-4">Indentation</a></div>
<div><span class="toc-index-2">20.5</span><a href="chapter-20.html#anchor-20-5">Rendering nil Value</a></div>
<div><span class="toc-index-2">20.6</span><a href="chapter-20.html#anchor-20-6">Calling Function with Block</a></div>
<div><span class="toc-index-2">20.7</span><a href="chapter-20.html#anchor-20-7">Template Directive</a></div>
<div><span class="toc-index-2">20.8</span><a href="chapter-20.html#anchor-20-8">Comment</a></div>
<div><span class="toc-index-2">20.9</span><a href="chapter-20.html#anchor-20-9">Scope Issues</a></div>
<p />
