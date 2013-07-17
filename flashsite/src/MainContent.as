package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class MainContent extends MovieClip implements ILayoutable {
		
		private var fitArea:AutoFitArea;
		public var home:MovieClip;
		public var island1:MovieClip;
		public var island2:MovieClip;
		public var ship1:MovieClip;
		public var ship2:MovieClip;
		private var orignHomex:Number;
		private var orignHomey:Number;
		
		private var bitmap1:Bitmap;
		private var bitmap2:Bitmap;
		private var bg:MovieClip;
		public var bitmapData:BitmapData;
		
		public var tuowei1:MovieClip;
		public var tuowei2:MovieClip;
		public var tuowei3:MovieClip;
		public var tuowei4:MovieClip;
		
		public var bomb1:MovieClip;
		public var bomb2:MovieClip;
		public var bomb3:MovieClip;
		private var efLayer:MovieClip;
		private var tid:int;
		
		private var twMC:MovieClip=null;
		private var bmMc:MovieClip=null;
		
		private var mtwMC:MovieClip=null;
		private	var mbmMc:MovieClip=null;
/*		拖尾1 x:789 y:140 爆炸2 x:745 y:220
		t4:x:939 y:32; b1:x:1000 y:240
		t2:917 y:141  b3:x:857 y:256
		t3:1053 y:186 b2:x:1053 y:537
		
		//===================================================
		t2 x:556 y:8  b2 x:388 y:256
		t3:x:664 y:44 b1:x:492 y:384  r:x:200 y:132
		t4:x:954 y:234  b3: x:725 y:360*/
		private var efArr:Array = [{tw:{'mc':'tuowei1','x':789,'y':140},bm:{'mc':'bomb2','x':745,'y':220}},
								   {tw:{'mc':'tuowei4','x':939,'y':32},bm:{'mc':'bomb1','x':1000,'y':240}},
								   {tw:{'mc':'tuowei2','x':917,'y':141},bm:{'mc':'bomb3','x':857,'y':256}},
								   {tw:{'mc':'tuowei3','x':1053,'y':186},bm:{'mc':'bomb2','x':1053,'y':537}}];
		
		private var mirrorEfArr:Array = [{tw:{'mc':'tuowei2','x':556,'y':8,'sacle':-1},bm:{'mc':'bomb2','x':388,'y':256}},
										 {tw:{'mc':'tuowei3','x':664,'y':44,'sacle':-1},bm:{'mc':'bomb1','x':492,'y':384}},
										 {tw:{'mc':'tuowei4','x':954,'y':234,'sacle':-1},bm:{'mc':'bomb3','x':725,'y':360}}];
		
		public var timer:Timer;
		public var menuClickHandler:Function;
		public function MainContent() {
			efLayer = new MovieClip();
			addChild(efLayer);
			
			//home.gameIntro.addEventListener(MouseEvent.CLICK,clickHandler);
			//home.careerBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			timer = new Timer(60);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function addToStageHandler(event:Event):void
		{
			
			TweenLite.from(this, 3, {colorMatrixFilter:{brightness:3}, ease:Expo.easeOut});

			bitmap1 = new Bitmap(bitmapData);
			bitmap1.x = 0;
			bitmap2 = new Bitmap(bitmapData);
			bitmap2.x = bitmap1.width;
			bitmap1.y = bitmap2.y = 0;
			addChildAt(bitmap1,0);
			addChildAt(bitmap2,1);
			orignHomex = (Capabilities.screenResolutionX - home.width)/2 + 100;
			orignHomey = (stage.stageHeight - home.height)/2;
			
			tid = setInterval(playEf,500);
			
			//fitArea = new AutoFitArea(this, 0, 0, Capabilities.screenResolutionX,stage.stageHeight);
			//fitArea.attach(bitmap1, {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.CENTER, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:800, maxHeight:Consts.MAX_HEIGHT});			
			
			//fitArea = new AutoFitArea(this, 0, 0, Capabilities.screenResolutionX,stage.stageHeight);
			//fitArea.attach(bitmap2, {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.CENTER, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:800, maxHeight:Consts.MAX_HEIGHT});			
			
			//addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			//addEventListener(MouseEvent.MOUSE_OUT,function():void{home.stopDrag()});
			//addEventListener(MouseEvent.MOUSE_OVER,function():void{home.startDrag(false,new Rectangle(0,0,Capabilities.screenResolutionX,stage.stageHeight))});
			timer.start();
		}
		/**
		 *播放特效 
		 */	
		private var len1:int=0;
		private var len2:int=0;
		private function playEf():void{
			//清空 特效层 
			while(efLayer.numChildren >0){
				efLayer.removeChildAt(0);
			}
			len1= Math.random()*(efArr.length);
			len2= Math.random()*(mirrorEfArr.length);
			
			twMC = this[efArr[len1].tw.mc];
			bmMc = this[efArr[len1].bm.mc];
			twMC.scaleX = 1;
			twMC.alpha = 1;
			twMC.gotoAndPlay(1);
			//bmMc.stop()
			twMC.x = efArr[len1].tw.x;
			twMC.y = efArr[len1].tw.y;
			bmMc.x = efArr[len1].bm.x;
			bmMc.y = efArr[len1].bm.y;
			twMC.addFrameScript(twMC.totalFrames - 1,function():void{
				TweenLite.to(twMC,0.3,{alpha:0});
				twMC.stop();
				bmMc.gotoAndPlay(1)})
			
			mtwMC = this[mirrorEfArr[len2].tw.mc];
			mtwMC.scaleX = -1;
			mtwMC.gotoAndPlay(1);
			mtwMC.alpha = 1;
			mbmMc = this[mirrorEfArr[len2].bm.mc];
			mtwMC.addFrameScript(mtwMC.totalFrames - 1,function():void{
				mtwMC.stop();
				TweenLite.to(mtwMC,0.3,{alpha:0});
				mbmMc.gotoAndPlay(1)});
			mtwMC.x = mirrorEfArr[len2].tw.x;
			mtwMC.y = mirrorEfArr[len2].tw.y;
			mbmMc.x = mirrorEfArr[len2].bm.x;
			mbmMc.y = mirrorEfArr[len2].bm.y;
			
			efLayer.addChild(twMC);
			efLayer.addChild(bmMc);
			efLayer.addChild(mtwMC);
			efLayer.addChild(mbmMc);
		}
		private function timerHandler(evt:Event):void{
			enterFrameHandler();
		}
		private function enterFrameHandler(e:Event = null):void{
			//trace(stage.stageWidth);
			ship1.x +=0.8;
			if(ship1.x >= stage.stageWidth){
				ship1.x = 0;
			}
				
			ship2.x -=0.2
			if(ship2.x+ship2.width <=0){
				ship2.x = stage.stageWidth;
			}
			
			island1.x += 0.3;
			if(island1.x >= Consts.limitWidth(stage.stageWidth)){
				island1.x = 0;
			}
			
			island2.x +=0.3;
			if(island2.x >= Consts.limitWidth(stage.stageWidth)){
				island2.x = 0;
			}
			
			if(island2.x >= stage.stageWidth || island2.y >= 374){
				island2.x -= 0.1;
				island2.y -= 0.1;
			}
			var value:Number = -1 + stage.mouseX / Consts.limitWidth(stage.stageWidth) * 0.8;
			var svalue:Number = Consts.getStageScaleX(stage);
			var numx:Number = value * (-50 * svalue) + orignHomex * svalue;
			var numy:Number = value * (-50 * svalue) + orignHomey *svalue;
			home.x = home.x + (numx - home.x) * 0.1
			//TweenLite.to(home,0.03,{x:home.x + (numx - home.x) * 0.1});
			//TweenLite.to(home,0.03,{y:home.y +(numy - home.y)*0.1});
			home.y = home.y +(numy - home.y)*0.1 ;
			bitmap1.x -=1;
			bitmap2.x -=1;
			if(bitmap1.x+bitmap1.width <= 0){
				bitmap1.x = bitmap2.x + bitmap1.width;
			}
			if(bitmap2.x + bitmap2.width <= 0){	
				bitmap2.x = bitmap1.x + bitmap2.width;
			}
		}
		public function layout() : void
		{
			if (!stage)
			{
				return;
			}
			//fitArea.x = 0;
			//fitArea.y = 0;
			//fitArea.width = Capabilities.screenResolutionX;
			//fitArea.height =  Capabilities.screenResolutionY;
		}
		
		public function animatedIn():void{
			TweenLite.killTweensOf(this);
			tid = setInterval(playEf,2000);
			timer.start();
			this.efLayer.visible =this.ship1.visible = this.ship2.visible =this.home.visible =this.island1.visible = this.island2.visible  = true;
		}
		public function destroy():void{
			clearInterval(tid);
			timer.stop();
			this.efLayer.visible =this.ship1.visible = this.ship2.visible =this.home.visible =this.island1.visible = this.island2.visible  = false;
		}
		private function clickHandler(e:Event):void{
			menuClickHandler.call(null,e);
		}

		public function set btnClickHandler(f:Function):void{
			menuClickHandler = f;
		}
		public function get btnClickHandler():Function{
			return menuClickHandler;
		}
	}
}
