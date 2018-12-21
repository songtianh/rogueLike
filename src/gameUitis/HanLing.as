package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * 姓名：翰林
	 * 职业：宅男
	 * desc: 强度低中立友好怪
	 * */
	public class HanLing extends BaseNpc
	{
		public function HanLing(hpMax:Number=10, attake:Number=1, defense:Number=1, isFriend:int=GameConst.CAMP_TYPE_NEUTRAL, CONTROLNODE:int=2)
		{
			super("翰林",hpMax, attake, defense, isFriend, CONTROLNODE);
		}
		
		override protected function drawSelf():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
		}
		
		private var _defaultSkinName:String = "hanling.png";
		private var _defaultSkin:Bitmap;
	}
}