package gameUitis
{
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import rogueLikeGame.MainScene;

	public class $
	{
		public function $(stage:Stage)
		{	
			timeManager = new TimeManager;
			loadManager = new LoadManager;
			npcManager = new NpcMonsterManager;
			buffManager = new BuffManager;
			$.stage = stage;
		}
		
		static public var
			timeManager:TimeManager,
			loadManager:LoadManager,
			buffManager:BuffManager,
			npcManager:NpcMonsterManager,
			stage:Stage,
			scene:MainScene,
			round:int = 0;
	}
}