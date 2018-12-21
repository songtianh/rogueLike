package gameUitis
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class GameUtil
	{
		static public function tween(s:Sprite,p:Point,delaytime:Number):void
		{
			s.x
		}
		
		static public function isImPact(shape1:Sprite,shape2:Sprite):Boolean
		{
			if(!shape1 || !shape2)return false;
			if(((shape1.x + shape1.width) >= shape2.x ) && (shape1.x <= (shape2.x + shape2.width)))
			{
				if(((shape1.y + shape1.height) >= shape2.y ) && (shape1.y <= (shape2.y + shape2.height)))
				{
					return true;
				}
			}
			return false;
		}
	}
}