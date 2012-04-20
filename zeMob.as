package  
{
	import flash.ui.ContextMenuBuiltInItems;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Jason Bakker
	 */
	public class zeMob extends FlxSprite 
	{
		protected var m_radius:Number = 1.0;
		
		public static var STATE_NONE:int	= 0;
		
		protected var m_stateTimer:Number = 0.0;
		protected var m_state:int = -1;
		
		public function zeMob(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			m_radius = Math.max(width, height) * 0.5;
			health = 1;
			
			// default to center objects
			offset = new FlxPoint(width * 0.5, height * 0.5);
			origin = new FlxPoint(width * 0.5, height * 0.5);
			
			ChangeState(STATE_NONE);
		}
		
		override public function update():void
		{
			super.update();
			
			m_stateTimer += FlxG.elapsed;
			
			UpdateState();
		}
		
		public function UpdateState():void
		{
			switch(m_state)
			{
				case STATE_NONE:
				{
					OnUpdateNone();
				}
				break;
			default:
				break;
			}
		}
		
		public function GetState():int
		{
			return m_state;
		}
		
		public function IsCurrentState(stateID:int):Boolean
		{
			return m_state == stateID;
		}
		
		public function CurrStateEnter():void
		{
			switch(m_state)
			{
				case STATE_NONE:
					OnEnterNone();
					break;
				default:
					break;
			}
		}
		
		public function CurrStateExit():void
		{
			switch(m_state)
			{
				case STATE_NONE:
					OnExitNone();
					break;
				default:
					break;
			}
		}
		
		public function ChangeState(newState:int):void
		{
			CurrStateExit();
			m_state = newState;
			m_stateTimer = 0;
			CurrStateEnter();
		}
		
		public function OnEnterNone():void
		{
			
		}
		
		public function OnUpdateNone():void
		{
			
		}
		
		public function OnExitNone():void
		{
			
		}
		
		public function overlapsMob(mob:zeMob):Boolean
		{
			var myPoint:FlxPoint = getCollisionCenter();
			var theirPoint:FlxPoint = mob.getCollisionCenter();
			var distanceSq:Number = (theirPoint.subtract(myPoint)).lengthSq();
			var radiusSq:Number = (m_radius * m_radius) + (mob.m_radius * mob.m_radius);
			if (distanceSq < radiusSq)
			{
				return true;
			}
			
			return false;
		}
		
		public function radiusOverlapsPoint(point:FlxPoint):Boolean
		{
			var myPoint:FlxPoint = getCollisionCenter();
			var distanceSq:Number = (point.subtract(myPoint)).lengthSq();
			var radiusSq:Number = (m_radius * m_radius);
			if (distanceSq < radiusSq)
			{
				return true;
			}
			
			return false;
		}
		
		public function getCollisionCenter():FlxPoint
		{
			var radAngle:Number = angle * (Math.PI / 180.0);
			var cosRadAngle:Number = Math.cos(radAngle);
			var sinRadAngle:Number = Math.sin(radAngle);
			var rightVec:FlxPoint = new FlxPoint(cosRadAngle, sinRadAngle);
			var upVec:FlxPoint = new FlxPoint( -rightVec.y, rightVec.x);
			var collCenter:FlxPoint = new FlxPoint(x, y);
			collCenter = collCenter.add(rightVec.mult(width * 0.5));
			collCenter = collCenter.add(upVec.mult(height * 0.5));
			// var collCenter:FlxPoint = new FlxPoint(x + (width * 0.5) * xAmount, y + (height * 0.5) * yAmount);
			collCenter = collCenter.subtract(rightVec.mult(offset.x));
			collCenter = collCenter.subtract(upVec.mult(offset.y));
			return collCenter;
		}
		
		public function GetRadius():Number
		{
			return m_radius;
		}
	}

}