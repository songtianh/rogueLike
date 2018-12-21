package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;

	public class RogueLikeMonster extends Role
	{
		public function RogueLikeMonster(hpMax:Number=0, attake:Number=0, defense:Number=0, isFriend:int=GameConst.CAMP_TYPE_ENEMY, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, isFriend, CONTROLNODE);
			
			this.setSpeed(20);
		}
		
		override protected function drawSelf():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
		}
		
		public function toPoint(point:Point):void
		{
			
		}
		
		private var _defaultSkinName:String = "monster.png";
		private var _defaultSkin:Bitmap;
	}
}