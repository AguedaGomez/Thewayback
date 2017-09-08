package managers 
{
	import flash.display.InteractiveObject;
	import Objects.FlyingEnemy;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import states.Play;
	import com.greensock.TweenLite;
	

	public class FlyingEnemiesManager 
	{
		private var play:Play;
		public var enemies:Array;
		public var flyingEnemy:FlyingEnemy;
		private var random:Number;
		
		public var numOnStage:int = 0;
		public var maxOnStage:int;
		public var maxLevel:int;
		
		
		
		public function FlyingEnemiesManager(play:Play) 
		{
			super();
			this.play = play;
			enemies = new Array();
			init();
			
		}
		
		private function init():void 
		{
			random = Math.ceil(Math.random() * 10);
			
			Starling.juggler.delayCall(this.spawn, random);
			
		}
		
		private function spawn():void
		{
			
			if ( numOnStage < maxOnStage && maxLevel>0) 
			{
				
				
				flyingEnemy = new FlyingEnemy(play);
				flyingEnemy.x = 512;
				flyingEnemy.y = -100;
				enemies.push(flyingEnemy);
				play.addChild(flyingEnemy);
				++numOnStage;
				maxLevel--;
				TweenLite.to(flyingEnemy, 2, { x:Math.ceil(Math.random() * 500) + 60, y:Math.ceil(Math.random() * 100) + 60 } );
				random = Math.ceil(Math.random() * 20)+10;
				Starling.juggler.delayCall(this.spawn, random);
				
			}

			

			
			
		}
		
		public function update():void
		{
			var e:FlyingEnemy;

				for (var i:int = enemies.length-1; i >= 0; i--)
				{	
					
					e = enemies[i];
					if (e.EnemyState == "left")
						e.scaleX = 1;
					if (e.EnemyState == "right")
						e.scaleX = -1;
					if (e.healthPoint == 0) {
						e.dead = true;
						e.EnemyAnimation = "dead";
						if (e.currentAnimation.isComplete) {
							numOnStage--;
							//maxLevel--;
							play.numDeadEnemies++;
							destroyEnemy(e);
						}
					}
					e.update();
				
				}

					
		}
		
		public function destroyEnemy(e:FlyingEnemy):void
		{
			enemies.splice(e, 1);
			e.removeFromParent(true);
			
		}
		
		public function destroy():void
		{
			enemies = null;
			Starling.juggler.purge();
			
		}
		

		
		
		
	}

}