﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	
	public class CareerPage extends MovieClip {
		
		private var careerContent:CareerContent;
		public function CareerPage(){
			careerContent = new CareerContent();
			addChild(careerContent);
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function addToStageHandler(event:Event):void
		{

		}
	}
	
}
