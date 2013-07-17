package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class GameIntro extends MovieClip {
		
		public var bitmapData:GameInfoBitmapData;
		public var bitmap:Bitmap;
		public var bg:MovieClip;
		public var NAME:String = 'GameIntro';
		public var contentMc:MovieClip;
		public function GameIntro() {
			// constructor code
			
			bitmapData = new GameInfoBitmapData();
			bitmap = new Bitmap(bitmapData) 
			bitmap.x = -bitmapData.width/2;
			bitmap.y = -bitmapData.height/2;
			
			contentMc = new MovieClip();
			contentMc.addChild(bitmap);
			
			addChild(contentMc);
			bg = new MovieClip();
			addChildAt(bg,0);
			bg.addEventListener(MouseEvent.CLICK,removeFromStageHandler);
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE,removeFromStageHandler);
		}
		protected function removeFromStageHandler(event:Event):void
		{
			trace("removeGameInfo")
			trace(this.parent);
			bg.graphics.clear();
			TweenLite.killTweensOf(contentMc);
			TweenLite.to(contentMc, 0.5, {scaleX:1,scaleY:1,alpha:0,ease:Expo.easeOut});
			dispatchEvent(new Event('reomveFromList'));
		}
		
		protected function addToStageHandler(event:Event):void
		{
			//trace("addTostageHandler");
			contentMc.x = (stage.stageWidth - contentMc.width)/2+bitmapData.width/2 
			contentMc.y = (stage.stageHeight - contentMc.height)/2+bitmapData.height/2 
			//trace(contentMc.x ,contentMc.y)
			contentMc.scaleX = 0.1;
			contentMc.scaleY = 0.1;
			//initElements();
			TweenLite.killTweensOf(contentMc);
			TweenLite.to(contentMc,0.5, {scaleX:1,scaleY:1,alpha:1,ease:Expo.easeOut});
		}
		private function initElements():void{
			bg.graphics.clear();
			bg.graphics.beginFill(0x0,0.7);
			bg.graphics.drawRect(0,0,Consts.limitWidth(stage.stageWidth),stage.stageHeight);
			bg.graphics.endFill();
		}
		public function layout():void{
			var scale:Number = Consts.getStageScaleX(stage);
			TweenLite.to(bg,0.3,{width:Consts.limitWidth(stage.stageWidth)});
			TweenLite.to(bitmap,0.3,{scaleX:scale,scaleY:scale});
		}
	}
	
}
