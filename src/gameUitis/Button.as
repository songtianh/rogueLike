package gameUitis
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class Button extends Sprite
	{
		public function Button(needText:Boolean = false,str:String = "")
		{
			super();
			this.buttonMode = true;
			this._needText = needText;
			this._text = str;
			this.addEventListener(MouseEvent.MOUSE_OVER,onClick);
			this.addEventListener(MouseEvent.MOUSE_OUT,onClick);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onClick);
			this.addEventListener(MouseEvent.MOUSE_UP,onClick);
			LoadDefaultSkin();
			LoadHoverSkin();
			addText();
		}
		
		private function LoadHoverSkin():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _hoverSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, hoverfinished);
			l.load(request);
		}
		
		private function LoadDefaultSkin():void
		{
			var l:Loader = new Loader();
			var request:URLRequest = new URLRequest('texture/img/' + _defaultSkinName);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultfinished);
			l.load(request);
		}
		
		protected function defaultfinished(event:Event):void
		{
			_defaultSkin = new Bitmap(event.target.content.bitmapData);
			_defaultSkin.x = _defaultSkin.y = 0;
			addChildAt(_defaultSkin,0);
			this.width = _defaultSkin.width;
			this.height = _defaultSkin.height;
		}
		
		protected function hoverfinished(event:Event):void
		{
			_hoverSkin = new Bitmap(event.target.content.bitmapData);
			_hoverSkin.x = _hoverSkin.y = 0;
			addChildAt(_hoverSkin,0);
			_hoverSkin.visible = false;
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if(!_hoverSkin || ! _defaultSkin)return;
			if(event.type == MouseEvent.MOUSE_OVER || event.type == MouseEvent.MOUSE_UP)
			{
				_hoverSkin.visible = true;
				_defaultSkin.visible = false;
			}
			else if(event.type == MouseEvent.MOUSE_OUT || event.type == MouseEvent.MOUSE_DOWN)
			{
				_hoverSkin.visible = false;
				_defaultSkin.visible = true;
			}
		}		
		
		public function setText(str:String):void
		{
			this._textInput.text = str;
		}
		
		private function addText():void
		{
			if(!_needText)return;
			_textInput = new TextField;
			_textInput.selectable = false;
			_textInput.mouseEnabled = false
			_textInput.textColor = 0xf0fff0;
			_textInput.text = _text;
			_textInput.height = 40;
			_textInput.width = 130;
			_textInput.y = 5;
			_textInput.scaleX = _textInput.scaleY = 1.2;
			
			if(_textInput.length == 4)
				_textInput.x = 30;
			addChild(_textInput);
		}
		
		private var _textInput:TextField 
		private var _needText:Boolean = false;
		private var _defaultSkin:Bitmap;
		private var _hoverSkin:Bitmap;
		private var _defaultSkinName:String = "bigbutton-red-default-skin.png";
		private var _hoverSkinName:String = "bigbutton-red-hover-skin.png";
		private var _text:String;
	}
}