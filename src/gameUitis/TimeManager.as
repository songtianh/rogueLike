package gameUitis
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class TimeManager
	{
		public function setTimer(delay:Number,handle:Function,repeatCount:int=0,param:Object = null):int
		{
			for(var i:int = 1; i<999 ; i++)
			{
				if(!TimeInfo[i])
				{
					TimeInfo[i] =new Timer(delay,repeatCount);  
					TimeInfo[i].addEventListener("timer", handle);//注意，事件timer必须全部小写  
					TimeInfo[i].start();  
					
					return i;
				}
			}
			return -1;
		}
		
		protected function handle1(event:TimerEvent):void
		{
			
		}
		
		public function clearTimer(taskId:int):void
		{
			if(!TimeInfo[taskId])
			{
				throw new Error("没有发现此定时器");
				return;
			}
			var timer:Timer = TimeInfo[taskId];
			timer.stop();
			timer = null;
		}
		
		private var TimeInfo:Dictionary = new Dictionary;
	}
}