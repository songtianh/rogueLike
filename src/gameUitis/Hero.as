package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class Hero extends Role
	{
		public function Hero(hpMax:Number=0, attake:Number=0, defense:Number=0, isFriend:int = GameConst.CAMP_TYPE_MINME, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, isFriend, CONTROLNODE);
		}
		
		override protected function drawSelf():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
		}
		
		private var _defaultSkinName:String = "player.png";
		private var _defaultSkin:Bitmap;
	}
}