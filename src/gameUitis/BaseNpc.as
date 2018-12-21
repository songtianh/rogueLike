package gameUitis
{
	public class BaseNpc extends Role
	{
		public function BaseNpc(name:String,hpMax:Number=0, attake:Number=0, defense:Number=0, isFriend:int=GameConst.CAMP_TYPE_NEUTRAL, CONTROLNODE:int=2)
		{
			super(hpMax, attake, defense, isFriend, CONTROLNODE);
			this.name = name;
		}
		
		private var name:String;
	}
}