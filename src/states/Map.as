package states 
{
	import Core.Game;
	import starling.animation.Juggler;
	import com.greensock.TweenLite;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import Core.Assets;
	

	public class Map extends Sprite implements IState
	{
		
		private var bg:Image;
		private var pj:Image;
		
		private var game:Game;
		private var level:int;
		
		private var mjuggler:Juggler;
		
		public function Map(game:Game, level:int)  
		{
			super();
			this.level = level;
			this.game = game;
			trace("dentro de map");
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			//removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			mjuggler = new Juggler();
			mjuggler.delayCall(this.ontime,7);
			
			bg = new Image(Assets.mapbgTexture);
			addChild(bg);
			
			pj = new Image(Assets.stageTextureAtlas.getTexture("pjmap"));
			
			switch(level)
			{
				case 1:
					pj.x = 145;
					pj.y = 195;
					break;
				case 2:
					pj.x = 145;
					pj.y = 195;
					TweenLite.to(pj, 1, { x:290, y:295 } );
					break;
				case 3:
					pj.x = 290;
					pj.y = 295;
					TweenLite.to(pj, 1, { x:604, y:266 } );
					break;
				case 4:
					pj.x = 604;
					pj.y= 266;
					TweenLite.to(pj, 1, { x:728, y:532});
					break;
				default:
					break;
			}
			addChild(pj);
			
			
			
			trace("se muestra la imagen de mapa");
		}
		
		private function ontime():void 
		{
			trace("después del tiempo estimado");
			if (level == 4)
				game.changeState("end");
			else
				game.changeState("play");
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
			
			pj.removeFromParent(true);
			pj = null;
			
			mjuggler.purge();
			this.removeFromParent(true);
			
		}
		
	}

}