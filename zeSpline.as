package  
{
	import adobe.utils.CustomActions;
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	public class zeSpline extends FlxObject
	{
		private var m_pointArray:Array = new Array();
		
		public function zeSpline() 
		{
			
		}
		
		// this only loads a very specific svg file
		public function LoadFromSVG(svgXML:XML):void
		{
			var svgNs:Namespace = new Namespace("http://www.w3.org/2000/svg");
			
			var pathString:String = svgXML.svgNs::g.svgNs::path.@d;
			// trace("pathString = " + pathString);
			
			var pathArray:Array = pathString.split(" ");
			var currPoint:zeSplinePoint = null;
			var pointIdx:int = 0;
			var firstPoint:Boolean = true;
			var anchorPoint:FlxPoint = new FlxPoint();
			var relative:Boolean = false;
			for each(var pathWord:String in pathArray)
			{
				if (pathWord == "M")
				{
					relative = false;
				}
				else if (pathWord == "m")
				{
					relative = true;
				}
				else if (pathWord == "C")
				{
					relative = false;
				}
				else if (pathWord == "c")
				{
					relative = true;
				}
				else
				{
					var pointArray:Array = pathWord.split(",");
					var flxPoint:FlxPoint = new FlxPoint(parseFloat(pointArray[0]), parseFloat(pointArray[1]));
					
					if (relative)
					{
						flxPoint.x += anchorPoint.x;
						flxPoint.y += anchorPoint.y;
					}
					
					if (!currPoint)
					{
						currPoint = new zeSplinePoint();
						m_pointArray.push(currPoint);
					}
					if (pointIdx == 0)
					{
						currPoint.SetPreInfluencePoint(flxPoint);
						++pointIdx;
						
						if (firstPoint)
						{
							currPoint.x = flxPoint.x;
							currPoint.y = flxPoint.y;
							++pointIdx;
						
							anchorPoint = flxPoint;
							firstPoint = false;
						}
					}
					else if(pointIdx == 1)
					{
						currPoint.x = flxPoint.x;
						currPoint.y = flxPoint.y;
						
						anchorPoint = flxPoint;
						
						currPoint.SetPostInfluencePoint(flxPoint); // in case this is the last point in the whole path
						
						++pointIdx;
					}
					else if (pointIdx == 2)
					{
						currPoint.SetPostInfluencePoint(flxPoint);
						
						pointIdx = 0;
						currPoint = null;
					}
				}
			}
		}
		
		public function AddPoint(point:zeSplinePoint):void
		{
			m_pointArray.push(point);
		}
		
		public function RemovePoint(pointIdx:int):void
		{
			m_pointArray.splice(pointIdx, 1);
		}
		
		public function GetPoint(pointIdx:int):zeSplinePoint
		{
			return m_pointArray[pointIdx];
		}
		
		public function GetBezierPointAlongSpline(pointIdx:int, percent:Number):FlxPoint
		{
			var returnPoint:FlxPoint = new FlxPoint();
			if (m_pointArray.length == 0)
			{
				return returnPoint;
			}
			if (pointIdx < 0)
			{
				returnPoint.x = m_pointArray[0].x + this.x;
				returnPoint.y = m_pointArray[0].y + this.y;
				return returnPoint;
			}
			if (pointIdx >= (m_pointArray.length - 1))
			{
				returnPoint.x = m_pointArray[m_pointArray.length - 1].x + this.x;
				returnPoint.y = m_pointArray[m_pointArray.length - 1].y + this.y;
				return returnPoint;
			}
			var point1:zeSplinePoint = m_pointArray[pointIdx];
			var infPoint1:FlxPoint = point1.GetPostInfluencePoint();
			var point2:zeSplinePoint = m_pointArray[pointIdx + 1];
			var infPoint2:FlxPoint = point2.GetPreInfluencePoint();
			var oneMinusPercent:Number = (1.0 - percent);
			var oneMinusPercentSq:Number = oneMinusPercent * oneMinusPercent;
			var oneMinusPercentCu:Number = oneMinusPercent * oneMinusPercent * oneMinusPercent;
			
			var percentSq:Number = percent * percent;
			var percentCu:Number = percent * percent * percent;
			
			// Bx(t) = (1 - t)3  x P1x + 3 x (1 - t)2 x t x P2x + 3 x (1 - t) x t2 x P3x + t3 x P4x 
			// By(t) = (1 - t)3  x P1y + 3 x (1 - t)2 x t x P2y + 3 x (1 - t) x t2 x P3y + t3 x P4y
			
			returnPoint.x = oneMinusPercentCu * point1.x + 3 * oneMinusPercentSq * percent * infPoint1.x + 3 * oneMinusPercent * percentSq * infPoint2.x + percentCu * point2.x;
			returnPoint.y = oneMinusPercentCu * point1.y + 3 * oneMinusPercentSq * percent * infPoint1.y + 3 * oneMinusPercent * percentSq * infPoint2.y + percentCu * point2.y;
			
			returnPoint.x += this.x;
			returnPoint.y += this.y;
			
			return returnPoint;
		}
		
		public function GetDistanceOfPositionAlongSpline(position:FlxPoint):Number
		{
			for (var i:int = 0; i < m_pointArray.length; ++i)
			{
				if ((this.x + m_pointArray[i].x) > position.x)
				{
					if (i > 0)
					{
						return (i - 1) + ((position.x - (this.x + m_pointArray[i - 1].x)) / (m_pointArray[i].x - m_pointArray[i - 1].x));
					}
					return 0;
				}
			}
			
			return m_pointArray.length;
		}
		
		public function GetPointCount():int
		{
			return m_pointArray.length;
		}
	}
}