package managers 
{
	import states.Play;
	import Objects.Lance;
	public class LanceManager 
	{
		private var play:Play;
		public var lances:Array;
		private var lancepool:Pool;
		private var cavemanState: String;
		
		
		public function LanceManager(play:Play) 
		{
			this.play = play;
			lances = new Array();
			lancepool = new Pool(Lance, 30);
			
		}
		
		public function spawn(posx:int, posy:int, cavemanState:String):void
		{
			var l:Lance = lancepool.getSprite() as Lance;
			l.direction = cavemanState;
			if (l.direction == "right") 
			{
				l.x = posx;
				l.y = posy - play.hero.height * 0.2;
				
				l.scaleX = 1;
			}
			if (l.direction == "left")
			{
				l.x = posx - play.hero.width * 0.5;
				l.y = posy - play.hero.height * 0.2;
				
				l.scaleX = -1;
			}
			lances.push(l);
			
			this.cavemanState = cavemanState;


			play.addChild(l);
		}
		
		public function destroyLance(l:Lance):void
		{
			for (var i:int =0; i < lances.length; i++)
			{
				if (lances[i] == l) 
				{
					lances.splice(i, 1);
					l.removeFromParent(true);
					lancepool.returnSprite(l);
				}
			}

			
		}
		
		public function update():void
		{
			var l:Lance;
			if (lances != null)
			{
			
				for (var i:int = lances.length -1; i >= 0; i--)
				{
				l = lances[i];
				
				if (l.direction == "right")
				{
					l.x += 20;
					if (l.x > 1024 + l.width * 0.5)
						destroyLance(l);
				}

				
				if (l.direction == "left")
				{
					l.x -= 20;
					if (l.x < 0 - l.width * 0.5)
						destroyLance(l);
				}
				

				}
			}

			
		}
		
		public function destroy():void
		{
			
 			lancepool.destroy();
			lancepool = null;
			lances = null;
			
		}
	}

}