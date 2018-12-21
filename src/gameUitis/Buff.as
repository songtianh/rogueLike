package gameUitis
{
	/**
	 * buff类
	 * */
	public class Buff
	{
		public function Buff(id:int,target:NpcMonster,level:int = 1,beginTime:Number = 1000,durTime:Number = 1000)
		{
			this.id = id;
			this.level = level;
			this.beginTime = beginTime;
			this.durTime = durTime;
			this.target = target;
		}
		
		public static const BUFF_TYPE_ICE:int = 1;      //减速buff
		public static const BUFF_TYPE_GUN:int = 1;		//暴击buff
		public static const BUFF_TYPE_POISION:int = 1;	//中毒buff
		private var id:int;
		private var level:int;
		private var beginTime:Number;//开始时间
		private var durTime:Number;//持续时间
		private var target:NpcMonster;
	}
}