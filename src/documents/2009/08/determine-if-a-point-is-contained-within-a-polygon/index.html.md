---
layout: post
title: Determine if a point is contained within a polygon
date: 2009-08-18
tags: ["c#"]
---

One of my recent projects had a requirement to take a list of points and a list of polygons (of any order), and determine which points were in which polygons. I find this problem interesting, because the solution is not apparent, but it is easy to implement.

One common algorithm is called the ray casting algorithm. [You can read more about the ray casting algorithm on Wikipedia](http://en.wikipedia.org/wiki/Point_in_polygon). My buddy Google was able to find [another great resource](http://alienryderflex.com/polygon/) with some sample Java code.

After an initial performance test, I found this algorithm to be extremely fast. I was able to process over 200,000 checks in under a second.

I converted the code to something a little more object oriented. I wanted a class that would represent a Polygon, and also have a method that would tell me if a point was contained within it. I'm including the code in the hopes that it may help someone else one day:
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4d16a27b-51d1-4abc-8272-117ce166f9e1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">/// &lt;summary&gt;
///		Represents a geometric polygon made up of any number of sides, defined by &lt;see cref="PointF"/&gt; structures
///		between those points.
/// &lt;/summary&gt;
public class Polygon
{
    private readonly PointF[] _vertices;

    /// &lt;summary&gt;
    ///		Creates a new instance of the &lt;see cref="Polygon"/&gt; class with the specified vertices.
    /// &lt;/summary&gt;
    /// &lt;param name="vertices"&gt;
    ///		An array of &lt;see cref="PointF"/&gt; structures representing the points between the sides of the polygon.
    /// &lt;/param&gt;
    public Polygon(PointF[] vertices)
    {
        _vertices = vertices;
    }

    /// &lt;summary&gt;
    ///		Determines if the specified &lt;see cref="PointF"/&gt; if within this polygon.
    /// &lt;/summary&gt;
    /// &lt;remarks&gt;
    ///		This algorithm is extremely fast, which makes it appropriate for use in brute force algorithms.
    /// &lt;/remarks&gt;
    /// &lt;param name="point"&gt;
    ///		The point containing the x,y coordinates to check.
    /// &lt;/param&gt;
    /// &lt;returns&gt;
    ///		&lt;c&gt;true&lt;/c&gt; if the point is within the polygon, otherwise &lt;c&gt;false&lt;/c&gt;
    /// &lt;/returns&gt;
    public bool PointInPolygon(PointF point)
    {
        var j = _vertices.Length - 1;
        var oddNodes = false;

        for (var i = 0; i &lt; _vertices.Length; i++)
        {
            if (_vertices[i].Y &lt; point.Y &amp;&amp; _vertices[j].Y &gt;= point.Y ''
                _vertices[j].Y &lt; point.Y &amp;&amp; _vertices[i].Y &gt;= point.Y)
            {
                if (_vertices[i].X +
                    (point.Y - _vertices[i].Y)/(_vertices[j].Y - _vertices[i].Y)*(_vertices[j].X - _vertices[i].X) &lt; point.X)
                {
                    oddNodes = !oddNodes;
                }
            }
            j = i;
        }

        return oddNodes;
    }
}</pre></div>

Of course I can't write a class without the appropriate unit tests:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:89be2ab7-4fb8-4efe-af79-b22559ce957e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">[TestClass]
public class PolygonTests
{
    [TestMethod]
    public void PointInPolygon_InnerPoint_ContainedWithinPolygon()
    {
        var vertices = new PointF[4]
                            {
                                new PointF(1, 3),
                                new PointF(1, 1),
                                new PointF(4, 1),
                                new PointF(4, 3)
                            };

        var p = new Polygon(vertices);

        Assert.AreEqual(true, p.PointInPolygon(new PointF(2,2)));
    }

    [TestMethod]
    public void PointInPolygon_OuterPoint_NotContainedWithinPolygon()
    {
        var vertices = new PointF[4]
                            {
                                new PointF(1, 3),
                                new PointF(1, 1),
                                new PointF(4, 1),
                                new PointF(4, 3)
                            };

        var p = new Polygon(vertices);

        Assert.AreEqual(false, p.PointInPolygon(new PointF(5,3)));
    }

    [TestMethod]
    public void PointInPolygon_DiagonalPointWithin()
    {
        var vertices = new PointF[3]
                            {
                                new PointF(1, 3),
                                new PointF(1, 1),
                                new PointF(4, 1)
                            };

        var p = new Polygon(vertices);

        Assert.AreEqual(true, p.PointInPolygon(new PointF(2, 2)));
    }

    [TestMethod]
    public void PointInPolygon_DiagonalPointOut()
    {
        var vertices = new PointF[3]
                            {
                                new PointF(1, 3),
                                new PointF(1, 1),
                                new PointF(4, 1)
                            };

        var p = new Polygon(vertices);

        Assert.AreEqual(false, p.PointInPolygon(new PointF(3, 3)));
    }

    [TestMethod]
    public void PointInPolygon_PerformanceTest()
    {
        var vertices = new PointF[4]
                            {
                                new PointF(1, 3),
                                new PointF(1, 1),
                                new PointF(4, 1),
                                new PointF(4, 3)
                            };

        var p = new Polygon(vertices);

        var sw = new Stopwatch();
        sw.Start();

        for(var i = 0; i &lt; 200000; i++)
            p.PointInPolygon(new PointF(2, 2));

        sw.Stop();

        Assert.IsTrue(sw.Elapsed.TotalSeconds &lt; 1);
    }
}</pre></div>

The last unit test was only to determine if this method was going to be performant enough for the scenario I wanted to use it in. You may want to remove it or mark it as explicit if you can to avoid timing issues affecting your test outcomes.

If anyone see's a bug, let me know!