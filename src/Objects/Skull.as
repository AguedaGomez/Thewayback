package Objects 
{
	import Core.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Skull extends Sprite 
	{
		private var s:Image;
		
		public function Skull() 
		{
			super();
			s = new Image(Assets.SSTextureAtlas.getTexture("skull"));
			pivotX = s.width * 0.5;
			pivotY = s.height * 0.5;
			addChild(s);
			
		}
		
	}

}