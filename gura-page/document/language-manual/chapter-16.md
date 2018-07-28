---
layout: page
lang: en
title: Gura Language Manual
---

{% raw %}
<h1><span class="caption-index-1">16</span><a name="anchor-16"></a>Network Operation</h1>
<h2><span class="caption-index-2">16.1</span><a name="anchor-16-1"></a>Overview</h2>
<p>
<code>curl</code> module
</p>
<p>
<code>http</code> module
</p>
<p>
client-side and server-side
</p>
<h2><span class="caption-index-2">16.2</span><a name="anchor-16-2"></a>Client-side Operation</h2>
<p>
You can download files via HTTP protocol using a generic stream-copy function copy. Below is the example.
</p>
<pre><code>import(http)
copy('http://sourceforge.jp/', 'sf.html')
</code></pre>
<p>
If you want to use a proxy server, you need to specify a server setting using http.addproxy like follows.
</p>
<pre><code>import(http)
http.addproxy('xx.xx.xx.xx', 8080, 'username', 'password')
copy('http://sourceforge.jp/', 'sf.html')
</code></pre>
<h2><span class="caption-index-2">16.3</span><a name="anchor-16-3"></a>Server-side Operation</h2>
<p>
Simple Example:
</p>
<pre><code>import(http)

text = R'''
&lt;html&gt;
&lt;body&gt;
Welcome to Gura server
&lt;/body&gt;
&lt;/html&gt;
'''

http.server(port =&gt; 8000).wait {|req|
    println(req.uri)
    req.response('200', nil, text.encode('utf-8'),
        'Cache-Control' =&gt; 'private'
        'Server'        =&gt; 'Gura_HTTP_Server'
        'Connection'    =&gt; 'Keep-Alive'
        'Content-Type'  =&gt; 'text/html')
}
</code></pre>
<p>
The following example works as a HTTP server, which generates a graph that shows values in SQLite3 database <a href="https://github.com/gura-lang/gura/blob/master/sample/resource/temperature.sqlite3?raw=true">temperature.sqlite3</a>.
</p>
<pre><code>import(re)
import(cairo)
import(http)
import(png)
import(sqlite3)

makeGraph(iSites[]:number) = {
    Item = struct(day:number, temps*:number)
    tbl = Item * sqlite3.db('temperature.sqlite3').query('select * from sites')
    img = image(`rgba, 320, 320, `white)
    [wdAxis, htAxis] = [img.width * 0.9, img.height * 0.9]
    [xAxis, yAxis] = [(img.width - wdAxis) / 2, (img.height - htAxis) / 2]
    [dayMax, dayMin] = [tbl:*day.max(), tbl:*day.min()]
    dayRange = dayMax - dayMin
    [tempMax, tempMin] = [tbl:*temps:*max().max(), tbl:*temps:*min().min()]
    tempRange = tempMax - tempMin
    calcX(day) = xAxis + (day - dayMin) * wdAxis / dayRange
    calcY(temp) = yAxis + htAxis - (temp - tempMin) * htAxis / tempRange
    img.cairo {|cr|
        cr.set_line_width(img.height / 300)
        cr.rectangle(xAxis, yAxis, wdAxis, htAxis).stroke()
        cr.save {
            cr.set_dash([img.height / 200, img.height / 200], 0)
            cr.move_to(xAxis, calcY(0)).line_to(xAxis + wdAxis, calcY(0))
            cr.stroke()
        }
        for (iSite in iSites) {
            func = cr.move_to
            for (item in tbl) {
                func(calcX(item.day), calcY(item.temps[iSite]))
                func = cr.line_to
            }
            cr.stroke()
        }
    }
    img
}
http.server(port =&gt; 80).wait {|req|
    iSites = [0]
    query = req.query
    if (query.haskey('site')) {
        iSites = tonumber(query['site'].split(','):list)
    }
    buff = binary()
    makeGraph(iSites).pngwrite(buff)
    req.response('200', nil, buff,
        'Server' =&gt; 'Gura_HTTP_Server' 'Connection' =&gt; 'close')
}
</code></pre>
<p>
After the script runs, it waits for HTTP requests. Launch a Web browser and access to it as like http://localhost/?site=0,1. If you try it on Linux, you have to run the script as a root user or replace the port number with one larger than or equal to 1024.
</p>
<p />

{% endraw %}
