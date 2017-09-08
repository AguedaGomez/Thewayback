package Core
{

	import Core.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;

	

	public class Main extends Sprite 
	{
		
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);

		
		}
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var mstarling:Starling = new Starling(Game, stage);
			mstarling.showStats = true;
			mstarling.antiAliasing = 1;
			mstarling.start();
		}
		
		
		
	}
	
}