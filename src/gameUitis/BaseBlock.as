package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class BaseBlock extends Sprite
	{
		public function BaseBlock()
		{
			super();
			
			drawSelf();
		}
		
		protected function drawSelf():void
		{
//			this.graphics.beginFill(0xFAEBD7,1);
//			this.graphics.lineStyle(1,0x000000,1);
//			this.graphics.drawRect(0,0,20,20);
			
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
		
		public function addBuild(build:BaseBuild):void
		{
			if(!this.build)
			{
				this.build = build;
				this.addChild(build);
			}
		}
		
		public function removeBuild():void
		{
			if(build)
			{
				this.removeChild(build);
				build = null;
			}
		}
		public var build:BaseBuild;
		protected var _defaultSkinName:String = "block.png";
		private var _defaultSkin:Bitmap;
	}
}