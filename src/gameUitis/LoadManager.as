package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	public class LoadManager
	{
		public function LoadImage(str):Loader
		{
			for(var i:int = 0; i < 99 ; i++)
			{
				LoadInfo[i] = new Loader();
				var request:URLRequest = new URLRequest('texture/img/' + str);
				LoadInfo[i].y = 200;
				LoadInfo[i].load(request);
				return LoadInfo[i]
			}
			return  null;
		}
		
		public function LoadSound(str):Sound
		{
			for(var i:int = 0; i < 99 ; i++)
			{
				LoadSoundInfo[i] = new Sound();
				var sound:Sound
				var buffer:SoundLoaderContext = new SoundLoaderContext(5000);     
				var request:URLRequest = new URLRequest('texture/sound/' + str + ".mp3");
				LoadSoundInfo[i].load(request,buffer);
				LoadSoundInfo[i].addEventListener(Event.COMPLETE, onComplete);
				return LoadSoundInfo[i]
			}
			return  null;
		}
		
		protected function onComplete(event:Event):void
		{
			event.target
		}		
		

		private var _img:Bitmap;
		private var LoadInfo:Dictionary = new Dictionary;
		private var LoadSoundInfo:Dictionary = new Dictionary;
	}
}