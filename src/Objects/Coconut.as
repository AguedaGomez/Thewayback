package Objects 
{

	import Core.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Coconut extends Sprite 
	{
		private var c:Image;
		
		public function Coconut() 
		{
			c = new Image(Assets.SSTextureAtlas.getTexture("coco"));
			pivotX = c.width * 0.5;
			pivotY = c.height * 0.5;
			addChild(c);
			
		}
		
	}

}