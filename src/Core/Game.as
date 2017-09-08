package Core 
{

	import flash.media.SoundChannel;
	import starling.display.Sprite;
	import starling.events.Event;
	import states.End;
	import states.GameOver;
	import states.IState;
	import states.Map;
	import states.Others;
	import states.Play;
	import states.Menu;
	

	public class Game extends Sprite 
	{
		public static const MenuState:String = "menu";
		public static const PlayState:String = "play";
		public static const MapState:String = "map";
		public static const GameOverState:String = "gameover";
		public static const OthersState:String = "others";
		public static const EndState:String = "end";
		public var Whatbutton:String;
		
		public var life:int = 6;
		
		private var current_state:IState;
		private var music:SoundChannel;
		public var current_level:int = 0; //CAMBIAR A UNO !!!!
		
		public function Game() 
		{
			super();
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			

		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Assets.init();
			music = Assets.titleMusic.play();
			
			changeState(MenuState);
				
			
		}
		
		public function changeState(state:String):void 
		{
			if (current_state != null)
			{
				current_state.destroy();
				current_state = null;
			}
			switch(state)
			{
				case "menu":
					music.stop();
					music = Assets.titleMusic.play();
					current_state = new Menu(this);
					break;
				case "play":
					music.stop();
					current_state = new Play(this, current_level);
					break;
				case "map":
					music.stop();
					if (current_level <= 4) 
					{
						current_level++;
						current_state = new Map(this, current_level);
					}
					trace(current_level);
					break;
				case "gameover":
					music.stop();
					current_state = new GameOver(this);
					current_level = 0;
					life = 6;
					break;
				
				case "end":
					current_state = new End(this);
					current_level = 0;
					life = 6;
					break;
					
				case "others":
					current_state = new Others(this, Whatbutton);
					break;
					
				default:
					break;
			}
			addChild(Sprite(current_state));
		}
		

		
		private function OnEnterFrame(e:Event):void 
		{
			current_state.update();
		}
		
	}

}