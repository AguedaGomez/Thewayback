package managers 
{
	import managers.GroundEnemyManager;
	import Objects.Coconut;
	import Objects.FlyingEnemy;
	import Objects.GroundEnemy;
	import Objects.Lance;
	import starling.display.Quad;
	import states.Play;

	public class CollisionManager 
	{
		private var play:Play;
		
		
		public function CollisionManager(play:Play) 
		{
			this.play = play;
		}
		
		public function update():void
		{
			lanceFlyingEnemy();
			lanceGroundEnemy();
			heroStoneSkullCoconut();
			heroFlyingEnemy();
			heroGroundEnemy();
		}
		
		private function lanceGroundEnemy():void 
		{
			var lances: Array = play.lanceManager.lances;
			var l:Lance;
			
			var enemies:Array = play.groundEnemyManager.enemies;
			var e:GroundEnemy;
			
			var lenL:int = lances.length;
			var lenE:int = enemies.length;
			

			
			for (var i:int = lenE-1; i >= 0; i--)
			{
				e = enemies[i];
				
				for (var j:int = lenL-1; j >= 0; j--)
				{
					l = lances[j];
					
					if (e.bounds.intersects(l.bounds))
					{
									
						if (e.healthPoint > 0)
							e.healthPoint--;
						
						e.EnemyAnimation = "injured";
						play.lanceManager.destroyLance(l);
						lenL--;
					}
				}
				
			}
			
		}
		
		private function heroGroundEnemy():void 
		{
			var hero:Quad = play.quadCaveman;
			var enemies:Array = play.groundEnemyManager.enemies;
			var e:GroundEnemy;
			
			for (var i:int = enemies.length-1; i >= 0; i--)
			{
				e = enemies[i];
				
				if (e.bounds.intersects(hero.bounds) && !e.dead)
				{
					if (hero.bounds.intersects(play.QuadFloor.bounds))
					{
						e.EnemyAnimation = "attack";
						play.hero.injured = true;
						
					}

					
				}
			}
		}
		
		private function heroStoneSkullCoconut():void 
		{
			var hero:Quad = play.quadCaveman;
			switch (play.level)
			{
				case 1:
					
					
					var stones: Array = play.stoneManager.stones;
					var s:Stone;
					
					for (var i:int = stones.length - 1; i >= 0; i--)
					{
						s = stones[i];
						
						if (s.bounds.intersects(hero.bounds))
						{
							play.stoneManager.destroyStone(s);
							play.hero.injured = true;
						}
					}
					break;
				
				case 2:
					
					var skulls: Array = play.skullManager.skulls;
					var sk:Skull;
					
					for (var j:int = skulls.length - 1; j >= 0; j--)
					{
						sk = skulls[j];
						
						if (sk.bounds.intersects(hero.bounds))
						{
							play.skullManager.destroySkull(sk);
							play.hero.injured = true;
						}
					}					
					break;
				
				case 3:
					
					var cocos: Array = play.cocoManager.cocos;
					var c:Coconut;
					
					for (var k:int = cocos.length - 1; k >= 0; k--)
					{
						c = cocos[k];
						
						if (c.bounds.intersects(hero.bounds))
						{
							play.cocoManager.destroyCoco(c);
							play.hero.injured = true;
						}
					}
					break;
			}

		}
		
		private function heroFlyingEnemy():void 
		{
			var hero:Quad = play.quadCaveman;
			
			var enemies:Array = play.flyingEnemyManager.enemies;
			var e:FlyingEnemy;
			
			for (var i:int = enemies.length-1; i >= 0; i--)
			{
				e = enemies[i];
				
				if (e.bounds.intersects(hero.bounds) && !e.dead)
				{
					play.hero.injured = true;
				}
			}
		}
		
		private function lanceFlyingEnemy():void 
		{
			var lances: Array = play.lanceManager.lances;
			var l:Lance;
			
			var enemies:Array = play.flyingEnemyManager.enemies;
			var e:FlyingEnemy;
			
			var lenL:int = lances.length;
			var lenE:int = enemies.length;
			
			for (var i:int = lenE-1; i >= 0; i--)
			{
				e = enemies[i];
				
				for (var j:int = lenL-1; j >= 0; j--)
				{
					l = lances[j];
					
					if (e.bounds.intersects(l.bounds))
					{
						if (e.healthPoint > 0)
							e.healthPoint--;
							
						e.EnemyAnimation = "injured";
						play.lanceManager.destroyLance(l);
						lenL--;
					}
				}
				
			}
		}
		
	}

}