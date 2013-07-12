package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	
	
	public class CareerPage extends MovieClip {
		
		private var careerContent:CareerContent;
		public function CareerPage(){
			careerContent = new CareerContent();
			addChild(careerContent);
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE,detroy);
		}
		
		protected function addToStageHandler(event:Event):void
		{
			TweenLite.killTweensOf(this);
			TweenLite.from(this, 0.5, {blurFilter:{blurX:80}, autoAlpha:0, x:80, ease:Expo.easeOut});

		}
		public function detroy(e:Event):void{
		
			//careerContent.personLogoBtn.destroy();
			//careerContent.orcLogoBtn.destroy();
			//careerContent.ghostLogoBtn.destroy();
		}
	}
	
}
