package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class StairBuild extends BaseBuild
	{
		public function StairBuild(type:int)
		{
			super();
			this.type = type;
			drawSelf();
		}
		
		override protected function drawSelf():void
		{
			if(type == DOWN_STAIR_TYPE)
			{
				_defaultSkinName = "downStair.png";
				var l:Loader = new Loader();
				var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
				l.load(request);
			}
			else if(type == UP_STAIR_TYPE)
			{
				_defaultSkinName = "upStair.png";
				l = new Loader();
				request = new URLRequest('texture/img/' + _defaultSkinName);
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
				l.load(request);
			}
		}
		
		
		override protected function used():void
		{
			if(type == DOWN_STAIR_TYPE)
			{
				
			}
			else if(type == UP_STAIR_TYPE)
			{
			
			}
		}
		
		private var _defaultSkinName:String;
		private var _defaultSkin:Bitmap;
		private var type:int = 0;
		//下楼楼梯
		public static const DOWN_STAIR_TYPE:int = 1;
		//上楼楼梯
		public static const UP_STAIR_TYPE:int = 2;
	}
}