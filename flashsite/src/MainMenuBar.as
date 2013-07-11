﻿package  {
	
	import event.MenuEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	
	public class MainMenuBar extends MovieClip {
		
		public var careerBtn:MenuButton;
		public var introBtn:MenuButton;
		public var logoBtn:MovieClip;
		private var buttons:Dictionary;
		private var clickFun:Function;
		public function MainMenuBar() {
			var btn:MenuButton;
			var _loc_3:String = null;
			buttons = new Dictionary();
			buttons["introBtn"] = this.introBtn;
			buttons["careerBtn"] = this.careerBtn;

			for (var str:String in buttons)
			{
				MenuButton(buttons[str]).selectActiveLayer(str);
				MenuButton(buttons[str]).enabled = true;
				MenuButton(buttons[str]).addEventListener(MouseEvent.CLICK, buttonClicked, false, 0, true);
			}
			logoBtn.addEventListener(MouseEvent.CLICK, buttonClicked, false, 0, true);
		}
		private function buttonClicked(evt:MouseEvent):void{
			clickFun.call(null,evt);
			
		}
		public function set btnClickHandler(f:Function):void{
			clickFun = f;
		}
		public function get btnClickHandler():Function{
			return clickFun;
		}
		public function getButton(str:String) : MenuButton
		{
			return buttons[str] as MenuButton;
		}
		
	}
}
