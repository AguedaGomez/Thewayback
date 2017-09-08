package Core 
{
	//import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets 
	{	//menu background
		[Embed(source = "../../Assets/fondoTitulo.png")]
		private static var welcomebg:Class;
		public static var welcomebgTexture:Texture;
		
		//map background
		[Embed(source = "../../Assets/map.png")]
		private static var mapbg:Class;
		public static var mapbgTexture:Texture;
		
		//level one background
		[Embed(source = "../../Assets/montfondo.png")]
		private static var montbg:Class;
		public static var montbgTexture:Texture;
		
		//level two background
		[Embed(source = "../../Assets/desifondo.png")]
		private static var desbg:Class;
		public static var desbgTexture:Texture;
		
		//level three background
		[Embed(source = "../../Assets/bosfondo.png")]
		private static var forestbg:Class;
		public static var forestbgTexture:Texture;
		
		//about background
		[Embed(source = "../../Assets/Aboutfondo.png")]
		private static var aboutbg:Class;
		public static var aboutbgTexture:Texture;
		
		//controls background
		[Embed(source = "../../Assets/controles.png")]
		private static var controlsbg:Class;
		public static var controlsbgTexture:Texture;
		
		[Embed(source = "../../Assets/death.png")]
		private static var deathbg:Class;
		public static var deathbgTexture:Texture;
		
		[Embed(source = "../../Assets/final scene.png")]
		private static var endbg:Class;
		public static var endbgTexture:Texture;
		
		[Embed(source="../../Assets/scene.png")]
		private static var stageAtlas:Class;
		[Embed(source="../../Assets/scene.xml", mimeType="application/octet-stream")]
		private static var stageAtlasXML:Class;
		public static var stageTextureAtlas:TextureAtlas;
		
		[Embed(source="../../Assets/sprites.png")]
		private static var SSAtlas:Class;
		[Embed(source="../../Assets/sprites.xml", mimeType = "application/octet-stream")]
		private static var SSAtlasXML:Class;
		public static var SSTextureAtlas:TextureAtlas;
		
		[Embed(source = "../../Assets/titulo.mp3")]
		private static var titleMusicSound:Class;
		public static var titleMusic:Sound;
		
		[Embed(source="../../Assets/lvl 1.mp3")]
		private static var lvl1MusicSound:Class;
		public static var lvl1Music:Sound;
		
		[Embed(source = "../../Assets/lvl 2.mp3")]
		private static var lvl2MusicSound:Class;
		public static var lvl2Music:Sound;
		
		[Embed(source = "../../Assets/lvl 3.mp3")]
		private static var lvl3MusicSound:Class;
		public static var lvl3Music:Sound
		
		[Embed(source = "../../Assets/muerte.mp3")]
		private static var deathMusicSound:Class;
		public static var deathMusic:Sound;
		
		/*[Embed(source="../../Assets/final.mp3")]
		private static var endMusicSound:Class;
		public static var endMusic:Sound;*/
		
		public static function init():void 
		{	//imagenes de fondo
			welcomebgTexture = Texture.fromBitmap(new welcomebg());
			mapbgTexture = Texture.fromBitmap(new mapbg());
			montbgTexture = Texture.fromBitmap(new montbg());
			desbgTexture = Texture.fromBitmap(new desbg());
			forestbgTexture = Texture.fromBitmap(new forestbg());
			aboutbgTexture = Texture.fromBitmap(new aboutbg());
			controlsbgTexture = Texture.fromBitmap(new controlsbg());
			deathbgTexture = Texture.fromBitmap(new deathbg());
			endbgTexture = Texture.fromBitmap(new endbg());
			
			
			titleMusic = new titleMusicSound();
			titleMusic.play(0, 0, new SoundTransform(0));
			
			lvl1Music = new lvl1MusicSound();
			lvl1Music.play(0, 0, new SoundTransform(0));
			
			lvl2Music = new lvl2MusicSound();
			lvl2Music.play(0, 0, new SoundTransform(0));
			
			lvl3Music = new lvl3MusicSound();
			lvl3Music.play(0, 0, new SoundTransform(0));
			
			deathMusic = new deathMusicSound();
			deathMusic.play(0, 0, new SoundTransform(0));
			

			//sprite sheets
			stageTextureAtlas = new TextureAtlas(Texture.fromBitmap(new stageAtlas()), XML(new stageAtlasXML()));
			
			SSTextureAtlas = new TextureAtlas(Texture.fromBitmap(new SSAtlas()), XML(new SSAtlasXML()));

		}
		
	}
}
