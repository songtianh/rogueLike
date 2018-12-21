package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class RoadBlock extends BaseBlock
	{
		public function RoadBlock()
		{
			super();
			
			drawSelf();
		}
		
		override protected function drawSelf():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
		}
		
		private var _defaultSkinName:String = "road.png";
		private var _defaultSkin:Bitmap;
	}
}