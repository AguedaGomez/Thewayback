package managers 
{
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Pool 
	{
		
		private var counter:int;
		public var items:Array;
		
		public function Pool(type:Class, len:int) 
		{
			items = new Array();
			counter = len;
			
			var i:int = len;
			while (--i > -1)
				items[i] = new type();
		}
		
		public function getSprite():DisplayObject
		{
			if (counter > 0)
				return items[--counter]
			else
				throw new Error('no mas items en el pool');
		}
		
		public function returnSprite(s:DisplayObject):void
		{
			items[counter++] = s;
		}
		
		public function destroy():void
		{
			trace("destruyendo un pool");
			items = null;
		}
		
	}

}