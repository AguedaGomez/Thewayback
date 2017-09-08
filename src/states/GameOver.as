package states 
{
	import Core.Assets;
	import Core.Game;
	import flash.media.SoundChannel;
	import starling.events.Event;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.Sprite;
	

	public class GameOver extends Sprite implements IState 
	{
		private var bg:Image;
		private var game:Game;
		
		private var mjuggler:Juggler;
		private var musicd:SoundChannel;
		
		public function GameOver(game:Game) 
		{
			super();
			this.game = game;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			musicd = Assets.deathMusic.play();
			mjuggler = new Juggler();
			mjuggler.delayCall(this.ontime,30);
			
			bg = new Image(Assets.deathbgTexture);
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
			
			mjuggler.purge();
			
			musicd.stop();
			this.removeFromParent(true);
			
		}
		
	}

}