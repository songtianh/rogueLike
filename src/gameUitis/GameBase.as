package gameUitis
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.ui.Keyboard;
	
	public class GameBase extends Sprite
	{
		public function GameBase()
		{
			super();
			
			initlize();
		}
		
		public function get gameOver():Boolean
		{
			return _gameOver;
		}

		protected function control(event:TimerEvent):void
		{
			if(_gameOver)
			{
				removefrom_stage();
			}
			
			for each(var npc:NpcMonster in $.npcManager.Npc)
			{
				if(npc.gameControlMode == GameConst.CONTROL_ARR[0])
				{
					if(npc.positionPoint != startPoint)
					{
						if(_mousePoint)
						{
							npc.positionPoint = _mousePoint;
						}
						else
						{
							npc.positionPoint = npc.positionPoint;
						}
					}
				}
			}
		}
		
		public function set mousePoint(mousePoint:Point):void
		{
			_mousePoint = mousePoint;
		}
		
		public function get mousePoint():Point
		{
			return _mousePoint;
		}
		
		protected function initlize():void
		{
			playerID = $.npcManager.getHero(15,5,1,GameConst.CONTROL_ARR[1]);
			player = $.npcManager.Npc[playerID];
		}
		
		protected function initaddto_stage():void
		{
			if(_timeId == -1)
				_timeId = $.timeManager.setTimer(20,control,0);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			stage.addEventListener(MouseEvent.CLICK,onMouseClick);
			
		}
		
		private	function menuSelect(e:ContextMenuEvent):void
		{
			trace("11111111");
		}
		
		protected function onMouseClick(event:MouseEvent):void
		{
			var p:Point = new Point(mouseX,mouseY);
			if((p.x >= MIN_TOUCH_POINT.x && p.x<= MAX_TOUCH_POINT.x)  && (p.y >=MIN_TOUCH_POINT.x && p.y<= MAX_TOUCH_POINT.x))
			{}
			else
			{
				for each(var npc:NpcMonster in $.npcManager.Npc)
				{
					_mousePoint = p;
					if(npc.gameControlMode == GameConst.CONTROL_ARR[0])
					{
						npc.positionPoint = _mousePoint;
					}
				}
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			
			switch(event.keyCode)
			{
				case Keyboard.UP:
				case Keyboard.W:
					up = true;
					break;
				case Keyboard.DOWN:
				case Keyboard.S:
					down = true;
					break;
				case Keyboard.LEFT:
				case Keyboard.A:
					left = true;
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					right = true;
					break;
			}
			$.round++;
			changeNpcPosition(up,down,left,right);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
				case Keyboard.W:
					up = false;
					break;
				case Keyboard.DOWN:
				case Keyboard.S:
					down = false;
					break;
				case Keyboard.LEFT:
				case Keyboard.A:
					left = false;
					break;
				case Keyboard.RIGHT:
				case Keyboard.D:
					right = false;
					break;
			}
			changeNpcPosition(up,down,left,right);
		}
		
		protected function changeNpcPosition(up:Boolean,down:Boolean,left:Boolean,right:Boolean):void
		{
			
		}
		
		protected function removefrom_stage():void
		{
			if(_timeId != -1)
			{
				$.timeManager.clearTimer(_timeId);
				_timeId = -1;
			}
		}
		
		protected function addMonster():int
		{
			
			return 0;
		}
		
		public function set gameOver(isOver:Boolean):void
		{
			_gameOver = isOver;
		}
		
		public function set gameBegin(isBegin:Boolean):void
		{
			_gameBegin = isBegin;
			initaddto_stage();
		}
		
		private var _playerControl:ContextMenu;
		private var _mousePoint:Point;
		private var up:Boolean,down:Boolean,left:Boolean,right:Boolean;
		private var _timeId:int = -1;
		private var gameCode:int = 0;
		private var _gameBegin:Boolean = false;
		private var _gameOver:Boolean = false;
		
		public static const startPoint:Point = new Point(0,0);
		protected static const MIN_TOUCH_POINT:Point = new Point(40,40);
		protected static const MAX_TOUCH_POINT:Point = new Point(300,300);
		protected var playerID:int;
		protected var player:NpcMonster;
		protected var boss:NpcMonster;
	}
}