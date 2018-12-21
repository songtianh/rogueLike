package gameUitis
{
	public class NpcMonsterManager
	{
		public function getMonster(hpMax:Number = 20,attake:Number = 2,defense:Number = 3,controMode:int = 2):int
		{
			for(var i:int = 1; i<99 ; i++)
			{
				if(!_Monster[i])
				{
					_Monster[i] =new RogueLikeMonster(hpMax,attake,defense,GameConst.CAMP_TYPE_ENEMY,controMode);   
					
					return i;
				}
			}
			return -1;
		}
		
		public function getNpc(hpMax:Number = 10,attake:Number = 2,defense:Number = 2,controMode:int = 2):int
		{
			for(var i:int = 1; i<99 ; i++)
			{
				if(!_Npc[i])
				{
					_Npc[i] =new HanLing(hpMax,attake,defense,GameConst.CAMP_TYPE_NEUTRAL,controMode);   
					
					return i;
				}
			}
			return -1;
		}
		
		public function getHero(hpMax:Number = 10,attake:Number = 2,defense:Number = 2,controMode:int = 1):int
		{
			for(var i:int = 1; i<99 ; i++)
			{
				if(!_Npc[i])
				{
					_Npc[i] =new Hero(hpMax,attake,defense,GameConst.CAMP_TYPE_MINME,controMode);   
					
					return i;
				}
			}
			return -1;
		}
		public function clearMonseter(i):void
		{
			if(!_Monster[i])
			{
				throw new Error("没有发现此怪物");
				return;
			}
			(_Monster[i] as NpcMonster).dispose();
			_Monster[i] = null;
		}
		
		public function clearNpc(i):void
		{
			if(!_Npc[i])
			{
				throw new Error("没有发现此NPC");
				return;
			}
			(_Npc[i] as NpcMonster).dispose();
			_Npc[i] = null;
		}
		
		
		public function getDefenseMonster(type:int,hpMax:Number = 5,attake:Number = 1,defense:Number = 1,controMode:int = 0):int
		{
//			var type:int;
			for(var i:int = 1; i<999 ; i++)
			{
				if(!_Monster[i])
				{
//					type = Math.floor(Math.random()*10);
//					_Monster[i] =new defenseMonster(type,hpMax,attake,defense,controMode);   
					return i;
				}
			}
			return -1;
		}
		
		public function randomPosition(npc:NpcMonster):void
		{
			npc.x = Math.round(Math.random()*3)*25;
			npc.y = Math.round(Math.random()*3)*25;
		}
		public function get Monster():Array{return _Monster};
		public function get Npc():Array{return _Npc};
		private var _Monster:Array = [];
		private var _Npc:Array = [];
	}
}