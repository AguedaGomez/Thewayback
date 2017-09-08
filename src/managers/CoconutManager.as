package managers 
{
	import Objects.Coconut;
	import states.Play;

	public class CoconutManager 
	{
		private var play:Play;
		public var cocos:Array;
		private var cocopool:Pool;
		
		public function CoconutManager(play:Play) 
		{
			this.play = play;
			cocos = new Array();
			cocopool = new Pool(Coconut, 10);
			
		}
		
		public function spawn(posx:int, posy:int):void
		{
			if (cocopool != null) {
				
			
			var c:Coconut = cocopool.getSprite() as Coconut;
			
			
			
			c.x = posx;
			c.y = posy;
				
			cocos.push(c);


			play.addChild(c);
			}
		}
		
		
				
		public function destroyCoco(c:Coconut):void
		{
			for (var i:int =0; i < cocos.length; i++)
			{
				if (cocos[i] == c) 
				{
					cocos.splice(i, 1);
					c.removeFromParent(true);
					cocopool.returnSprite(c);
				}
			}

			
		}
		
		public function update():void
		{
			var c:Coconut;
			
			for (var i:int = cocos.length -1; i >= 0; i--)
			{
				c = cocos[i];
				
				c.y += 5;
				
				if (c.y >= 700)
					destroyCoco(c);
				

			}
			
		}
		
		public function destroy():void
		{
			cocopool.destroy();
			cocopool = null;
			cocos = null;
			
		}
		
	}

}