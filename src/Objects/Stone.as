package Objects 
{
	import Core.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	

	public class Stone extends Sprite 
	{
		private var s:Image;
		
		public function Stone() 
		{
			super();
			s = new Image(Assets.SSTextureAtlas.getTexture("rock"));
			pivotX = s.width * 0.5;
			pivotY = s.height * 0.5;
			addChild(s);
		}
		
	
		
	}

}