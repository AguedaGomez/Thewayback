package states 
{
	import com.greensock.TweenLite;
	import Core.Game;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.core.Starling;
	
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.display.Sprite;
	
	import Core.Assets;
	

	public class Menu extends Sprite implements IState
	{
		
		private var bg:Image;
		private var titlerock:Image;
		private var heroruns:Image;
		private var dino:Image;
		private var ptero:Image;
		
		private var playBtn:Button;
		private var ctrlBtn:Button;
		private var aboutBtn:Button;
		
		private var game:Game;
		
		private var ns:Stage;
		private var music:SoundChannel;
		
		
		public function Menu(game:Game) 
		{
			super();
			this.game = game;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		

		
		private function onAddedToStage(e:Event):void 
		{
			trace("pantalla de menu");
			
			
			
			
			bg = new Image(Assets.welcomebgTexture);
			addChild(bg);
			
			ptero = new Image(Assets.stageTextureAtlas.getTexture("pteroTitulo"));
			ptero.x = 1024;
			ptero.y = -150;
			addChild(ptero);
			TweenLite.to(ptero, 3, { x:255, y:9 } );
			
			titlerock = new Image(Assets.stageTextureAtlas.getTexture("piedraTitulo"));
			titlerock.x = 88;
			titlerock.y = 71;
			addChild(titlerock);
			
			
			heroruns = new Image(Assets.stageTextureAtlas.getTexture("pjTitulo"));
			heroruns.x = 464;
			heroruns.y = 167;
			addChild(heroruns);
			
			
			dino = new Image(Assets.stageTextureAtlas.getTexture("dinoTitulo"));
			dino.x = -100
			dino.y = 65;
			addChild(dino);
			TweenLite.to(dino, 1, { x:0, y:65 } );
			
			aboutBtn = new Button(Assets.SSTextureAtlas.getTexture("about"));
			aboutBtn.x = 836;
			aboutBtn.y = -160;
			addChild(aboutBtn);
			TweenLite.to(aboutBtn, 2.5, { x:836, y:305 } );

			ctrlBtn = new Button(Assets.SSTextureAtlas.getTexture("cntrls"));
			ctrlBtn.x = 836;
			ctrlBtn.y = -150;
			addChild(ctrlBtn);
			TweenLite.to(ctrlBtn, 3, { x:836, y:149 } );
			
			playBtn = new Button(Assets.SSTextureAtlas.getTexture("play"));
			playBtn.x = 836;
			playBtn.y = -100;
			addChild(playBtn);
			TweenLite.to(playBtn, 1, { x:836, y:0 } );
			
			playBtn.addEventListener(Event.TRIGGERED, onplaybutton);
			aboutBtn.addEventListener(Event.TRIGGERED, onaboutbutton);
			ctrlBtn.addEventListener(Event.TRIGGERED, onctrlbutton);
			
			//para recoger las coordenadas del raton
			ns = Starling.current.nativeStage;
			
			ns.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			//removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onctrlbutton(e:Event):void 
		{
			game.Whatbutton = "controls";
			game.changeState("others");
		}
		
		private function onaboutbutton(e:Event):void 
		{
			game.Whatbutton = "about";
			game.changeState("others");
		}
		
		private function onplaybutton(e:Event):void 
		{
			trace("pulsado boton play");
			game.changeState("map");
		}
		
		private function onDown(e:MouseEvent):void 
		{
			trace(ns.mouseX, ns.mouseY); 
		}
		
		/* INTERFACE states.IState */
		
		public function update():void 
		{
			
		}
		
		public function destroy():void 
		{
			bg.removeFromParent(true);
			bg = null;
			
			ptero.removeFromParent(true);
			ptero = null;
			
			titlerock.removeFromParent(true);
			titlerock = null;
			
			heroruns.removeFromParent(true);
			heroruns = null;
			
			dino.removeFromParent(true);
			dino = null;
			
			aboutBtn.removeFromParent(true);
			aboutBtn = null;
			
			playBtn.removeFromParent(true);
			playBtn = null;

			ctrlBtn.removeFromParent(true);
			ctrlBtn = null;
			
			
			
			//ns.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			this.removeFromParent(true);
			
		}
		
	}

}