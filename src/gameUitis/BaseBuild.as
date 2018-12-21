package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * 基础建筑物
	 * */
	public class BaseBuild extends Sprite
	{
		public function BaseBuild()
		{
			super();
			drawSelf();
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
		
		protected function used():void
		{
			
		}
		
		private var _defaultSkinName:String = "player.png";
		private var _defaultSkin:Bitmap;
	}
}