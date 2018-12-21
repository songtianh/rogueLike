package rogueLikeGame
{
	import flash.display.Sprite;
	
	import gameUitis.GameBase;
	
	public class RogueLike extends GameBase
	{
		public function RogueLike()
		{
			super();
		}
		
		override protected function initlize():void
		{
			super.initlize();
			var startScene:StartScene = new StartScene(this);
			currentScene = startScene;
			this.addChild(currentScene);
		}
		
		override protected function initaddto_stage():void
		{
			super.initaddto_stage();
			
			if(currentScene)
			{
				removeScene(currentScene)
			}
			currentScene = new MainScene(this,player);
			this.addChild(currentScene);
		}
		
		private function removeScene(currentScene:Sprite):void
		{
			this.removeChild(currentScene);
			currentScene = null;
		}
		
		override protected function changeNpcPosition(up:Boolean,down:Boolean,left:Boolean,right:Boolean):void
		{
			if(currentScene is MainScene)
			{
				(currentScene as MainScene).changeNpcPosition(up,down,left,right);
			}
		}
		private var currentScene:Sprite;
	}
}