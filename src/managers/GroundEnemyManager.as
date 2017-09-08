package managers 
{
	import com.greensock.TweenLite;
	import Objects.GroundEnemy;
	import starling.core.Starling;
	import starling.display.Sprite;
	import states.Play;
	

	public class GroundEnemyManager extends Sprite 
	{
		private var play:Play;
		public var enemies:Array;
		public var groundEnemy:GroundEnemy;
		private var random:Number;
		
		public var numOnStage:int = 0;
		public var maxOnStage:int;
		public var maxLevel:int;
		
		public function GroundEnemyManager(play:Play) 
		{
			super();
			this.play = play;
			enemies = new Array();
			init();
			
		}
		
		private function init():void 
		{
			random = Math.ceil(Math.random() * 10)+5;
			Starling.juggler.delayCall( this.spawn , random);
			trace(" maxLevelGROUND1 = "+maxLevel);
		}
		
		private function spawn():void 
		{	
			trace(" maxLevelGROUND2 = "+maxLevel);
			if ( numOnStage < maxOnStage && maxLevel > 0) 
			{
				groundEnemy = new GroundEnemy(play);
				trace("aparecen enemigos");
				switch(play.level)
				{
					case 1:
						groundEnemy.x = 951;
						groundEnemy.y = 692;
						break;
					case 2:
						groundEnemy.x = 30;
						groundEnemy.y = 680;
						break;
					case 3:
						groundEnemy.x = 940;
						groundEnemy.y = 625;
						break;
				}
				
				
				
				enemies.push(groundEnemy);
				play.addChild(groundEnemy);
				++numOnStage;
				maxLevel--;
				trace(numOnStage, "en pantalla");
			
				
				random = Math.ceil(Math.random() * 5)+5;
				Starling.juggler.delayCall(this.spawn, random);
				
			}
		}
		
		public function update():void
		{
			//trace(" maxLevelGROUND1 = "+maxLevel);
			var e:GroundEnemy;
			for (var i:int = enemies.length-1; i >= 0; i--)
			{
				e = enemies[i];
				
				if(play.level==1 || play.level==3)
				{
						
					if (e.EnemyState == "left")
						e.scaleX = -1;
					if (e.EnemyState == "right")
						e.scaleX = 1;
				}
						
				else 
				{
					
					if (e.EnemyState == "left")
						e.scaleX = 1;
					if (e.EnemyState == "right")
						e.scaleX = -1;						
				}
						

						
				

				if (e.healthPoint == 0) {
					e.EnemyAnimation = "dead";
					if (e.currentAnimation.isComplete) {
						destroyEnemy(e);
					}
				}
					if (e.healthPoint == 0) 
					{
						e.dead = true;
						e.EnemyAnimation = "dead";
					if (e.currentAnimation.isComplete) {
						this.numOnStage--;
						play.numDeadEnemies++;
						destroyEnemy(e);
					}
				}
					
				e.update();
				
				if (play.hero.dead) {
					destroyEnemy(e); 
				}
			}
		}
		
		public function destroyEnemy(e:GroundEnemy):void
		{
			enemies.splice(e, 1);
			e.removeFromParent(true);
			
		}
		
		public function destroy():void
		{
			enemies = null;
		}
		
		
		
	}

}