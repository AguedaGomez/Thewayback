package states 
{
	import Core.Game;
	import flash.media.SoundChannel;
	import managers.CoconutManager;
	import managers.FlyingEnemiesManager;
	import managers.GroundEnemyManager;
	import managers.LanceManager;
	import managers.SkullManager;
	import managers.StoneManager;
	import Objects.caveman;
	import managers.CollisionManager;
	import Objects.FlyingEnemy;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import Core.Assets;
	import starling.display.Quad;
	import com.greensock.TweenLite;
	
	public class Play extends Sprite implements IState
	{
		public var game:Game;
		public var level:int;
		
		public var hero:caveman;
		public var lanceManager:LanceManager;
		public var flyingEnemyManager:FlyingEnemiesManager;
		public var groundEnemyManager:GroundEnemyManager;
		private var checkCollides:CollisionManager;
		public var stoneManager:StoneManager;
		public var skullManager:SkullManager;
		public var cocoManager:CoconutManager;
		
		
		private var background:Image;
		private var platformFloor:Image;
		public var leftPlatform:Image;
		public var rightPlatform:Image;
		
		private var vine1:Image;
		private var vine2:Image;
		
		private var levelDays:Image;
		private var healthPoints:Image;
		
		//Quads used to collides, left to the right
		public var Quad1:Quad;
		public var Quad2:Quad;
		public var Quad3:Quad;
		public var Quad4:Quad;
		public var Quad5:Quad;
		public var QuadFloor:Quad;
		
		public var quadCaveman:Quad;
		
		private var levelComplete:int;
		public var numDeadEnemies:int = 0;
		
		private	var destruir:int = 0;
		private var music:SoundChannel;
		private var music3:SoundChannel;
		public var current_healthpoints:int;
		
		
		
		
		public function Play(game:Game, level:int) 
		{
			super();
			this.game = game;
			this.level = level;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			lanceManager = new LanceManager(this);
			
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			switch(level)
			{
				case 1:
					trace("case1");
					
					music = Assets.lvl1Music.play();
					
					background = new Image(Assets.montbgTexture);
					addChild(background);
					
					platformFloor = new Image(Assets.stageTextureAtlas.getTexture("montsuelo"));
					platformFloor.y = 768 - platformFloor.height;
					addChild(platformFloor);
					
					leftPlatform = new Image(Assets.stageTextureAtlas.getTexture("montplataformaizqu"));
					leftPlatform.x = -1;
					leftPlatform.y = 323;
					addChild(leftPlatform);
					
					rightPlatform = new Image(Assets.stageTextureAtlas.getTexture("montplataformaderecha"));
					rightPlatform.x = 771;
					rightPlatform.y = 259;
					addChild(rightPlatform);
					
					levelDays = new Image(Assets.SSTextureAtlas.getTexture("dia1"));
					levelDays.x = 1024 - levelDays.width;
					addChild(levelDays);
					
					Quad2 = new Quad(37, 1, 0x000000);
					Quad2.x = 178;
					Quad2.y = 662;
					Quad2.alpha = 0;
					addChild(Quad2);
					
					Quad3 = new Quad(32, 1, 0x000000);
					Quad3.x = 216;
					Quad3.y = 695;
					Quad3.alpha = 0;
					addChild(Quad3);
					
					Quad4 = new Quad(40, 1, 0x000000);
					Quad4.x = 808;
					Quad4.y = 679;
					Quad4.alpha = 0;
					addChild(Quad4);
					
					Quad5 = new Quad(43, 1, 0x000000);
					Quad5.x = 873;
					Quad5.y = 621;
					Quad5.alpha = 0;
					addChild(Quad5);
					
					QuadFloor = new Quad(1024, 1, 0x000000);
					QuadFloor.y = 740;
					QuadFloor.alpha = 0;
					addChild(QuadFloor);
					
					quadCaveman = new Quad(30, 121, 0x000000);
					quadCaveman.pivotX = quadCaveman.width * 0.5;
					quadCaveman.pivotY = quadCaveman.height * 0.5;
					//quadCaveman.alpha = 0;
					
					
					
					levelComplete = 6; //CAMBIAR A 6
					
					stoneManager = new StoneManager(this);
					flyingEnemyManager = new FlyingEnemiesManager(this);
					flyingEnemyManager.maxLevel = 4; 
					flyingEnemyManager.maxOnStage = 2; 
					
					groundEnemyManager = new GroundEnemyManager(this);
					groundEnemyManager.maxLevel = 2; 
					groundEnemyManager.maxOnStage = 1; 
					
					hero = new caveman(this);
					hero.x = 498 ;
					hero.y = 679;
					

					addChild(hero);
					
					break;
				case 2:
					
					music = Assets.lvl2Music.play();
					background = new Image(Assets.desbgTexture);
					addChild(background);
					
					platformFloor = new Image(Assets.stageTextureAtlas.getTexture("desisuelo"));
					platformFloor.y = 768 - platformFloor.height;
					addChild(platformFloor);
					
					leftPlatform = new Image(Assets.stageTextureAtlas.getTexture("desiplataforma"));
					leftPlatform.x = 396;
					leftPlatform.y = 522;
					addChild(leftPlatform);
					
					levelDays = new Image(Assets.SSTextureAtlas.getTexture("dia2"));
					levelDays.x = 1024 - levelDays.width;
					addChild(levelDays);
					
					Quad1 = new Quad(30, 1, 0x000000);
					Quad1.x = 489;
					Quad1.y = 530;
					Quad1.alpha = 0;
					addChild(Quad1);
				
					Quad2 = new Quad(30, 1, 0x000000);
					Quad2.x = 552;
					Quad2.y = 583; //590?
					Quad2.alpha = 0;
					addChild(Quad2);
					
					Quad3 = new Quad(53, 1, 0x000000);
					Quad3.x = 584;
					Quad3.y = 628;
					Quad3.alpha = 0;
					addChild(Quad3);
					
					QuadFloor = new Quad(1024, 1, 0x000000);
					QuadFloor.y = 714;
					QuadFloor.alpha = 0;
					addChild(QuadFloor);
					
					hero = new caveman(this);
					hero.x = 512;
					hero.y = 653;

					addChild(hero);
					
					quadCaveman = new Quad(30, 121, 0x000000);
					quadCaveman.pivotX = quadCaveman.width * 0.5;
					quadCaveman.pivotY = quadCaveman.height * 0.5;
					quadCaveman.alpha = 0;
					quadCaveman.x = hero.x;
					quadCaveman.y = hero.y;
					addChild(quadCaveman);
					
					
					
					levelComplete = 10;
					skullManager = new SkullManager(this);
					
					flyingEnemyManager = new FlyingEnemiesManager(this);
					flyingEnemyManager.maxLevel = 5;
					flyingEnemyManager.maxOnStage = 3;
					
					groundEnemyManager = new GroundEnemyManager(this);
					groundEnemyManager.maxLevel = 5;
					groundEnemyManager.maxOnStage = 3;
					
					trace("groundEnemyManager.maxLevel = " + groundEnemyManager.maxLevel + "  groundEnemyManager.maxOnStage = " + groundEnemyManager.maxOnStage);
					
					
					break;
					

					
				case 3:
					
					music = Assets.lvl3Music.play();
					background = new Image(Assets.forestbgTexture);
					addChild(background);
					
					platformFloor = new Image(Assets.stageTextureAtlas.getTexture("bosqsuerto"));
					platformFloor.y = 768 - platformFloor.height;
					addChild(platformFloor);
					
					leftPlatform = new Image(Assets.stageTextureAtlas.getTexture("bosplataforma2"));
					leftPlatform.y = 483;
					addChild(leftPlatform);
					
					rightPlatform = new Image(Assets.stageTextureAtlas.getTexture("bosplataforma1"));
					rightPlatform.x = 393;
					rightPlatform.y = 585;
					addChild(rightPlatform);
					
					vine1 = new Image(Assets.stageTextureAtlas.getTexture("liana1"));
					vine1.x =200;
					addChild(vine1);
					
					levelDays = new Image(Assets.SSTextureAtlas.getTexture("dia3"));
					levelDays.x = 1024 - levelDays.width;
					addChild(levelDays);
					
					Quad1 = new Quad(139, 1, 0x000000);
					Quad1.y = 521;
					Quad1.alpha = 0;
					addChild(Quad1);
				
					Quad2 = new Quad(120, 1, 0x000000);
					Quad2.x = 450;
					Quad2.y = 595; 
					Quad2.alpha = 0;
					addChild(Quad2);
					
					Quad3 = new Quad(120, 1, 0x000000);
					Quad3.x = 305;
					Quad3.y = 506;
					Quad3.alpha = 0;
					addChild(Quad3);
					
					Quad4 = new Quad(120, 1, 0x000000);
					Quad4.x = 222;
					Quad4.y = 510;
					Quad4.alpha = 0;
					addChild(Quad4);
					
					Quad5 = new Quad(81, 1, 0x000000);
					Quad5.x = 138;
					Quad5.y = 522;
					Quad5.alpha = 0;
					Quad5.rotation = -572,96;
					addChild(Quad5);
					
					QuadFloor = new Quad(1024, 310, 0x000000);
					QuadFloor.y = 680;
					QuadFloor.alpha = 0;
					addChild(QuadFloor);
					
					hero = new caveman(this);
					hero.x = 774;
					hero.y = 595;
					addChild(hero);
					
					quadCaveman = new Quad(30, 121, 0x000000);
					quadCaveman.pivotX = quadCaveman.width * 0.5;
					quadCaveman.pivotY = quadCaveman.height * 0.5;
					quadCaveman.alpha = 0;
					quadCaveman.x = hero.x;
					quadCaveman.y = hero.y;
					addChild(quadCaveman);
					
					
					
					vine2 = new Image(Assets.stageTextureAtlas.getTexture("liana2"));
					vine2.x = 63;
					addChild(vine2);
					
					levelComplete = 15;
					cocoManager = new CoconutManager(this);
					
					
					flyingEnemyManager = new FlyingEnemiesManager(this);
					flyingEnemyManager.maxLevel = 8;
					flyingEnemyManager.maxOnStage = 4;
					
					groundEnemyManager = new GroundEnemyManager(this);
					groundEnemyManager.maxLevel = 7;
					groundEnemyManager.maxOnStage = 2;
					
					break;
					
				default:
					break;
			}

			checkCollides = new CollisionManager(this);
			drawHealthPoints(game.life);
			

		}
		

		
		/* INTERFACE states.IState */
		
		public function update():void 
		{
	
			
			if (!hero.dead)
			{
				hero.update();
				if (hero.cavemanState == "left")
					hero.scaleX = -1;
				if (hero.cavemanState == "right")
					hero.scaleX = 1;
				lanceManager.update();
				quadCaveman.x = hero.x;
				quadCaveman.y = hero.y;
			}
			
			
			
			flyingEnemyManager.update();
			groundEnemyManager.update();
				
			switch(level)
			{
				case 1:
					stoneManager.update();
					break;
				case 2:
					skullManager.update();
					break;
				case 3:
					cocoManager.update();
					break;
				}
				
				checkCollides.update();
				
				if (numDeadEnemies == levelComplete)
				{
				//this.destroy();
					game.changeState("map");	
				}
			
				
				if (hero.dead) 
				{
					this.destroy();
					game.changeState("gameover");
				}
			
			
		}
		
		public function drawHealthPoints(life:int):void
		{
			switch(life)
			{
				case 0:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 6 hits"));
					addChild(healthPoints);
					break;
				case 1:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 5 hits"));
					addChild(healthPoints);
					break;
				case 2:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 4 hits"));
					addChild(healthPoints);
					break;
				case 3:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 3 hits"));
					addChild(healthPoints);
					break;
				case 4:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 2 hits"));
					addChild(healthPoints);
					break;
				case 5:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 1 hits"));
					addChild(healthPoints);
					break;
				case 6:
					healthPoints = new Image (Assets.stageTextureAtlas.getTexture("life 0 hits"));
					addChild(healthPoints);
					break;
			}
			healthPoints.x = 66;
			healthPoints.y = 37;
		}
		
		
		public function destroy():void 
		{
			destruir++;
			
			if (destruir == 1) {
				switch(level)
				{
					case 1:
						
						music.stop();
						removeChild(background);
						//background.removeFromParent(true);
						background = null;
						
						removeChild(platformFloor);
						platformFloor = null;
						
						removeChild(leftPlatform);
						leftPlatform = null;
						
						removeChild(rightPlatform);
						rightPlatform = null;
					
						//todas las imagenes remove from parent
						lanceManager.destroy();
						lanceManager = null;
						flyingEnemyManager.destroy();
						flyingEnemyManager = null;
						stoneManager.destroy();
						
						groundEnemyManager.destroy();
						groundEnemyManager = null;
						//todos los manager hacer destroy menos collision manager
						removeChild(hero);
						removeChild(quadCaveman);
						
						removeChild(levelDays);
						levelDays = null;
						
						removeChild(healthPoints);
						healthPoints = null;
						
						Starling.juggler.purge();
						break;
						
					case 2:
						
						music.stop();
						removeChild(background);
						background = null;
						
						removeChild(platformFloor);
						platformFloor = null;
						
						removeChild(leftPlatform);
						leftPlatform = null;
						
						lanceManager.destroy();
						flyingEnemyManager.destroy();
						skullManager.destroy();
						groundEnemyManager.destroy();
						
						removeChild(hero);
						removeChild(quadCaveman);
						
						removeChild(levelDays);
						levelDays = null;
						
						removeChild(healthPoints);
						healthPoints = null;
						
						Starling.juggler.purge();
						break;
						
					case 3:
						
						removeChild(background);
						background = null;
						
						removeChild(platformFloor);
						platformFloor = null;
						
						removeChild(leftPlatform);
						leftPlatform = null;
						
						removeChild(rightPlatform);
						rightPlatform = null;
						
						removeChild(vine1);
						vine1 = null;
						
						removeChild(vine2);
						vine2 = null;
						
						lanceManager.destroy();
						flyingEnemyManager.destroy();
						cocoManager.destroy();
						groundEnemyManager.destroy();
						
						removeChild(hero);
						removeChild(quadCaveman);
						
						removeChild(levelDays);
						levelDays = null;
						
						removeChild(healthPoints)
						healthPoints = null;
						
						Starling.juggler.purge();
						break;
						
					default:
						break;
						
				}
				
				
				
			
			}
			
		}
	}

}