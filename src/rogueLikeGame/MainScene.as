package rogueLikeGame
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import gameUitis.$;
	import gameUitis.BaseBlock;
	import gameUitis.Button;
	import gameUitis.GameBase;
	import gameUitis.GameConst;
	import gameUitis.HanLing;
	import gameUitis.Monster;
	import gameUitis.NpcMonster;
	import gameUitis.RoadBlock;
	import gameUitis.RogueLikeMonster;
	import gameUitis.Role;
	import gameUitis.StairBuild;
	
	public class MainScene extends Sprite
	{
		public function MainScene(myParent:RogueLike,player:NpcMonster)
		{
			super();
			
			this.player = player;
			this.addChild(this.player);
			this.myParent = myParent;
			drawSelf();
			loadSound();
			$.scene = this;

			infoText = new TextField();
			infoText.mouseEnabled = false;
			infoText.background = true;
			infoText.backgroundColor = 0xD9FFFF;
			this.addChild(infoText);
			infoText.y = 100;
			
			downFloor();
		}
		
		private function loadSound():void
		{
			backSound = $.loadManager.LoadSound("backSound");
			awardSound = $.loadManager.LoadSound("award");
			jumpSound = $.loadManager.LoadSound("jump");
			attakeSound = $.loadManager.LoadSound("attake");
			playBackSound(null);
		}
		
		private function playBackSound(e:Event):void
		{
			backSoundChannel = backSound.play();
			backSoundChannel.addEventListener(Event.SOUND_COMPLETE,playBackSound);
		}
		
		private function drawSelf():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
			
			l = new Loader();
			request = new URLRequest('texture/img/' + _innerSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, innerfinished);
			l.load(request);
		}
		
		protected function innerfinished(event:Event):void
		{
			
			_innerSkin = new Bitmap(event.target.content.bitmapData);
			addChildAt(_innerSkin,1);
			_innerSkin.x = 100;
			_innerSkin.y = 0;
		}
		
		protected function defaultfinished(event:Event):void
		{
			_defaultSkin = new Bitmap(event.target.content.bitmapData);
			addChildAt(_defaultSkin,0);
			this.width = _defaultSkin.width;
			this.height = _defaultSkin.height;
		}
		
		private function refreshText():void
		{
			infoText.text = "当前层数: "+ currentFloor +"层\r" +
							"当前层怪物数:" + monsterArr.length + "\r"+
							"当前血量:" + player.hp + 			   "\r" +
							"当前攻击:" + player.attakNum +      "\r"+
							"当前防御:" + player.defense +       "\r"+
							"当前等级:" + player.level +         "\r";
		}
		
		public function downFloor():void
		{
			removeScene();
			currentFloor++;
			addScene();
			
			this.player.x = upPoint.x;
			this.player.y = upPoint.y;
		}
		
		public function upFloor():void
		{
			removeScene();
			currentFloor--;
			addScene();
			
			this.player.x = downPoint.x;
			this.player.y = downPoint.y;
		}
		private function addScene():void
		{
			if(allfloor.length >= currentFloor)
			{
				copyFloor();
			}
			else
			{
				addFloor();
				addRoad();
				addBuild();
			}
			addPlayer();
			refreshText();
		}
		
		private function copyFloor():void
		{
			var floorInfo:Object = allfloor[currentFloor - 1];
			if(floorInfo.floorIndex != currentFloor)
			{
				throw new Error("楼层读取错误");
			}
			floor = floorInfo.floorArr;
			roadRange = floorInfo.roadArr;
			for each(var obj:Object in floor)
			{
				this.addChild(BaseBlock(obj.block));
				obj.block.x =  obj.x;
				obj.block.y =  obj.y;
			}

			for each(obj in roadRange)
			{
				this.addChild(RoadBlock(obj.road));
				obj.road.x =  obj.x;
				obj.road.y =  obj.y;
			}
			
			downPoint = new Point(floorInfo.downPoint.x,floorInfo.downPoint.y);
			upPoint = new Point(floorInfo.upPoint.x,floorInfo.upPoint.y);
			for each(obj in floor)
			{
				if(obj.x == downPoint.x && obj.y == downPoint.y)
				{
					obj.block.addChild(obj.block.build);
//					obj.block.addBuild(new StairBuild(StairBuild.DOWN_STAIR_TYPE));
				}
				
				if(obj.x == upPoint.x && obj.y == upPoint.y)
				{
					obj.block.addChild(obj.block.build);
//					obj.block.addBuild(new StairBuild(StairBuild.UP_STAIR_TYPE));
				}
			}
		}
		
		private function addBuild():void
		{
			var downIndex:int = roundRange(9);
			var upIndex:int =  roundRange(9);
			while(upIndex == downIndex)
			{
				upIndex =  roundRange(9);
			}
			
			var downInfo:Object = floorRange[downIndex];
			var width:int = roundRange(downInfo.width);
			var height:int = roundRange(downInfo.height);
			var x1:int = (downInfo.x + width)*20 + Math.floor(downInfo.index%3)*200 + 100;
			var y1:int = (downInfo.y + height)*20 + Math.floor(downInfo.index/3)*200;
			
			var upInfo:Object = floorRange[upIndex];
			width = roundRange(upInfo.width);
			height = roundRange(upInfo.height);
			var x2:int = (upInfo.x + width)*20 + Math.floor(upInfo.index%3)*200 + 100;
			var y2:int = (upInfo.y + height)*20 + Math.floor(upInfo.index/3)*200;
			
			for each(var obj:Object in floor)
			{
				if(obj.x == x1 && obj.y == y1)
				{
					obj.block.addBuild(new StairBuild(StairBuild.DOWN_STAIR_TYPE));
				}
				
				if(obj.x == x2 && obj.y == y2)
				{
					obj.block.addBuild(new StairBuild(StairBuild.UP_STAIR_TYPE));
				}
			}
			downPoint = new Point(x1,y1)
			upPoint = new Point(x2,y2)
		}
		
		private function addPlayer():void
		{
			this.addChild(player);
			
		}
		
		private function addRoad():void
		{
			var obj1:Object;
			var obj2:Object
			var roadIndex:int;
			var roadY:int;
			var count:int;
			var block:BaseBlock;
			var roadX:int;
			for each(obj1 in floorRange)
			{
				roadX = 0;
				roadY = 0;
				if(obj1.index%3 != 2)
				{
					obj2 = floorRange[obj1.index + 1];
					roadIndex = roundRange(obj1.height);
					roadY = obj1.y*20 + roadIndex*20 + Math.floor(obj1.index/3)*200;
					count = (obj2.x + 10 - obj1.x - obj1.width)
					for(var i:int = 0 ; i<count ; i++)
					{
						block = new RoadBlock();
						block.x = (obj1.x + obj1.width + i)*20 + 100 + Math.floor(obj1.index%3)*200;
						roadX = block.x;
						block.y = roadY;
						this.addChild(block);
						roadRange.push({road:block,x:block.x,y:block.y});
					}
					
					if(roadY < (obj2.y*20 + Math.floor(obj2.index/3)*200))
					{
						count = ((obj2.y*20 + Math.floor(obj2.index/3)*200) - roadY)/20
						for(i = 1 ; i<=count ; i++)
						{
							block = new RoadBlock();
							block.x = roadX;
							block.y = roadY + i*20;
							this.addChild(block);
							roadRange.push({road:block,x:block.x,y:block.y});
						}
					}
					else if(roadY >= ((obj2.y + obj2.height)*20 + Math.floor(obj2.index/3)*200))
					{
						count = (roadY - ((obj2.y + obj2.height)*20 + Math.floor(obj2.index/3)*200))/20
						for(i = 1 ; i<=count + 1; i++)
						{
							block = new RoadBlock();
							block.x = roadX;
							block.y = roadY - i*20;
							this.addChild(block);
							roadRange.push({road:block,x:block.x,y:block.y});
						}
					}
				}
			}
			
			//竖向道路
			for each(obj1 in floorRange)
			{
				roadX = 0;
				roadY = 0;
				if(int(obj1.index/3) != 2)
				{
					obj2 = floorRange[obj1.index + 3];
					roadIndex = roundRange(obj1.width);
					roadX = obj1.x*20 + roadIndex*20 + Math.floor(obj1.index%3)*200 + 100;
					count = (obj2.y + 10 - obj1.y - obj1.height)
					for(i = 0 ; i<count ; i++)
					{
						block = new RoadBlock();
						block.y = (obj1.y + obj1.height + i)*20 + Math.floor(obj1.index/3)*200;
						roadY = block.y;
						block.x = roadX;
						this.addChild(block);
						roadRange.push({road:block,x:block.x,y:block.y});
					}
					
					if(roadX < (obj2.x*20 + Math.floor(obj2.index%3)*200 + 100))
					{
						count = ((obj2.x*20 + Math.floor(obj2.index%3)*200 + 100) - roadX)/20
						for(i = 1 ; i<=count ; i++)
						{
							block = new RoadBlock();
							block.x = roadX + i*20;
							block.y = roadY;
							this.addChild(block);
							roadRange.push({road:block,x:block.x,y:block.y});
						}
					}
					else if(roadX >= ((obj2.x + obj2.width)*20 + Math.floor(obj2.index%3)*200 + 100))
					{
						count = (roadX - ((obj2.x + obj2.width)*20 + Math.floor(obj2.index%3)*200 + 100))/20
						for(i = 1 ; i<=count + 1; i++)
						{
							block = new RoadBlock();
							block.x = roadX - i*20;
							block.y = roadY;
							this.addChild(block);
							roadRange.push({road:block,x:block.x,y:block.y});
						}
					}
				}
			}
		}
		
		protected function refresh(event:MouseEvent):void
		{
			removeScene();
			addScene();
		}
		
		private function removeScene():void
		{
			removeMonster();
			if(allfloor.length < currentFloor && currentFloor != 0)
			{
				allfloor.push({floorArr:floor.slice(),roadArr:roadRange.slice(),floorIndex:currentFloor,downPoint:clone(downPoint),upPoint:clone(upPoint)});
				
			}
			for each(var obj:Object in floor)
			{
				this.removeChild(obj.block);
				obj = null;
			}
			floor = [];
			
			for each(obj in roadRange)
			{
				this.removeChild(obj.road);
				obj = null;
			}
			roadRange = [];
			floorRange = [];
			this.removeChild(player);
		}
		
		private function removeMonster():void
		{
			
			for each(var id:int in monsterArr)
			{
				monsterArr.splice(monsterArr.indexOf(id),1);
				var m:RogueLikeMonster = $.npcManager.Monster[id];
				this.removeChild(m);
				$.npcManager.clearMonseter(id)
			}
		}
		
		private function clone(source:Object):* 
		{ 
			var myBA:ByteArray = new ByteArray(); 
			myBA.writeObject(source); 
			myBA.position = 0; 
			return(myBA.readObject()); 
		}
		
		private function addFloor():void
		{
			var rx:int;
			var ry:int;
			var block:BaseBlock
			var randomStartPoint:Point;
			var startX:int;
			var startY:int;
			var widthNumber:int;
			var heightNumber:int;
			for(var i:int = 0 ; i<9 ; i++)
			{
				randomStartPoint = new Point(Math.floor(i%3)*200,Math.floor(i/3)*200);
				startX = roundRange(4,0);
				startY = roundRange(4,0);
				widthNumber = roundRange(8 - startX,3);
				heightNumber = roundRange(8 - startX,3);
				floorRange.push({x:startX,y:startY,width:widthNumber,height:heightNumber,index:i});
				for(var j:int =0 ; j<widthNumber ; j++)
				{
					for(var k:int = 0 ; k<heightNumber ; k++)
					{
						rx = startPoint.x + randomStartPoint.x + startX*20 + j*20;
						ry = startPoint.y + randomStartPoint.y + startY*20 + k*20;
						block = new BaseBlock;
						block.x = rx;
						block.y = ry;
						this.addChild(block);
						floor.push({block:block,x:rx,y:ry,id:i})
					}
				}
			}
		}
		
		private function roundRange(max:int = 1,min:int = 0):int
		{
			return min + Math.floor(Math.random()*(max - min));;
		}
		
		public function changeNpcPosition(up:Boolean,down:Boolean,left:Boolean,right:Boolean):void
		{
			var npc:NpcMonster = player;
			if(npc.gameControlMode == GameConst.CONTROL_ARR[1])
			{
				if(up)npc.moveDirectionY = GameConst.UP;
				if(down)npc.moveDirectionY = GameConst.DOWN;
				if(left)npc.moveDirectionX = GameConst.LEFT;
				if(right)npc.moveDirectionX = GameConst.RIGHT;
				
				if(!up && !down)
					npc.moveDirectionY = GameConst.NONE;
				if(!left && !right)
					npc.moveDirectionX = GameConst.NONE;
			}
			
			var point:Point;
			if(up)
			{
				point = new Point(player.x,player.y - 20);
			}
			if(down)
			{
				point = new Point(player.x,player.y + 20);
			}
			if(left)
			{
				point = new Point(player.x - 20,player.y);
			}
			if(right)
			{
				point = new Point(player.x + 20,player.y);
			}
			if(!point)return;
			if(isInMap(point))
			{
				npc.move();
			}
			else
			{
				//操作无效
				return;
			}
			if(point.x == downPoint.x && point.y == downPoint.y)
			{
				downFloor();
			}
			if(point.x == upPoint.x && point.y == upPoint.y)
			{
				if(currentFloor > 1)
					upFloor();
			}
			
			RandomScene();
			moveMonster();
			refreshText();
		}
		
		private function moveMonster():void
		{
			var m:RogueLikeMonster;
			var direct:int;
			var point:Point;
			for each(var id:int in monsterArr)
			{
				m = $.npcManager.Monster[id]
				point = null;
				if(m.gameControlMode == GameConst.CONTROL_ARR[2])
				{
					direct = roundRange(5);
					while(!isInMap(point))
					{
						direct =  roundRange(5);
						switch(direct)
						{
							case GameConst.NONE:
								point = new Point(m.x,m.y);
								break;
							case GameConst.LEFT:
								point = new Point(m.x - 20,m.y);
								break;
							case GameConst.RIGHT:
								point = new Point(m.x + 20,m.y);
								break;
							case GameConst.UP:
								point = new Point(m.x,m.y - 20);
								break;
							case GameConst.DOWN:
								point = new Point(m.x,m.y + 20);
								break;
						}
					}
					m.x = point.x;
					m.y = point.y;
				}
			}
		}
		
		private function RandomScene():void
		{
			var able:int = roundRange(1000);
			if(able > 940)
			{
				addMonster();
			}
			else if(able > 950)
			{
				addNpc();
			}
		}
		
		private function addNpc():void
		{
			var len:int = floor.length;
			var index:int = roundRange(len);
			if(hasOthers(index))return;
			var ix:int = floor[index].x;
			var iy:int = floor[index].y;
			var monsterId:int = $.npcManager.getNpc();
			var monster:HanLing = $.npcManager.Npc[monsterId];
			this.addChild(monster);
			monster.x = ix;
			monster.y = iy;
			npcArr.push(monsterId);
		}
		
		private function addMonster():void
		{
			var len:int = floor.length;
			var index:int = roundRange(len);
			if(hasOthers(index))return;
			var ix:int = floor[index].x;
			var iy:int = floor[index].y;
			var monsterId:int = $.npcManager.getMonster();
			var monster:RogueLikeMonster = $.npcManager.Monster[monsterId];
			this.addChild(monster);
			monster.x = ix;
			monster.y = iy;
				
			monsterArr.push(monsterId);
		}
		
		private function hasOthers(i:int):Boolean
		{
			var ix:int = floor[i].x;
			var iy:int = floor[i].y;
			if(ix == player.x && iy== player.y)
			{
				return true;
			}
			for each(var id:int in monsterArr)
			{
				var monster:RogueLikeMonster = $.npcManager.Monster[id];
				
				if(ix == monster.x && iy== monster.y)
				{
					return true;
				}
			}
			return false;
		}
		
		private function isInMap(p:Point):Boolean
		{
			if(!p)return false;
			for each(var obj:Object in floor)
			{
				if(p.x == obj.block.x && p.y == obj.block.y)
					return true;
			}
			
			for each(obj in roadRange)
			{
				if(p.x == obj.road.x && p.y == obj.road.y)
					return true;
			}
			return false;
		}
		
		private var attakeSound:Sound;
		private var backSound:Sound;
		private var awardSound:Sound;
		private var jumpSound:Sound;
		private var _innerSkinName:String = "inner.png";
		private var _defaultSkinName:String = "back.png";
		private var _defaultSkin:Bitmap;
		private var player:NpcMonster;
		private var roadRange:Array = [];
		private var floorRange:Array = [];
		private var monsterArr:Array = [];
		private var npcArr:Array = [];
		private var floor:Array = [];
		private var currentFloor:int = 0;
		private var myParent:GameBase;
		private var startPoint:Point = new Point(100,0);
		private var endPoint:Point = new Point(700,600);
		private var buttonRefresh:Button;
		private var downPoint:Point;
		private var upPoint:Point;
		private var allfloor:Array = [];
		
		private var infoText:TextField;
		private var _innerSkin:Bitmap;
		private var backSoundChannel:SoundChannel;
	}
}