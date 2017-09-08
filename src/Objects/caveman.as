package Objects 
{
	import Core.Assets;
	import starling.display.Quad;
	import states.Play;
	import flash.display.Bitmap;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.MovieClip;
	import com.greensock.TweenLite;
	
	
	
	public class caveman extends Sprite 
	{
		
		private var mStopCaveman:MovieClip;
		private var mCavemanWalksr:MovieClip;
		private var mCavemanWalksl:MovieClip;
		private var mInjuredCaveman:MovieClip;
		private var mDeadCaveman:MovieClip;
		private var mCavemanShoots:MovieClip;
		private var mCavemanJumps:MovieClip;
		
		private var movingRight:Boolean = false;
		private var movingLeft:Boolean = false;
		private var jump:Boolean = true;
		private var stop:Boolean = true;
		private var shoot:Boolean = true;
		public var injured:Boolean = false;
		public var dead:Boolean = false;
		
		public var cavemanState:String = "right";
		
		private var play:Play;
		private var lance:DisplayObject;
		
		private var currentAnimation:MovieClip;	
		
		//jump
		private var quadArray:Array;

		
		public function caveman(play:Play) 
		{
			this.play = play;
			super();
			init();

		}
		
		public function init():void 
		{

			mStopCaveman = new MovieClip(Assets.SSTextureAtlas.getTextures("stop00"), 15);
			
			mCavemanWalksr = new MovieClip(Assets.SSTextureAtlas.getTextures("walks00"), 20);
			mCavemanWalksl = new MovieClip(Assets.SSTextureAtlas.getTextures("walks00"), 20);

			mInjuredCaveman = new MovieClip(Assets.SSTextureAtlas.getTextures("injured"), 30);
			mInjuredCaveman.loop = false;
			
			mDeadCaveman = new MovieClip(Assets.SSTextureAtlas.getTextures("dead"), 20);
			mDeadCaveman.loop = false;

			mCavemanShoots = new MovieClip(Assets.SSTextureAtlas.getTextures("shoot"), 30);
			mCavemanShoots.loop = false;

			mCavemanJumps = new MovieClip(Assets.SSTextureAtlas.getTextures("jumps"), 20);
			mCavemanJumps.loop = false;

			
			currentAnimation = mStopCaveman;
			addAnimation(currentAnimation);
			
			this.pivotX = this.width * 0.5;
			this.pivotY = this.height * 0.5;

			
			quadArray = new Array();
			switch(play.level)
			{
				case 1:
					quadArray.push(play.Quad2, play.Quad3, play.Quad4, play.Quad5, play.QuadFloor);
					break;
				
				case 2:
					quadArray.push(play.Quad1, play.Quad2, play.Quad3, play.QuadFloor);
					break;
				
				case 3:
					quadArray.push(play.Quad1, play.Quad2, play.Quad3, play.Quad4, play.Quad5, play.QuadFloor);
					break;
			}
			
			

			
			

			this.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			this.addEventListener(KeyboardEvent.KEY_UP, onUp);
						
		}
		
		private function onUp(e:KeyboardEvent):void 
		{
			
			removeAnimation(currentAnimation);
			currentAnimation = mStopCaveman;
				
			
			
			switch(e.keyCode)
			{
				case Keyboard.RIGHT:
					movingRight = false;
					break;
				case Keyboard.LEFT:
					movingLeft = false;
					break;
				/*case Keyboard.UP:
					jump = true;
					break;*/
				case Keyboard.SPACE:
					if (movingRight) 
					{
						removeAnimation(currentAnimation);
						currentAnimation = mCavemanWalksr;
						addAnimation(currentAnimation);
					}
					else if (movingLeft) 
					{
						removeAnimation(currentAnimation);
						currentAnimation = mCavemanWalksl;
						addAnimation(currentAnimation);
					}
					shoot = true;


					break;
					
			}
			addAnimation(currentAnimation);
			
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			

				switch(e.keyCode)
				{
					
					case Keyboard.RIGHT:
						if (currentAnimation != mCavemanWalksr) 
						{
							if (cavemanState == "left") 
							{
								//this.x -= this.width;
								
								cavemanState = "right";
							}

							removeAnimation(currentAnimation);
							currentAnimation = mCavemanWalksr;
							addAnimation(currentAnimation);
							
							movingRight = true;
							
						}
						
					
						
						break;
					
					case Keyboard.LEFT:
						if (currentAnimation != mCavemanWalksl)
						{
							if (cavemanState == "right")
							{
								
								cavemanState = "left";
							}
							removeAnimation(currentAnimation);
							currentAnimation = mCavemanWalksl;
							addAnimation(currentAnimation);
							
							//currentAnimation.scaleX = -1;
							movingLeft = true;
						}
						

						break;
						
					case Keyboard.UP:
						if (currentAnimation != mCavemanJumps && jump && !dead)
						{
							removeAnimation(currentAnimation);
							currentAnimation = mCavemanJumps;
							addAnimation(currentAnimation);
							
							if (jump && !dead) {
								if (cavemanState == "right")
								{
									TweenLite.to(this, 0.5, { y:this.y - 120 } );
									
								}
								else if (cavemanState == "left")
								{
									
									TweenLite.to(this, 0.5, { y:this.y - 120 } );
								}
								
							}
							

							
							//jump = false;
						}
						break;
						
					case Keyboard.SPACE:
						if (currentAnimation != mCavemanShoots)
						{
							removeAnimation(currentAnimation);
							currentAnimation = mCavemanShoots;
							addAnimation(currentAnimation);
						}
						
						if (shoot && !dead)
							play.lanceManager.spawn(this.x, this.y, cavemanState);
						
						shoot = false;
						
						
						break;						
				}
		}
		
		private function removeAnimation(animationvar:MovieClip):void
		{
			//trace("eliminar animacion");
			Starling.juggler.remove(animationvar);
			removeChild(animationvar);
		}
		
		private function addAnimation(animationvar:MovieClip):void 
		{
			//trace("crear animacion");
			Starling.juggler.add(animationvar);
			addChild(animationvar);

			
		}
		
		public function update():void
		{
			checkLimits();
			//trace(this.x);
			
			if (movingRight)
			{
				this.x += 5;
				
			}
			
			else if (movingLeft)
			{
				this.x -= 5;
				
			}
			
			if (!intersect())
			{
				this.y += 10;
				jump = false;
		
			}
			if (injured)
			{
				if (currentAnimation != mInjuredCaveman)
				{
					removeAnimation(currentAnimation);
					currentAnimation = mInjuredCaveman;
					addAnimation(currentAnimation);
					currentAnimation.play();
				}
				if (currentAnimation.isComplete)
				{
					currentAnimation.stop();
					
					if (play.game.life > 0) {
						play.game.life--;
						play.drawHealthPoints(play.game.life);
					}
					injured = false;
					
					if (currentAnimation != mStopCaveman)
					{
					removeAnimation(currentAnimation);
					currentAnimation = mStopCaveman;
					addAnimation(currentAnimation);
					}
					
					
					
					
				}
			}
			if (play.game.life == 0) 
			{
				removeAnimation(currentAnimation);
				currentAnimation = mDeadCaveman;
				addAnimation(currentAnimation);
				
				if (currentAnimation.isComplete)
				{
					dead = true;
					this.removeEventListener(KeyboardEvent.KEY_DOWN, onDown);
					this.removeEventListener(KeyboardEvent.KEY_UP, onUp);
				}
			}
			
				
			
				
		}
		
		private function intersect():Boolean
		{
			for (var i:int = 0; i < quadArray.length; ++i)
			{
				if (play.quadCaveman.bounds.intersects(quadArray[i].bounds))
				{
					jump = true;
					return true;
				}
				
			}
			return false;
			
		}
		
		private function checkLimits():void 
		{
			switch(play.level)
			{
				case 1:
					if (this.bounds.intersects(play.Quad3.bounds))
						movingLeft = false;
					if (this.bounds.intersects(play.Quad5.bounds) && this.x>= play.Quad5.bounds.left)
						movingRight = false;
					
					else if (this.x <= play.Quad2.bounds.left)
					{
						jump = false;
						movingLeft = false;
					}
					else if (this.x >= 1024 - this.width*0.5)
						movingRight = false;
					break;
					
				case 2:
					if (this.x >= 1024 - this.width * 0.5)
						movingRight = false;
					
					else if (this.x - this.width * 0.5 <= 0)
						movingLeft = false;
						
					break;
				
				case 3:
	
						
					if (this.x >= 1024 - this.width * 0.5)
						movingRight = false;
					
					else if (this.x - this.width * 0.5 <= 0)
						movingLeft = false;
					
			}
		}
		
		
		

	}
}