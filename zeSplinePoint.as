package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	/**
	 * ...
	 * @author Jason Bakker
	 */
	public class zeSplinePoint extends FlxPoint
	{
		private var m_preInfluencePoint:FlxPoint = new FlxPoint();
		private var m_postInfluencePoint:FlxPoint = new FlxPoint();
		public function zeSplinePoint(X:Number = 0, Y:Number = 0) 
		{
			super(X, Y);
		}
		
		public function SetPreInfluencePoint(point:FlxPoint):void
		{
			m_preInfluencePoint = point;
		}
		
		public function SetPostInfluencePoint(point:FlxPoint):void
		{
			m_postInfluencePoint = point;
		}
		
		public function GetPreInfluencePoint():FlxPoint
		{
			return m_preInfluencePoint;
		}
		
		public function GetPostInfluencePoint():FlxPoint
		{
			return m_postInfluencePoint;
		}
	}

}