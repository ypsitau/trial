---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">18</span><a name="anchor-18"></a>Graphical User Interface</h1>
<h2><span class="caption-index-2">18.1</span><a name="anchor-18-1"></a>Overview</h2>
<p>
wxWidgets
</p>
<p>
Tk
</p>
<p>
SDL
</p>
<h2><span class="caption-index-2">18.2</span><a name="anchor-18-2"></a>wxWidgets</h2>
<h3><span class="caption-index-3">18.2.1</span><a name="anchor-18-2-1"></a>About wxWidgets</h3>
<p>
Gura's <code>wx</code> module uses libraries of <a href="https://www.wxwidgets.org/">wxWidgets</a> 3.0.0.
</p>
<h3><span class="caption-index-3">18.2.2</span><a name="anchor-18-2-2"></a>Simple Example</h3>
<p>
The code below is the simplest example that shows an empty window.
</p>
<pre><code>import(wx)

MyApp = class(wx.App) {
    OnInit() = {
        frame = MyFrame('Button Test', size =&gt; wx.Size(200, 100))
        frame.Show()
        true
    }
}

MyFrame = class(wx.Frame) {
    __init__(title:string, pos:wx.Point =&gt; wx.DefaultPosition,
            size:wx.Size =&gt; wx.DefaultSize) = {|nil, wx.ID_ANY, title, pos, size|
        wx.Button(this, wx.ID_ANY, 'Push Me')
    }
}

wx.IMPLEMENT_APP(MyApp)
</code></pre>
<p>
An application using wx module must create a class that derives from <code>wx.App</code> and implement <code>OnInit()</code> method in it. The method is responsible of initializing GUI-related resource and creating a main frame. It should return <code>true</code> at the end if no error occurs.
</p>
<p>
In the above example, the main frame is declared by a class <code>MyFrame</code> that derives from <code>wx.Frame</code>, which has a constructor function including an instance creation of  <code>wx.Button</code> contol. You can create any necessary controls within the constructor.
</p>
<p>
An application class is realized by calling <code>wx.IMPLEMENT_APP</code>, which runs a main loop in it.
</p>
<h3><span class="caption-index-3">18.2.3</span><a name="anchor-18-2-3"></a>Event Handling</h3>
<p>
There are several ways to address event handling. The first one is to call <code>wx.Window#Bind</code> method to the control instance like below.
</p>
<pre><code>import(wx)

MyApp = class(wx.App) {
    OnInit() = {
        frame = MyFrame('Button Test', size =&gt; wx.Size(200, 100))
        frame.Show()
        true
    }
}

MyFrame = class(wx.Frame) {
    __init__(title:string, pos:wx.Point =&gt; wx.DefaultPosition,
            size:wx.Size =&gt; wx.DefaultSize) = {|nil, wx.ID_ANY, title, pos, size|
        ctrl = wx.Button(this, wx.ID_ANY, 'Push Me')
        ctrl.Bind(wx.EVT_BUTTON) {|event|
            wx.MessageBox('Button was pushed', 'Button Test', wx.OK, this)
        }
    }
}

wx.IMPLEMENT_APP(MyApp)
</code></pre>
<p>
You need to specify an event type like <code>wx.EVT_BUTTON</code> as an argument for <code>wx.Window#Bind</code> method and also describe a procedure that will be evaluated when the event occurs as its block. You may specify a block parameter <code>event</code>, which will take an instance of <code>wx.CommandEvent</code> class at the block's evaluation. Even though the button controls doesn't offer much information with the event instance, more complicated controls could include more data in it.
</p>
<p>
Another approach is to assign unique identifiers to controls and let the parent window to handle events that are sent from them. The example comes like this:
</p>
<pre><code>import(wx)

MyApp = class(wx.App) {
    OnInit() = {
        frame = MyFrame('Button Test', size =&gt; wx.Size(200, 100))
        frame.Show()
        true
    }
}

MyFrame = class(wx.Frame) {
    [
        ID_BTN_PushMe
    ] = wx.NewIds()
    __init__(title:string, pos:wx.Point =&gt; wx.DefaultPosition,
            size:wx.Size =&gt; wx.DefaultSize) = {|nil, wx.ID_ANY, title, pos, size|
        ctrl = wx.Button(this, ID_BTN_PushMe, 'Push Me')
        this.Bind(wx.EVT_BUTTON, ID_BTN_PushMe) {|event|
            wx.MessageBox('Button was pushed', 'Button Test', wx.OK, this)
        }
    }
}

wx.IMPLEMENT_APP(MyApp)
</code></pre>
<p>
The function <code>wx.NewIds</code> generates as many unique identifers as you want. You can specify one of them to the second argument of a control constructor and also the second argument of <code>window#Bind</code> method. The identifier is necessary because the parent window must determine what control has issued the event.
</p>
<h3><span class="caption-index-3">18.2.4</span><a name="anchor-18-2-4"></a>Layout Management</h3>
<p>
You can use classes derived from <code>wx.Sizer</code> to arrange controls' size and position.
</p>
<pre><code>import(wx)

MyApp = class(wx.App) {
    OnInit() = {
        frame = MyFrame('Button Test', size =&gt; wx.Size(200, 200))
        frame.Show()
        true
    }
}

MyFrame = class(wx.Frame) {
    __init__(title:string, pos:wx.Point =&gt; wx.DefaultPosition,
            size:wx.Size =&gt; wx.DefaultSize) = {|nil, wx.ID_ANY, title, pos, size|
        vbox = wx.BoxSizer(wx.VERTICAL)
        this.SetSizer(vbox)
        ctrl = wx.Button(this, wx.ID_ANY, 'First')
        vbox.Add(ctrl, wx.SizerFlags(1).Expand())
        ctrl = wx.Button(this, wx.ID_ANY, 'Second')
        vbox.Add(ctrl, wx.SizerFlags(1).Expand())
        ctrl = wx.Button(this, wx.ID_ANY, 'Third')
        vbox.Add(ctrl, wx.SizerFlags(1).Expand())
    }
}

wx.IMPLEMENT_APP(MyApp)
</code></pre>
<p>
<code>wx.BoxSizer</code> is one the sizer classes that layouts controls in a direction, either vertical or horizontal. A top-level sizer must be associated to the window by <code>window#SetSizer</code> method. And then, you can put each control under the sizer's management by calling <code>wx.Sizer#Add</code> method. The method takes a <code>wx.SizerFlags</code> instance as its second argument, with which you can specify how the control's size is arranged.
</p>
<h3><span class="caption-index-3">18.2.5</span><a name="anchor-18-2-5"></a>More Sample Scripts</h3>
<p>
You can find sample scripts using wxWidgets on <a href="https://github.com/gura-lang/gura/tree/master/sample/wx/">GitHub repository</a>.
</p>
<h2><span class="caption-index-2">18.3</span><a name="anchor-18-3"></a>Tk</h2>
<h3><span class="caption-index-3">18.3.1</span><a name="anchor-18-3-1"></a>About Tk</h3>
<p>
Gura provides modules named <code>tcl</code> and <code>tk</code> that use <a href="http://www.tcl.tk/">Tcl/Tk</a> library for GUI programming.
</p>
<h3><span class="caption-index-3">18.3.2</span><a name="anchor-18-3-2"></a>Simple Example</h3>
<p>
The following example creates a window that has one Button widget.
</p>
<pre><code>import(tk)

tk.mainwindow() {|mw|
    mw.Button(text =&gt; 'Push me') {|w|
        w.pack()
        w.bind(`command) {
            w.tk$MessageBox(title =&gt; 'event', message =&gt; 'hello')
        }
    }
}
tk.mainloop()
</code></pre>
<h3><span class="caption-index-3">18.3.3</span><a name="anchor-18-3-3"></a>Sample Script</h3>
<p>
The code below is a drawing program. I have ported it from a sample in <a href="http://www.tkdocs.com/">TkDocs</a>.
</p>
<pre><code>import(tk)

tk.mainwindow() {|mw|
    mw.Canvas(bg =&gt; 'white') {|c|
        c.pack(fill =&gt; 'both', expand =&gt; true)
        [lastx, lasty] = [0, 0]
        color = 'black'
        c.bind('&lt;1&gt;') {|x:number, y:number|
            [lastx, lasty] = [x, y]
        }
        c.bind('&lt;B1-Motion&gt;') {|x:number, y:number|
            addLine(x, y)
        }
        addLine(x:number, y:number) = {
            extern(lastx, lasty)
            c.Line(lastx, lasty, x, y, fill =&gt; color, width =&gt; 3)
            [lastx, lasty] = [x, y]
        }
        setColor(colorNew:string) = {
            color:extern = colorNew
        }
        function(color:string, y:number):map {
            c.Rectangle(10, y, 30, y + 20, fill =&gt; color) {|item|
                item.bind('&lt;1&gt;') { setColor(color) }
            }
        }(['red', 'blue', 'black'], 10 + (0..) * 25)
    }
}
tk.mainloop()
</code></pre>
<p>
Sample result.
</p>
<p>
<img src="../images/tk-demo.png" alt="tk-demo">
</p>
<h3><span class="caption-index-3">18.3.4</span><a name="anchor-18-3-4"></a>More Sample Scripts</h3>
<p>
You can find sample scripts using Tk on <a href="https://github.com/gura-lang/gura/tree/master/sample/tk/">GitHub repository</a>.
</p>
<h2><span class="caption-index-2">18.4</span><a name="anchor-18-4"></a>SDL</h2>
<h3><span class="caption-index-3">18.4.1</span><a name="anchor-18-4-1"></a>About SDL</h3>
<p>
Gura provides a module named <code>sdl</code> that uses <a href="http://www.libsdl.org/">SDL</a> library.
</p>
<p>
SDL, Simple DirectMedia Layer, is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.
</p>
<h3><span class="caption-index-3">18.4.2</span><a name="anchor-18-4-2"></a>Simple Example</h3>
<p>
The following script only shows a blank window by using SDL.
</p>
<pre><code>import(sdl)

sdl.Init(sdl.INIT_EVERYTHING)
screen = sdl.SetVideoMode(640, 480, 16, sdl.SWSURFACE)
repeat {
    event = sdl.WaitEvent()
    (event.type == sdl.QUIT) &amp;&amp; break
}
</code></pre>
<p>
At first, you have to initialize SDL's status by calling <code>sdl.Init</code>. Then, calling <code>sdl.SetVideoMode</code> with screen size and depth in its arguments will show a window.
</p>
<p>
Unlike other GUI platform, SDL requires you to implement an event handling loop explicitly. The function <code>sdl.WaitEvent</code> would wait until some events come in and returns an instance of <code>sdl.Event</code> class that contains event type and related information.
</p>
<h3><span class="caption-index-3">18.4.3</span><a name="anchor-18-4-3"></a>More Sample Scripts</h3>
<p>
You can find sample scripts using SDL on <a href="https://github.com/gura-lang/gura/tree/master/sample/sdl/">GitHub repository</a>.
</p>
<p />

{% endraw %}
