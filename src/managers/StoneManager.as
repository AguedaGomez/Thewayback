package managers 
{
	import Objects.Stone;
	import states.Play;

	
	
	public class StoneManager 
	{
		private var play:Play;
		public var stones:Array;
		private var stonepool:Pool;
		
		
		
		public function StoneManager(play:Play) 
		{
			this.play = play;
			stones = new Array();
			stonepool = new Pool(Stone, 10);
		}
		
		public function spawn(posx:int, posy:int):void
		{
			if (stonepool != null) {
				
			
			var s:Stone = stonepool.getSprite() as Stone;
			
			
			
			s.x = posx;
			s.y = posy;
				
			stones.push(s);


			play.addChild(s);
			}
		}
		
		
				
		public function destroyStone(s:Stone):void
		{
			for (var i:int =0; i < stones.length; i++)
			{
				if (stones[i] == s) 
				{
					stones.splice(i, 1);
					s.removeFromParent(true);
					stonepool.returnSprite(s);
				}
			}

			
		}
		
		public function update():void
		{
			var s:Stone;
			
			for (var i:int = stones.length -1; i >= 0; i--)
			{
				s = stones[i];
				
				s.y += 5;
				
				if (s.y >= 700)
					destroyStone(s);
				

			}
			
		}
		
		public function destroy():void
		{
			stonepool.destroy();
			stonepool = null;
			stones = null;
			
		}
	}

}