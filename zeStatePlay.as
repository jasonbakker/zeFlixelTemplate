package
{
	import flash.desktop.ClipboardFormats;
	import flash.display.PixelSnapping;
	import flash.text.engine.BreakOpportunity;
	import flash.ui.ContextMenuBuiltInItems;
	import org.flixel.*;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.display.StageQuality;
 
	public class zeStatePlay extends FlxState
	{
		// [Embed(source = "../data/x.svg", mimeType = "application/octet-stream")]	private var m_xlDataClass:Class;
		// [Embed(source = "../data/x.png")] private var m_xImageClass:Class;
		
		public var m_uiGroup:FlxGroup 							= new FlxGroup();
		public var m_effectsGroup:FlxGroup 						= new FlxGroup();
		public var m_worldGroup:FlxGroup 						= new FlxGroup();
		
		override public function create():void
		{
			zeLD23Game.SetPlayState(this);
			
			add(m_worldGroup);
			add(m_effectsGroup);
			add(m_uiGroup);
			
			// FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, ProcessMouseDownEvent);
			// FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, ProcessMouseUpEvent);
			
		}
		
		override public function destroy():void
		{
			// FlxG.stage.removeEventListener(MouseEvent.MOUSE_DOWN, ProcessMouseDownEvent);
			// FlxG.stage.removeEventListener(MouseEvent.MOUSE_UP, ProcessMouseUpEvent);
			
			m_uiGroup = null;
			
			m_effectsGroup = null;
			
			m_worldGroup = null;
			
			super.destroy();
			
			zeLD23Game.SetPlayState(null);
		}
		
		override public function update():void
		{
			super.update();
			
			// FlxG.elapsed;
		}
		
		override public function render():void
		{
			super.render();
		}
		
		public function ProcessMouseDownEvent(event:MouseEvent):void
		{
			
		}
		
		public function ProcessMouseUpEvent(event:MouseEvent):void
		{
			
		}
	}
}