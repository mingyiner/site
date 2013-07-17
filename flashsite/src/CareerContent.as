package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	
	import effect.EffectPerson;
	import effect.FlashButton;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.Capabilities;
	
	import flashx.textLayout.elements.IConfiguration;
	
	
	public class CareerContent extends MovieClip implements ILayoutable{
		
		public var careerMc:MovieClip;
		
		//public var bg:MovieClip;
		public var str:String = 'person';
		public var showContentMc:MovieClip;
		public function CareerContent() {
		

			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			trace("caree");
			showContentMc.otherIcon1.addEventListener(MouseEvent.CLICK,clickHandler);
			showContentMc.otherIcon2.addEventListener(MouseEvent.CLICK,clickHandler);
			
			showContentMc.otherIcon1.buttonMode = true;
			showContentMc.otherIcon2.buttonMode = true;
		}
		protected function addToStageHandler(event:Event):void
		{
			layout();
			setMcFrame(str);
			//initElements();
		}
		
		protected function clickHandler(evt:MouseEvent):void
		{
			var mc:MovieClip = evt.currentTarget as MovieClip;
			trace(mc.currentFrameLabel + "mc.currentFrameLabel");

			if(mc.currentFrameLabel == 'person'){
					animationOut('person');
				}
			if(mc.currentFrameLabel == 'orc'){
				animationOut('orc');
			}
			if(mc.currentFrameLabel == 'ghost'){
				animationOut('ghost');
			}
		}
		private function animationOut(str:String):void{
			TweenLite.killTweensOf(this);
			TweenLite.to(this,0.2,{x:0,alpha:0,onComplete:animationIn,onCompleteParams:[str]});
		}
		private function animationIn(str:String):void{
			setMcFrame(str)
			TweenLite.killTweensOf(this);
			this.x = stage.stageWidth;
			TweenLite.to(this,1,{x:(stage.stageWidth - this.width)/2,alpha:1})
		}
		private function setMcFrame(str:String):void{
			
			careerMc.gotoAndStop(str);
			showContentMc.desMc.gotoAndStop(str);
			showContentMc.currentIcon.gotoAndStop(str);
			showContentMc.nameMc.gotoAndStop(str);
			
			switch(str)
			{
				case 'person':
					showContentMc.otherIcon1.gotoAndStop('orc');
					showContentMc.otherIcon2.gotoAndStop('ghost');
					break;
				case 'orc':
					showContentMc.otherIcon1.gotoAndStop('person');
					showContentMc.otherIcon2.gotoAndStop('ghost');
					break;
				case 'ghost':
					showContentMc.otherIcon1.gotoAndStop('person');
					showContentMc.otherIcon2.gotoAndStop('orc');
					break;
				default:
					break;
			}
		}
		
		public function layout():void{
			//fitArea = new AutoFitArea(this, 0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			//fitArea.attach(this["bg"], {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.TOP, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:Consts.MIN_HEIGHT, maxHeight:Consts.MAX_HEIGHT});			
			
			//pContainerMc.x = 250//(Capabilities.screenResolutionX-pContainerMc.width)/2;

			zoomCharactersByScale(true);
		}
		private function zoomCharactersByScale(value:Boolean) : void
		{
			var useAnimation:Boolean = value;
			var scalex:Number = Consts.getStageScaleX(stage);
			var scaley:Number = Consts.getStageScaleY(stage);
			//showContentMc.y = 64
			//showContentMc.x = careerMc.x + careerMc.width;
			trace(scalex,scaley + "scale");
			if (useAnimation)
			{
				TweenLite.to(careerMc, 0.5, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
				TweenLite.to(showContentMc.desMc, 0.5, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
				TweenLite.to(showContentMc.nameMc, 0.5, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
				TweenLite.to(showContentMc.currentIcon, 0.5, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
				TweenLite.to(showContentMc.otherIcon1, 0.5, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
				TweenLite.to(showContentMc.otherIcon2, 0.5, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
				//TweenLite.to(showContentMc,1,{y:showContentMc.y + 64});
				trace(showContentMc.width + "showContentMc.width");

			}
		}
	}
}
