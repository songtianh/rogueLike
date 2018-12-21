package gameUitis
{
	public class BuffManager
	{
		public function getBuff(id:int,npcMonster:NpcMonster,level:int = 1,beginTime:Number = 0,durTime:Number = 0):int
		{
			for(var i:int = 1; i<99 ; i++)
			{
				if(!_buff[i])
				{
					_buff[i] =new Buff(id,npcMonster,level,beginTime,durTime);   
					
					return i;
				}
			}
			return -1;
		}
		
		public function clearBuff(i):void
		{
			if(!_buff[i])
			{
				throw new Error("没有发现此BUFF");
				return;
			}
			_buff[i] = null;
		}
		
		public function get buff():Array{return _buff};
		private var _buff:Array = [];
	}
}