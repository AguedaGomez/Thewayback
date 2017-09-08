package Objects 
{
	import Core.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	

	public class Lance extends Sprite 
	{
		private var lance:Image;
		public var direction:String;
		
		public function Lance() 
		{
			super();
			lance = new Image(Assets.SSTextureAtlas.getTexture("lance"));
			pivotX = lance.width * 0.5;
			pivotY = lance.height * 0.5;
			addChild(lance);
		}
		
		
		
	}

}