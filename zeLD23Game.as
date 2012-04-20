package
{
	import flash.display.ColorCorrection;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width = "800", height = "600", backgroundColor = "#FFFFFF")] //Set the size and color of the Flash file
	[Frame(factoryClass="zePreloader")] //Tells Flixel to use the default preloader
 
	public class zeLD23Game extends FlxGame
	{
		static private var m_playState:zeStatePlay = null;
		
		public function zeLD23Game()
		{
			super(800, 600, zeStatePlay, 1);
		}
		
		static public function SetPlayState(playState:zeStatePlay):void
		{
			m_playState = playState;
		}
		
		static public function GetPlayState():zeStatePlay
		{
			return m_playState;
		}
	}
}