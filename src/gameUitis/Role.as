package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;

	public class Role extends NpcMonster
	{
		public function Role(hpMax:Number=0, attake:Number=0, defense:Number=0, isFriend:int= GameConst.CAMP_TYPE_MINME, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, isFriend, CONTROLNODE);
			drawSelf();
			this.setSpeed(20);
			addFilter();
		}
		
		private function addFilter():void
		{
			var blur:GlowFilter;
			switch(isFriend)
			{
				case GameConst.CAMP_TYPE_MINME:
					blur = new GlowFilter(0x00ff00,1);
					break;
				case GameConst.CAMP_TYPE_ALLY:
					blur = new GlowFilter(0x00ff00,1);
					break;
				case GameConst.CAMP_TYPE_NEUTRAL:
					blur = new GlowFilter(0x0000ff,1);
					break;
				case GameConst.CAMP_TYPE_ENEMY:
					blur = new GlowFilter(0xff0000,1);
					break;
			}
			
			var filters:Array = new Array();
			filters.push(blur);
			this.filters = filters;
		}
		
		protected function drawSelf():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
		}
		
		protected function defaultfinished(event:Event):void
		{
			_defaultSkin = new Bitmap(event.target.content.bitmapData);
			addChildAt(_defaultSkin,0);
			this.width = _defaultSkin.width;
			this.height = _defaultSkin.height;
		}
		
		override public function move():void
		{
			super.move();
			
		}
		
		protected var _defaultSkinName:String = "monster.png";
		private var _defaultSkin:Bitmap;
	}
}