package rogueLikeGame
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import gameUitis.$;
	import gameUitis.Button;
	import gameUitis.GameBase;
	
	public class StartScene extends Sprite
	{
		public function StartScene(myParent:RogueLike)
		{
			super();
			
			this.myParent = myParent;
			drawSelf();
			buttonBegin = new Button(true,"开始游戏");
			buttonContinue = new Button(true,"继续游戏");
			buttonExit = new Button(true,"退出游戏");
			
			this.addChild(buttonBegin);
			this.addChild(buttonContinue);
			this.addChild(buttonExit);
			
			buttonBegin.x = ($.stage.stageWidth - buttonBegin.width)/2;
			buttonBegin.y = ($.stage.stageHeight - buttonBegin.height)/2 - 100;
			
			buttonContinue.x = ($.stage.stageWidth - buttonContinue.width)/2;
			buttonContinue.y = ($.stage.stageHeight - buttonContinue.height)/2;
			
			buttonExit.x = ($.stage.stageWidth - buttonExit.width)/2;
			buttonExit.y = ($.stage.stageHeight - buttonExit.height)/2 + 100;
			
			buttonBegin.addEventListener(MouseEvent.CLICK,onClick);
			buttonContinue.addEventListener(MouseEvent.CLICK,onContinue);
			buttonExit.addEventListener(MouseEvent.CLICK,onExit);
			
		}
		
		private function drawSelf():void
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
		
		protected function onExit(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onContinue(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onClick(event:MouseEvent):void
		{
			myParent.gameBegin = true;
		}
		
		private var _defaultSkinName:String = "back.png";
		private var _defaultSkin:Bitmap;
		private var myParent:GameBase;
		private var buttonBegin:Button;
		private var buttonContinue:Button;
		private var buttonExit:Button;
	}
}