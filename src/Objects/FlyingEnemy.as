package Objects 
{
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.Sprite;
	import Core.Assets;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.MovieClip;
	import starling.display.Image;
	import states.Play;
	import starling.core.Starling;
	import com.greensock.TweenLite;
	

	public class FlyingEnemy extends Sprite 
	{
		private var mEnemyFlies:MovieClip;
		private var mDeadEnemy:MovieClip;
		private var mEnemyAttack:MovieClip;
		private var mInjuredEnemy:MovieClip;
		
		public var currentAnimation:MovieClip;
		
		public var EnemyState:String = "left";
		private var timeChange:int;
		private var vulnerable:int = -1;
		public var healthPoint: int = 4;
		public var EnemyAnimation:String = "flies";
		private var timeStone: int;
		public var dead:Boolean = false;

		
		private var play:Play;
		
		
		
		public function FlyingEnemy(play:Play) 
		{
			super();
			this.play = play;
			init();
			
		}
		
		private function init():void 
		{
			switch(play.level)
			{
				case 1:
					mEnemyFlies = new MovieClip(Assets.SSTextureAtlas.getTextures("pterofly"), 20);
					mDeadEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("pterodead"), 10);
					mDeadEnemy.loop = false;
					mEnemyAttack = new MovieClip(Assets.SSTextureAtlas.getTextures("pteroattack"), 12);
					mInjuredEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("pteroinjured"), 20);
					mInjuredEnemy.loop = false;
					break;
				case 2:
					mEnemyFlies = new MovieClip(Assets.SSTextureAtlas.getTextures("buitrefly"), 20);
					mDeadEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("buitredead"), 20);
					mDeadEnemy.loop = false;
					mEnemyAttack = new MovieClip(Assets.SSTextureAtlas.getTextures("buitreattack"), 12);
					mInjuredEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("buitreinjured"), 20);
					mInjuredEnemy.loop = false;
					break;
				case 3:
					mEnemyFlies = new MovieClip(Assets.SSTextureAtlas.getTextures("tucanfly"), 20);
					mDeadEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("tucandead"), 20);
					mDeadEnemy.loop = false;
					mEnemyAttack = new MovieClip(Assets.SSTextureAtlas.getTextures("tucanattack"), 12);
					mInjuredEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("tucaninjured"), 20);
					mInjuredEnemy.loop = false;
					break;
				default:
					break;
			}
			
			
			currentAnimation = mEnemyFlies;
			addAnimation(currentAnimation);
			this.pivotX = this.width * 0.5;
			this.pivotY = this.height * 0.5;
			
			
			timeChange = Math.ceil(Math.random() * 4) + 3;
			timeStone = Math.ceil(Math.random() * 4);
			Starling.juggler.delayCall(throwStone, timeStone);
			
			
			
		}
		
		private function throwStone():void 
		{
			
			if (vulnerable == -1) {
				
				switch (play.level)
				{
					case 1:
						play.stoneManager.spawn(this.x, this.y);
						break;
					case 2:
						play.skullManager.spawn(this.x, this.y);
						break;
					case 3:
						play.cocoManager.spawn(this.x, this.y);
						break;
					default:
						break;
				}
				
			}
			timeStone = Math.ceil(Math.random() * 6);
			Starling.juggler.delayCall(throwStone, timeStone);
			
		}

		
		private function addAnimation(animationvar:MovieClip):void
		{
			Starling.juggler.add(animationvar);
			addChild(animationvar);
		}
		
		private function removeAnimation(animationvar:MovieClip):void
		{
			Starling.juggler.remove(animationvar);
			removeChild(animationvar);
		}
		
		public function update():void
		{
			//movement
			if (EnemyState == "right") 
				this.x += 10;
			else if (EnemyState == "left")
				this.x -= 10;
			
			//limits
				if (this.x + this.width * 0.5 >= 1024)
				{
				--timeChange;
				EnemyState = "left";
				}
				
				else if (this.x - this.width * 0.5 <= 0)
				{
				--timeChange;
				EnemyState = "right";
				}
				

				
			if (timeChange == 0) 
			{
				
				changeMovement();
				
				vulnerable *= -1;
			}
			switch (EnemyAnimation)
			{
				case "flies":
					if (currentAnimation != mEnemyFlies)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mEnemyFlies;
						addAnimation(currentAnimation);
					}
					break;
				case "injured":
					if (currentAnimation != mInjuredEnemy)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mInjuredEnemy;
						addAnimation(currentAnimation);
						currentAnimation.play();
						
					}
					if (currentAnimation.isComplete) {
						currentAnimation.stop();
						
						EnemyAnimation = "flies";
					}
					break;
				
				case "dead":
					if (currentAnimation != mDeadEnemy)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mDeadEnemy;
						addAnimation(currentAnimation);
					}
				default:
					break;
			}	
			
				
		}
		
		
		private function changeMovement():void 
		{
			if (play.level == 1) 
			{
				trace("se debe mover");
					
					if (EnemyState == "right")
					{
						
						if (vulnerable == -1)
							TweenLite.to(this, 1, { x:202, y:400 } );
						if (vulnerable == 1)
							TweenLite.to(this, 1, { x:100, y:150} );
						timeChange = Math.ceil(Math.random() * 4) + 3;
						
					}
					if (EnemyState == "left")
					{
						
						if (vulnerable == -1)
							TweenLite.to(this, 1, { x:841, y:400 } );
						if (vulnerable == 1)
							TweenLite.to(this, 1, { x:800, y:150 } );
						timeChange = Math.ceil(Math.random() * 4) + 3;
						
					}
			}
					
			else
			{
					
				if (EnemyState == "right")
				{
						
					if (vulnerable == -1)
						TweenLite.to(this, 1, { x:202, y:316 } );
					if (vulnerable == 1)
						TweenLite.to(this, 1, { x:100, y:150} );
					timeChange = Math.ceil(Math.random() * 4) + 3;
						
				}
				if (EnemyState == "left")
				{
						
					if (vulnerable == -1)
						TweenLite.to(this, 1, { x:841, y:316} );
					if (vulnerable == 1)
						TweenLite.to(this, 1, { x:800, y:150 } );
					timeChange = Math.ceil(Math.random() * 4) + 3;
						
				}
							
			}

		}
		
	}

}