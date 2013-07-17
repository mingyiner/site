package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import event.MenuEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	
	public class MainMenuBar extends MovieClip {
		
		public var logoBtn:MovieClip;
		public var gameInfoBtn:MovieClip;
		public var careerBtn:MovieClip;
		public var visonBtn:MovieClip;
		public var arrows:MovieClip;
		
		private var buttons:Dictionary;
		private var clickFun:Function;
		private var isShow:Boolean;
		private var tip:MovieClip;
		public function MainMenuBar() {
			
			buttons = new Dictionary();
			buttons['logoBtn'] = this.logoBtn;
			buttons["gameInfoBtn"] = this.gameInfoBtn;
			buttons["careerBtn"] = this.careerBtn;
			buttons['visonBtn'] = this.visonBtn;

			for (var str:String in buttons)
			{
				MovieClip(buttons[str]).buttonMode = true;
				MovieClip(buttons[str]).addEventListener(MouseEvent.CLICK, buttonClicked, false, 0, true);
			}
			arrows.buttonMode = true;
			arrows.addEventListener(MouseEvent.CLICK, arrowsClickHandler, false, 0, true);
			arrows.addEventListener(MouseEvent.ROLL_OVER, arrowsClickHandler, false, 0, true);
			//arrows.addEventListener(MouseEvent.ROLL_OUT, arrowsClickHandler, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE,addTostageHandler);
			visonBtn.addEventListener(MouseEvent.ROLL_OVER,tipHandler);
			visonBtn.addEventListener(MouseEvent.ROLL_OUT,tipHandler);
			
			tip = new MovieClip();
			addChild(tip);
			
			tip.mouseChildren = false;
			tip.mouseEnabled = false;
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.clear();
			mc.graphics.beginFill(0x0,0.5);
			mc.graphics.drawRect(0,0,100,20);
			mc.graphics.endFill();
			tip.addChild(mc);
			mc.x = visonBtn.x;
			mc.y = visonBtn.y-20;
			
			var txt:TextField = new TextField();
			txt.width = 100;
			txt.height = 18
			txt.text = '敬请期待';
			mc.addChild(txt);
		}
		
		protected function tipHandler(evt:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(evt.type == 'rollOver'){
				tip.visible = true;
			}else{
				tip.visible = false;
			}
			
		}
		
		protected function addTostageHandler(event:Event):void
		{
			
			layout();
			show();
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
		public function show():void{
			arrows.hide.visible = true;
			arrows.open.visible = false;
			isShow = true;
			TweenLite.to(this,0.3,{x:stage.stageWidth - this.width - 3,autoAlpha:1});
		}
		public function hide():void{
			isShow = false;
			arrows.hide.visible = false;
			arrows.open.visible = true;
			TweenLite.to(this,0.3,{x:stage.stageWidth-17,autoAlpha:1});
		}
		public function layout():void{
			tip.visible = false;
			if(!stage) return;
			var scale:Number = Consts.getStageScaleX(stage);
			//TweenLite.to(this, 1, {scaleX:scale, scaleY:scale, ease:Expo.easeOut});
			this.x = Consts.limitWidth(stage.stageWidth) - this.width*scale;
		}
		private function arrowsClickHandler(e:MouseEvent):void{
			isShow?hide():show();
		}
	}
}
