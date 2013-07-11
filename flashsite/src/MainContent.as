﻿package  {
	
	import com.greensock.TweenLite;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	
	public class MainContent extends MovieClip implements ILayoutable {
		
		private var fitArea:AutoFitArea;
		public var bg:MovieClip;
		public var home:MovieClip;
		public var island:MovieClip;
		public var ship:MovieClip;
		public function MainContent() {
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function addToStageHandler(event:Event):void
		{
			trace(stage.stageWidth);
			fitArea = new AutoFitArea(this, 0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			fitArea.attach(this.bg, {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.TOP, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:Consts.MIN_HEIGHT, maxHeight:Consts.MAX_HEIGHT});			
			
			home.x = (Capabilities.screenResolutionX - ship.width)/2 +100;
			home.y = (Capabilities.screenResolutionY - ship.height)/2;
			
			ship.x = Capabilities.screenResolutionX - ship.width;
			island.x = Capabilities.screenResolutionX - island.width;
		}
		
		public function layout() : void
		{
			if (!stage)
			{
				return;
			}
			fitArea.x = 0;
			fitArea.y = 0;
			fitArea.width = Capabilities.screenResolutionX;
			fitArea.height =  Capabilities.screenResolutionY;
		}
	}
}