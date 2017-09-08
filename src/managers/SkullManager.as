package managers 
{
	import Objects.Skull;
	import states.Play;

	public class SkullManager 
	{
		private var play:Play;
		public var skulls:Array;
		private var skullpool:Pool;
		
		public function SkullManager(play:Play) 
		{
			this.play = play;
			skulls = new Array();
			skullpool = new Pool(Skull, 10);
			
		}
		
		public function spawn(posx:int, posy:int):void
		{
			if (skullpool != null) {
				
			
			var s:Skull = skullpool.getSprite() as Skull;
			
			
			
			s.x = posx;
			s.y = posy;
				
			skulls.push(s);


			play.addChild(s);
			}
		}
		
		
				
		public function destroySkull(s:Skull):void
		{
			for (var i:int =0; i < skulls.length; i++)
			{
				if (skulls[i] == s) 
				{
					skulls.splice(i, 1);
					s.removeFromParent(true);
					skullpool.returnSprite(s);
				}
			}

			
		}
		
		public function update():void
		{
			var s:Skull;
			
			for (var i:int = skulls.length -1; i >= 0; i--)
			{
				s = skulls[i];
				
				s.y += 5;
				
				if (s.y >= 700)
					destroySkull(s);
				

			}
			
		}
		
		public function destroy():void
		{
			skullpool.destroy();
			skullpool = null;
			skulls = null;
			
		}
		
	}

}