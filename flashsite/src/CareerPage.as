package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	
	
	public class CareerPage extends MovieClip {
		
		public var careerContent:CareerContent;
		private var maskMc:MovieClip
		public var bg:Bitmap;
		private var fitArea:AutoFitArea;
		public var NAME:String = 'CareerPage';
		public function CareerPage(){
			careerContent = new CareerContent();
			addChild(careerContent);

			maskMc = new MovieClip;
			
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE,removeFromStageHandler);
			maskMc.addEventListener(MouseEvent.CLICK,removeFromStageHandler);
		}
		
		private function initElements():void{
			
			maskMc.graphics.clear();
			maskMc.graphics.beginFill(0x0,0.7);
			maskMc.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			maskMc.graphics.endFill();
			//addChildAt(maskMc,0);
		}
		protected function addToStageHandler(event:Event):void
		{
			if(bg){
				//addChildAt(bg,0);
				//fitArea = new AutoFitArea(this, 0, 0, Consts.limitWidth(stage.stageWidth),stage.stageHeight);
				//fitArea.attach(bg, {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.TOP, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:Consts.MIN_HEIGHT, maxHeight:Consts.MAX_HEIGHT});			
			}
			//initElements();
			layout();
			careerContent.x = stage.stageWidth;
			TweenLite.killTweensOf(this);
			TweenLite.to(careerContent, 0.5, {x:(Consts.limitWidth(stage.stageWidth) - careerContent.width)/2,alpha:1,ease:Expo.easeOut});
		
		}
		public function layout():void{
			if(bg){

				//careerContent.layout();
				//fitArea.x = 0;
				//fitArea.y = 0;
				//fitArea.width = Consts.limitWidth(stage.stageWidth);
				//fitArea.height = Consts.limitHeight(stage.stageHeight);
				var scalex:Number = Consts.getStageScaleX(stage);
				if(scalex >= 0.9){
					scalex = 1;
				}
				//TweenLite.to(maskMc, 0.5, {scaleX:scalex, ease:Expo.easeOut});
				TweenLite.to(careerContent,0.5,{scaleX:scalex,scaleY:scalex});
				TweenLite.delayedCall(0.5,function():void{
					//careerContent.y = stage.stageHeight - careerContent.height * scalex;
					//careerContent.x = (Consts.limitWidth(stage.stageWidth) - careerContent.width * scalex)/2;;
				})
			}
		}
		private function removeFromStageHandler(e:Event):void{
			maskMc.graphics.clear();
			//removeChild(bg);;
			TweenLite.killTweensOf(this);
			TweenLite.to(careerContent, 0.5, {x:0,alpha:0,ease:Expo.easeOut});
			dispatchEvent(new Event('reomveFromList'));
		}
	}
	
}
