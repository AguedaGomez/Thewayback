package states 
{
	import Core.Game;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import Core.Assets;
	import starling.display.Button;


	public class Others extends Sprite implements IState
	{
		public var game:Game;
		public var whatbutton:String;
		
		private var bg:Image;
		private var back:Button;
		

		
		
		public function Others(game:Game, whatbutton:String) 
		{
			super();
			this.game = game;
			this.whatbutton = whatbutton;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		/* INTERFACE states.IState */
		
		public function update():void 
		{
			
		}
		
		public function destroy():void 
		{
			bg.removeFromParent(true);
			bg = null;
			
			back.removeEventListener(Event.TRIGGERED, onback);
			back.removeFromParent(true);
			back = null;
			
			game.Whatbutton = null;
			
			this.removeFromParent(true);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			switch(whatbutton)
			{
				case "about":
					bg = new Image(Assets.aboutbgTexture);
					back = new Button(Assets.SSTextureAtlas.getTexture("back about"));
					back.x = 435;
					back.y = 80;
					addChild(bg);
					addChild(back);
					back.addEventListener(Event.TRIGGERED, onback);
					break;
				case "controls":
					bg = new Image(Assets.controlsbgTexture);
					back = new Button(Assets.SSTextureAtlas.getTexture("back n 1"));
					back.x = 797;
					addChild(bg);
					addChild(back);
					back.addEventListener(Event.TRIGGERED, onback);
					break;
				default:
					break;
			}
			
			

		}
		
		
		private function onback(e:Event):void 
		{
			game.changeState("menu");
		}
		
	}

}