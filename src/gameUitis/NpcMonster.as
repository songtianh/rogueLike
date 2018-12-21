package gameUitis
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.media.Sound;
	
	public class NpcMonster extends Sprite
	{
		public function NpcMonster(hpMax:Number = 0,attake:Number = 0,defense:Number = 0,isFriend:int = 0,CONTROLNODE:int = 2)
		{
			super();
			_hp = hpMax;
			_attak = attake;
			_defense = defense;
			_isFriend = isFriend;
			_gameControlMode = CONTROLNODE;
			attakeSound = $.loadManager.LoadSound("attake");
		}
		
		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get defense():int
		{
			return _defense;
		}

		public function get attakNum():Number
		{
			return _attak;
		}

		public function set attakNum(value:Number):void
		{
			_attak = value;
		}

		public function get alive():Boolean
		{
			return _hp > 0;
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function attake(role:NpcMonster):void
		{
			if(this.isFriend == role.isFriend)return;
			attakeSound.play();
			role.attaked(_attak,this);
		}
		
		public function attaked(atk:Number,role:NpcMonster):void
		{
			attakeNpc = role;
			var damage:Number = (atk - _defense)<=0 ? 0 : (atk - _defense)
			_hp = _hp - damage;
		}
		
		public function recover(i:Number):void
		{
			_hp = _hp + i;
		}
		
		public function autoMove(direct:int):void
		{
			var direction:int = direct;
			switch(direction)
			{
				case GameConst.NONE:
					_moveDirectionY = GameConst.NONE;
					break;
				case GameConst.LEFT:
					_moveDirectionX = GameConst.LEFT;
					break;
				case GameConst.RIGHT:
					_moveDirectionX = GameConst.RIGHT;
					break;
				case GameConst.UP:
					_moveDirectionY = GameConst.UP;
					break;
				case GameConst.DOWN:
					_moveDirectionY = GameConst.DOWN;
					break;
			}
			move();
		}
		
		public function moveTo(p:Point):void
		{
			if(!p)return;
			if(this.x > p.x)
				_moveDirectionX = GameConst.LEFT;
			else if(this.x< p.x)
				_moveDirectionX = GameConst.RIGHT;
			else if(this.x== p.x)
				_moveDirectionX = GameConst.NONE;
			
			if(this.y> p.y)
				_moveDirectionY = GameConst.UP;
			else if(this.y< p.y)
				_moveDirectionY = GameConst.DOWN;
			else if(this.y== p.y)
				_moveDirectionY = GameConst.NONE;
			
			if((Math.abs(this.x - p.x) < this._moveSpeed) && (Math.abs(this.y - p.y) < this._moveSpeed))
			{
				this.x = p.x;
				this.y = p.y;
				return;
			}
			move();
		}
		
		public function move():void
		{
			switch(_moveDirectionX)
			{
				case GameConst.NONE:
					break;
				case GameConst.LEFT:
					this.x = this.x - _moveSpeed;
					return;
					break;
				case GameConst.RIGHT:
					this.x = this.x + _moveSpeed;
					return;
					break;
			}
			
			switch(_moveDirectionY)
			{
				case GameConst.NONE:
					break;
				case GameConst.UP:
					this.y = this.y - _moveSpeed;
					break;
				case GameConst.DOWN:
					this.y = this.y + _moveSpeed;
					break;
			}
		}
		
		public function isImpactItem(shape:Sprite):Boolean
		{
			return GameUtil.isImPact(this,shape);
		}
		
		public function isImpactNpcMonster(shape:NpcMonster):Boolean
		{
			return GameUtil.isImPact(this,shape);
		}
		
		public function dispose():void
		{
			if(this.parent)
				this.parent.removeChild(this)
		}
		
		public function get gameControlMode():int{return _gameControlMode;}
		public function set moveDirectionX(i:int):void
		{
			_moveDirectionX = i
		}
		public function set moveDirectionY(i:int):void
		{
			_moveDirectionY = i
		}
		public function set positionPoint(p:Point):void
		{
			_positionPoint = p;
			moveTo(p);
			//到达指定位置后重置目标地点
			
			if(p && this.x == p.x && this.y == p.y)
			{
				_positionPoint = null;
			}
		}
		
		public function get positionPoint():Point
		{
			return _positionPoint;
		}
		public function set image(image:Loader):void
		{
			_image = image;
			_image.x = 0;
			_image.y = 0;
			addChild(_image);
		}
		
		public function position(p:Point):void
		{
			this.x = p.x;
			this.y = p.y;
		}
		
		public function setSpeed(i:int):void
		{
			this._moveSpeed = i;
		}
		
		public function get isFriend():int
		{
			return _isFriend;
		}
		
		private var _level:int = 1;
		public var attakeNpc:NpcMonster;
		private var _image:Loader;
		private var _gameControlMode:int = GameConst.CONTROL_ARR[2];
		private var _isFriend:int = 0;
		private var _maxhp:Number = 10;
		private var _moveSpeed:Number = 2;
		private var _moveDirectionX:Number = 0;
		private var _moveDirectionY:Number = 0;
		private var _hp:Number = 10;
		private var _mp:Number = 0;
		private var _attak:Number = 2;
		private var _defense:int = 1;
		private var _positionPoint:Point;
		private var attakeSound:Sound;
	}
}