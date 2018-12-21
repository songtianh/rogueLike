package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.fscommand;
	
	import gameUitis.$;
	import gameUitis.Button;
	import gameUitis.GameBase;
	
	import rogueLikeGame.RogueLike;
	
	public class rogueLike extends Sprite
	{
		public function rogueLike()
		{
			new $(stage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//			buttonBegin = new Button(true,"开始");
			//			_timeId = $.timeManager.setTimer(200,tr,1);
			game = new RogueLike;
			game.x = 0;
			game.y = 0;
			addChild(game);
			
			//			var g1:GameThree = new GameThree;
			//			addChild(g1);
		}
		
		protected function onCilic(event:MouseEvent):void
		{
			game.gameBegin = true;
			buttonBegin.visible = false;
		}
		
		protected function onTouch(event:Event):void
		{
			
		}
		
		private function tr(event:TimerEvent):void
		{
			addChild(buttonBegin);
			buttonBegin.x = (stage.stageWidth - buttonBegin.width)/2;
			buttonBegin.y = stage.stageHeight - buttonBegin.height;
			buttonBegin.addEventListener(MouseEvent.CLICK,onCilic);
		}
		
		private function sum(i:int):void
		{
			_sum = _sum + i;
			if(i == 0)return;
			sum(i - 1);
		}
		
		/**
		 * 得到系统开始时的时间
		 * */
		public function get systemTime():Number
		{
			return data.getTime();
		}
		
		private var _sum:int = 0;
		private var buttonBegin:Button
		private var _img:Bitmap;
		private var _count:int = 0;
		private var _timeId:int = -1;
		private var game:GameBase;
		
		private var data:Date = new Date;
	}
}