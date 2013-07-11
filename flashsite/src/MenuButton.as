package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import event.MenuEvent;
	
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class MenuButton extends MovieClip {
		public var btnLayer:MovieClip;
		private var _enabled:Boolean;
		public function MenuButton() {
			addEventListener(MouseEvent.MOUSE_OVER,overHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_OUT,outHandler,false,0,true);
			addEventListener(MouseEvent.CLICK,clickHandler,false,0,true);
			btnLayer.cacheAsBitmap = true;
			//btnLayer.alpha = 0;
			btnLayer.blendMode = BlendMode.SCREEN;
			
/*			var index:int;
			while (index < btnLayer.numChildren)
			{
				
				btnLayer.getChildAt(index).visible = false;
				index++;
			}*/
		}
		/**
		 *高亮显示 
		 * 
		 */		
		public function active():void{
			TweenLite.to(btnLayer, 0.3, {alpha:0.85, ease:Quad.easeInOut});
		}
		/**
		 *灰态显示 
		 * 
		 */		
		public function deactive():void{
			TweenLite.to(btnLayer, 0.3, {alpha:0, ease:Quad.easeInOut});
		}
		
		override public function get enabled():Boolean{
			return _enabled;
		}
		override public function set enabled(value:Boolean):void{
			_enabled = value;
			useHandCursor = value;
		}

		
		protected function overHandler(event:MouseEvent):void
		{
			if(!_enabled){
				return;
			}
			active();
		}
		protected function outHandler(event:MouseEvent):void
		{
			if(!_enabled){
				return;
			}
			deactive();
		}
		protected function clickHandler(event:MouseEvent):void
		{
			if(!_enabled){
				return;
			}
			dispatchEvent(new MenuEvent(MenuEvent.MENU_CLICKED));
		}
		public function selectActiveLayer(value:String) : void
		{
			var btn:DisplayObject
			var index:int = 0;
			while (index < btnLayer.numChildren)
			{
				
				btn = btnLayer.getChildAt(index);
				if (btn.name == value)
				{
					btn.visible = true;
				}
				else
				{
					btn.visible = false;
				}
				index ++;
			}
		}
	}
	
}
