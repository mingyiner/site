package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quad;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	import view.ViewContainerManager;
	
	
	public class LogoPage extends LayeredSprite {
		
		public var mainContent:MainContent;
		private var currentStage:Sprite;
		private var mainMenu:MainMenuBar;
		private var lastActivedButtonName:String;
		private var subStage:SubStage;
		private var subStageVisible:Boolean = false;
		private var fitArea:AutoFitArea;
		private static const SUB_STAGES:Object = {careerBtn:{file:"career.swf", data:null},gameInfoBtn:{file:"gameInfo.swf", data:null},visonBtn:{file:"vison.swf", data:null}};
		public  var haze:MovieClip;
		private var bgBitmapData:BitmapData;
		public var testBg:MovieClip;
		private var maskMc:MovieClip;
		public function LogoPage(content:MainContent,menu:MainMenuBar,bd:BitmapData) {
			super("firstContent");
			mainContent = content;
			mainContent.bitmapData = bd;
			bgBitmapData = bd;
			mainMenu = menu;
			
			var loading:Preloader = new Preloader();
			tip.addChild(loading);
			TweenLite.to(loading, 0, {autoAlpha:0});
			
			
			maskMc = new MovieClip();
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		private function addToStageHandler(e:Event):void{
			maskMc.graphics .clear();
			maskMc.graphics.beginFill(0x0,.6);
			maskMc.graphics.drawRect(0,0,Consts.limitWidth(stage.stageWidth),stage.stageHeight);
			maskMc.graphics.endFill();
			
			if(maskLay.numChildren == 0){
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0x0,.8);
				shape.graphics.drawRect(0,0,Consts.limitWidth(stage.stageWidth),stage.stageHeight);
				shape.graphics.endFill();
				maskLay.addChild(shape);
				TweenLite.to(maskLay.getChildAt(0),0,{autoAlpha:0});
			}
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			stage.addEventListener(Event.RESIZE, onResize, false, 0, true);
			maskMc.addEventListener(MouseEvent.CLICK,pageRemoveFromStageHandler);
			onResize();
		}
		public function onResize(event:Event = null) : void
		{
			Preloader(tip.getChildAt(0)).layout();
			mainContent.layout();
			mainMenu.layout();
			if (currentStage != null && currentStage != this)
			{
				if(currentStage is CareerPage){
					CareerPage(currentStage).layout();
				}
				if(currentStage is GameIntro){
					GameIntro(currentStage).layout();
				}
				//ILayoutable(currentStage).layout();
			}
			haze.alpha = 0.7;
			//mainMenu.x = -277//Math.abs(Consts.limitWidth(Capabilities.screenResolutionX) - mainMenu.width)/2;
			
			//fitArea = new AutoFitArea(this, 0, 0, Consts.limitWidth(stage.stageWidth),stage.stageHeight);
			//fitArea.attach(background, {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.TOP, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:Consts.MIN_HEIGHT, maxHeight:Consts.MAX_HEIGHT});			
			
			var scalex:Number = Consts.getStageScaleX(stage);
			//TweenLite.to(haze, 1, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
			haze.x = (Consts.limitWidth(stage.stageWidth) - haze.width )/2
			haze.y = stage.stageHeight - haze.height;
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		public function initializeWithData() : void
		{
			TweenLite.from(this, 5, {colorMatrixFilter:{brightness:4}, ease:Expo.easeOut});

			//background.addChild(testBg);
			content.addChild(mainContent);
			toppest.addChild(haze);
			toppest.addChild(mainMenu);
			//toppest.y = Cons
			mainMenu.btnClickHandler = menuButtonClicked;
			mainContent.btnClickHandler = menuButtonClicked;
			currentStage = this;
			
		}

		private function menuButtonClicked(e:MouseEvent) : void
		{

			if (lastActivedButtonName == e.target.name)
			{
				if (!subStageVisible)
				{
					
				}
				return;
			}
/*			if(e.currentTarget.name == "logoBtn"){
				
				mainContent.animatedIn();
				lastActivedButtonName = e.currentTarget.name;
				if (currentStage != null && currentStage != this && content.contains(currentStage))
				{
					//theOldStage.removeEventListener(SubStageEvent.SUBSTAGE_CLOSE, onSubStageCommand);
					TweenLite.to(currentStage, 0.15, {alpha:0, onComplete:function ():void					{
						//IMain(theOldStage).close();
						content.removeChild(currentStage);
						currentStage = null;
						return;
					}
					});
				}
				
			}
			var obj:Object = SUB_STAGES[e.target.name];
			if (!obj)
			{
				return;
			}
			var btn:MenuButton = mainMenu.getButton(lastActivedButtonName);
			if (btn)
			{
				btn.deactive();
				btn.enabled = true;
			}
			lastActivedButtonName = e.target.name;
			MenuButton(e.currentTarget).active();
			MenuButton(e.currentTarget).enabled = false;*/
			showSwfHandler(e.currentTarget.name)
		}
		private function showSwfHandler(name:String):void{
			var obj:Object;
			var pageName:String;
			lastActivedButtonName = name;
			switch(name)
			{
				case 'logoBtn':
					mainContent.animatedIn();
					if (currentStage != null && currentStage != this && content.contains(currentStage))
					{
						content.removeChild(currentStage);
						currentStage = this;
					}
					break;
				case 'gameInfoBtn':
					obj = SUB_STAGES['gameInfoBtn'];
					pageName = 'GameIntro';
					break;
				case 'careerBtn':
					obj = SUB_STAGES['careerBtn'];
					pageName = 'CareerPage';
					break;
				case 'visonBtn':
					//obj = SUB_STAGES['visonBtn'];

					break;
				default:
					return;
					break;
			}
			if(obj){
				loadSubStage(obj);
			}
		}
		private function pageRemoveFromStageHandler(e:Event):void{
			
			if (lastActivedButtonName != 'logoBtn'&& currentStage != null && currentStage != this && content.contains(currentStage))
			{
				currentStage.removeEventListener('reomveFromList',pageRemoveFromStageHandler);
				content.removeChild(currentStage);
			}
			lastActivedButtonName = 'logoBtn';
			currentStage = this;
			mainContent.animatedIn();
			if(content.contains(maskMc)){
				content.removeChild(maskMc);
			}
		}
		private function loadSubStage(obj:Object) : void
		{
			var loading:Preloader = tip.getChildAt(0) as Preloader;
			loading.setProgress(0);
			TweenLite.to(loading, 0.3, {autoAlpha:1, ease:Quad.easeOut});
			TweenLite.to(maskLay.getChildAt(0),0.3,{autoAlpha:1, ease:Quad.easeOut});
			mainContent.enabled = false;
			if (subStage == null)
			{
				subStage = new SubStage();
				subStage.addEventListener(LoaderEvent.PROGRESS, onSubStageLoadProgress);
				subStage.addEventListener(LoaderEvent.COMPLETE, onSubStageLoaded);
				subStage.addEventListener(LoaderEvent.ERROR, onSubStageLoadError);
			}
			else
			{
				subStage.disposeLoader();
			}
			subStage.stageAddress = Consts.resURL(obj.file);
			subStage.stageDataAddress = Consts.resURL(obj.data);
			subStage.load();
		}
		
		private function onSubStageLoadProgress(event:LoaderEvent) : void
		{
			Preloader(tip.getChildAt(0)).setProgress(subStage.progress);
		}
		
		private function onSubStageLoaded(event:LoaderEvent) : void
		{
			var theOldStage:Sprite;
			var e:* = event;
			TweenLite.to(Preloader(tip.getChildAt(0)), 0.3, {autoAlpha:0, ease:Quad.easeIn});
			TweenLite.to(maskLay.getChildAt(0),0.3,{autoAlpha:0,ease:Quad.easeIn});
			theOldStage = currentStage;
			var curStage:* = subStage.stageContent as Sprite;
			if(subStage.stageContent is CareerPage){
				CareerPage(subStage.stageContent).bg = new Bitmap(bgBitmapData);
			}
			//ViewContainerManager.instance.setPageView(subStage.stageContent.NAME,curStage);
			curStage.addEventListener('reomveFromList',pageRemoveFromStageHandler);
			//curStage.x = (stage.stageWidth - curStage.width)/2;
			//curStage.y = (stage.stageHeight - curStage.height)/2;
			content.addChild(maskMc);
			content.addChild(curStage);
			currentStage = curStage;
			subStageVisible = true;
			if (theOldStage != null && theOldStage != this)
			{
				TweenLite.to(theOldStage, 0.15, {alpha:0, onComplete:function ():void
				{
					theOldStage.removeEventListener('reomveFromList',pageRemoveFromStageHandler);
					content.removeChild(theOldStage);
					return;
				}
				});
			}
			mainContent.destroy();
			return;
		}
		
		private function onSubStageLoadError(event:LoaderEvent) : void
		{
			return;
		}

		public function close():void{
			
		}

	}
	
}
