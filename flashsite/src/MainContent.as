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
		
		public var ef1:MovieClip;
		public var ef2:MovieClip;
		public var ef3:MovieClip;

		public var mEf1:MovieClip;
		public var mEf2:MovieClip;
		public var mEf3:MovieClip;
		
		private var efLayer:MovieClip;
		private var tid:int;

/*		拖尾1 x:789 y:140 爆炸2 x:745 y:220
		t4:x:939 y:32; b1:x:1000 y:240
		t2:917 y:141  b3:x:857 y:256
		t3:1053 y:186 b2:x:1053 y:537
		
		//===================================================
		t2 x:556 y:8  b2 x:388 y:256
		t3:x:664 y:44 b1:x:492 y:384  r:x:200 y:132
		t4:x:954 y:234  b3: x:725 y:360*/
		private var efArr:Array; //= [{'mc':'ef1','x':789,'y':50,'sacle':1},{'mc':'ef2','x':939,'y':32,'sacle':1},{'mc':'ef3','x':917,'y':141,'sacle':1}];
		
		private var mirrorEfArr:Array; //= [{'mc':'mEf1','x':556,'y':8,'sacle':-1},{'mc':'mEf2','x':664,'y':44,'sacle':-1},{'mc':'mEf3','x':954,'y':234,'sacle':-1}];
		
		public var timer:Timer;
		public var menuClickHandler:Function;

		private var tempEf0:MovieClip;
		private var tempEf1:MovieClip;
		private var tempEf2:MovieClip;
		private var tempEf3:MovieClip;
		private var tempEf4:MovieClip;
		private var tempEf5:MovieClip;
		
		private var r1:int;
		private var r2:int;
		private var r3:int;
		private var r4:int;
		
		public function MainContent() {
			efLayer = new MovieClip();
			addChild(efLayer);
			
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
			orignHomex = (stage.stageWidth - home.width)/2 + 100;
			orignHomey = (stage.stageHeight - home.height)/2;
			
			
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
		 *初始位置 
		 * 
		 */		
		public function initPostion(xml:XMLList):void{
			efArr = [];
			mirrorEfArr = [];
			var obj:Object;
			for each(var data:XML in xml){
				if(data.@id == 0){
					obj = {};
					obj.mc = data.@mc;
					obj.x = data.@x;
					obj.y = data.@y;
					obj.sacle = data.@sacle;
					efArr.push(obj);
				}
				if(data.@id == 1){
					 obj= {};
					obj.mc = data.@mc;
					obj.x = data.@x;
					obj.y = data.@y;
					obj.sacle = data.@sacle;
					mirrorEfArr.push(obj);
				}
			}
			initEf();
		}
		/**
		 *初始特效 
		 * 
		 */		
		public function initEf():void{
			if(ef1 && ef2 && ef3){
				ef1.addFrameScript(ef1.totalFrames - 1,function():void{ef1.stop();ef1.alpha = 0});
				ef2.addFrameScript(ef2.totalFrames -1,function():void{ef2.stop();ef2.alpha = 0});
				ef3.addFrameScript(ef3.totalFrames -1,function():void{ef3.stop();ef3.alpha = 0});
				mEf1.addFrameScript(mEf1.totalFrames - 1,function():void{mEf1.stop();mEf1.alpha = 0});
				mEf2.addFrameScript(mEf2.totalFrames -1,function():void{mEf2.stop();mEf2.alpha = 0});
				mEf3.addFrameScript(mEf3.totalFrames -1,function():void{mEf3.stop();mEf3.alpha = 0});
			}
			tid = setInterval(playEf,3000);
		}
		/**
		 *播放特效 
		 * 
		 */		
		private function playEf():void{
			//清空 特效层 
			while(efLayer.numChildren >0){
				MovieClip(efLayer.getChildAt(0)).stop();
				efLayer.removeChildAt(0);
			}
			efArr.sort(function(){return Math.random ()>.5});
			mirrorEfArr.sort(function(){return Math.random ()>.5});
			for (var i:int = 0; i < 2; i++) 
			{
				
				tempEf0 = this[efArr[i].mc];
				tempEf0.alpha = 1;
				tempEf0.gotoAndPlay(1);
				tempEf0.scaleX = efArr[i].sacle;
				tempEf0.x = efArr[i].x;
				tempEf0.y = efArr[i].y;
				
				tempEf1 = this[mirrorEfArr[i].mc];
				tempEf1.alpha = 1;
				tempEf1.gotoAndPlay(1);
				tempEf1.scaleX = mirrorEfArr[i].sacle;
				tempEf1.x = mirrorEfArr[i].x;
				tempEf1.y = mirrorEfArr[i].y;
				
				efLayer.addChild(tempEf0);
				efLayer.addChild(tempEf1);
			}
			
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
			//this.bitmap1.visible = true;
			//this.bitmap2.visible = true;
		}
		public function destroy():void{
			clearInterval(tid);
			timer.stop();
			this.efLayer.visible =this.ship1.visible = this.ship2.visible =this.home.visible =this.island1.visible = this.island2.visible  = false;
			//this.bitmap1.visible = false;
			//this.bitmap2.visible = false;
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
