package states 
{
	import Core.Assets;
	import Core.Game;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	

	public class End extends Sprite implements IState 
	{
		private var bg:Image;
		private var game:Game;
		private var mjuggler:Juggler;
		
		
		public function End(game:Game) 
		
		{
			super();
			this.game = game;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			mjuggler = new Juggler();
			mjuggler.delayCall(this.ontime, 10);
			trace("Imagen del final");
			bg = new Image(Assets.endbgTexture);
			addChild(bg);
		}
		
		private function ontime():void 
		{
			trace("después del tiempo estimado");
			game.changeState("menu");
		}
		
		/* INTERFACE states.IState */
		
		public function update():void 
		{
			mjuggler.advanceTime(0.1);
		}
		
		public function destroy():void 
		{
			bg.removeFromParent(true);
			bg = null;
			
			this.removeFromParent(true);
			mjuggler.purge();
		}
		
	}

}