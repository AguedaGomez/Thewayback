package Objects 
{
	import Core.Assets;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import states.Play;
	

	public class GroundEnemy extends Sprite 
	{
		private var play:Play;
		
		private var mEnemyRuns:MovieClip;
		private var mDeadEnemy:MovieClip;
		private var mEnemyAttack:MovieClip;
		private var mInjuredEnemy:MovieClip;
		
		public var currentAnimation:MovieClip;
		
		public var EnemyState:String = "left";
		public var healthPoint: int = 2;
		public var EnemyAnimation:String = "runs";
		
		private var stop:Boolean;
		public var dead:Boolean = false;
		
		
		
		public function GroundEnemy(play:Play) 
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
					mEnemyRuns = new MovieClip(Assets.SSTextureAtlas.getTextures("sablerun"), 8);
					mDeadEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("sabledead"), 10);
					mDeadEnemy.loop = false;
					mEnemyAttack = new MovieClip(Assets.SSTextureAtlas.getTextures("sablebites"), 12);
					mEnemyAttack.loop = false;
					mInjuredEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("sableinjured"), 20);
					mInjuredEnemy.loop = false;
					break;
				case 2:
					mEnemyRuns = new MovieClip(Assets.SSTextureAtlas.getTextures("coyoterun"), 8);
					mDeadEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("coyotedead"), 10);
					mDeadEnemy.loop = false;
					mEnemyAttack = new MovieClip(Assets.SSTextureAtlas.getTextures("coyotebite"), 12);
					mEnemyAttack.loop = false;
					mInjuredEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("coyoteinjured"), 20);
					mInjuredEnemy.loop = false;
					break;
				case 3:
					mEnemyRuns = new MovieClip(Assets.SSTextureAtlas.getTextures("raptorun"), 8);
					mDeadEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("raptordead"), 10);
					mDeadEnemy.loop = false;
					mEnemyAttack = new MovieClip(Assets.SSTextureAtlas.getTextures("raptorbite"), 12);
					mEnemyAttack.loop = false;
					mInjuredEnemy = new MovieClip(Assets.SSTextureAtlas.getTextures("raptorinjured"), 20);
					mInjuredEnemy.loop = false;
					break;
			}
			currentAnimation = mEnemyRuns;
			addAnimation(currentAnimation);
			this.pivotX = this.width * 0.5;
			this.pivotY = this.height * 0.5;
			
			
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
			if (EnemyState == "right" && !stop && !dead) 
				this.x += 10;
			else if (EnemyState == "left" && !stop &&!dead)
				this.x -= 10;
	
			
			switch(play.level)
			{
				case 1:
					
					if (this.x - this.width * 0.5 <= 200)
					{
						stop = true;
						
						EnemyState = "right";
						EnemyAnimation =  "attack";
					}
					
					break;
					
				case 2:
					
					if (this.x <= 10)
					{
					stop = true;
					
					EnemyState = "right";
					EnemyAnimation =  "attack";
					}
					
					break;
				
				case 3:
					
					if (this.x - this.width*0.5 <= 0)
					{
					stop = true;
					
					EnemyState = "right";
					EnemyAnimation =  "attack";
					}					
			}
			
			
			
			
			if (this.x + this.width * 0.5 >= 1024)
			{
				stop = true;
				EnemyState = "left";
				EnemyAnimation = "attack";
			}
				

	
				
			switch (EnemyAnimation)
			{
				case "runs":
					if (currentAnimation != mEnemyRuns)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mEnemyRuns;
						addAnimation(currentAnimation);
						currentAnimation.play();
					}
					break;
					
				case "injured":
					
					if (currentAnimation != mInjuredEnemy)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mInjuredEnemy;
						addAnimation(currentAnimation);
						currentAnimation.play();
						trace(currentAnimation.isComplete);
					}
					if (currentAnimation.isComplete) {
						currentAnimation.stop();
						
						EnemyAnimation = "runs";
					}
					break;
				
				case "dead":
					if (currentAnimation != mDeadEnemy)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mDeadEnemy;
						addAnimation(currentAnimation);
					}
					break;
				
					case "attack":
				
					if (currentAnimation != mEnemyAttack)
					{
						removeAnimation(currentAnimation);
						currentAnimation = mEnemyAttack;
						addAnimation(currentAnimation);
						
					}
					if (currentAnimation.isComplete) {
						currentAnimation.stop();
						EnemyAnimation = "runs";
						stop = false;
						currentAnimation.play();
					}
					break;
				
				
			}
				
		}
		

		
	}

}