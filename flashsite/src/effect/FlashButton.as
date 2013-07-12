package effect
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FlashButton extends Sprite
	{
		public var btn:MovieClip;
		/**
		 *0人
		 *1兽
		 *2亡灵 
		 */		
		public var index:int;
		private var _enabled:Boolean;
		public function FlashButton(mc:MovieClip)
		{
			if(mc){
				btn = mc;
				btn.x = btn.y = 0;
				addChild(btn);
				addEventListener(MouseEvent.MOUSE_OVER,overHandler);
				addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			}
			super();
		}
		
		protected function outHandler(event:MouseEvent):void
		{
			//if(!_enabled){
				destroy();
			//}
		}
		
		protected function overHandler(event:MouseEvent):void
		{
			trace("start");
			startEffect();
		}
		public function startEffect():void{
			TweenLite.killTweensOf(btn);
			glowPlayBlurXBig();
		}
		private function glowPlayBlurXBig():void{
			TweenLite.to(btn,0.3,{glowFilter:{color:0xff9900,alpha:1,blurX:26,blurY:26,strength:2},onComplete:glowPlay});//
		}
		private function glowPlay():void{
			TweenLite.to(btn,1,{glowFilter:{color:0xff9900,alpha:1,blurX:2,blurY:2,strength:2},onComplete:glowPlayBlurXBig});//
		}
		public function stopEffect():void{
			btn.filters = null;
		}
		
		public function destroy():void{
			TweenLite.killTweensOf(btn);
			btn.filters = null;
		}
		public function set enabled(value:Boolean):void{
			_enabled = value;
			mouseEnabled = value;
			mouseChildren = value;
		}
		public function get enabled():Boolean{
			return _enabled;
		}
	}
}