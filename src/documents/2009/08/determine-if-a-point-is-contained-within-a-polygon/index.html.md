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

	/// <summary>
	///      Represents a geometric polygon made up of any number of sides, defined by <see cref="PointF"/> structures
	///      between those points.
	/// </summary>
	public class Polygon
	{
	    private readonly PointF[] _vertices;
	
	    /// <summary>
	    ///     Creates a new instance of the <see cref="Polygon"/> class with the specified vertices.
	    /// </summary>
	    /// <param name="vertices">
	    ///     An array of <see cref="PointF"/> structures representing the points between the sides of the polygon.
	    /// </param>
	    public Polygon(PointF[] vertices)
	    {
	        _vertices = vertices;
	    }
	
	    /// <summary>
	    ///     Determines if the specified <see cref="PointF"/> if within this polygon.
	    /// </summary>
	    /// <remarks>
	    ///     This algorithm is extremely fast, which makes it appropriate for use in brute force algorithms.
	    /// </remarks>
	    /// <param name="point">
	    ///     The point containing the x,y coordinates to check.
	    /// </param>
	    /// <returns>
	    ///     <c>true</c> if the point is within the polygon, otherwise <c>false</c>
	    /// </returns>
	    public bool PointInPolygon(PointF point)
	    {
	        var j = _vertices.Length - 1;
	        var oddNodes = false;
	
	        for (var i = 0; i < _vertices.Length; i++)
	        {
	            if (_vertices[i].Y < point.Y && _vertices[j].Y >= point.Y ''
	                _vertices[j].Y < point.Y && _vertices[i].Y >= point.Y)
	            {
	                if (_vertices[i].X +
	                    (point.Y - _vertices[i].Y)/(_vertices[j].Y - _vertices[i].Y)*(_vertices[j].X - _vertices[i].X) < point.X)
	                {
	                    oddNodes = !oddNodes;
	                }
	            }
	            j = i;
	        }
	
	        return oddNodes;
	    }
	}

Of course I can't write a class without the appropriate unit tests:

	[TestClass]
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
	
	        for(var i = 0; i < 200000; i++)
	            p.PointInPolygon(new PointF(2, 2));
	
	        sw.Stop();
	
	        Assert.IsTrue(sw.Elapsed.TotalSeconds < 1);
	    }
	}

The last unit test was only to determine if this method was going to be performant enough for the scenario I wanted to use it in. You may want to remove it or mark it as explicit if you can to avoid timing issues affecting your test outcomes.

If anyone see's a bug, let me know!