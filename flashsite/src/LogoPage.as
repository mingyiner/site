﻿package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quad;
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	
	
	public class LogoPage extends LayeredSprite {
		
		private var mainContent:MainContent;
		private var currentStage:Sprite;
		private var mainMenu:MainMenuBar;
		private var lastActivedButtonName:String;
		private var subStage:SubStage;
		private var subStageVisible:Boolean = false;
		private var fitArea:AutoFitArea;
		private static const SUB_STAGES:Object = {careerBtn:{file:"career.swf", data:null}};
		public function LogoPage(content:MainContent,menu:MainMenuBar) {
			super("firstContent");
			mainContent = content;
			mainMenu = menu;

			var loading:Preloader = new Preloader();
			tip.addChild(loading);
			TweenLite.to(loading, 0, {autoAlpha:0});
			

			
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		private function addToStageHandler(e:Event):void{
			if(maskLay.numChildren == 0){
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0x0,.8);
				shape.graphics.drawRect(0,0,Capabilities.screenResolutionX,stage.stageHeight);
				shape.graphics.endFill();
				maskLay.addChild(shape);
				TweenLite.to(maskLay.getChildAt(0),0,{autoAlpha:0});
			}
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			stage.addEventListener(Event.RESIZE, onResize, false, 0, true);
			onResize();
		}
		private function onResize(event:Event = null) : void
		{
			Preloader(tip.getChildAt(0)).layout();
			mainContent.layout();
			if (currentStage != null && currentStage != this)
			{
				//ILayoutable(currentStage).layout();
			}
			mainMenu.x = -277//Math.abs(Consts.limitWidth(Capabilities.screenResolutionX) - mainMenu.width)/2;
			mainMenu.x = (Capabilities.screenResolutionX - mainMenu.width )/2
			//fitArea = new AutoFitArea(this, 0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			//fitArea.attach(mainMenu, {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.TOP, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:Consts.MIN_HEIGHT, maxHeight:Consts.MAX_HEIGHT});			
			mainMenu.y = stage.stageHeight - mainMenu.height;
			return;
		}
		public function initializeWithData() : void
		{
			TweenLite.from(this, 5, {colorMatrixFilter:{brightness:4}, ease:Expo.easeOut});

			content.addChild(mainContent);
			toppest.addChild(mainMenu);
			//toppest.y = Cons
			mainMenu.btnClickHandler = menuButtonClicked;
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
			if(e.currentTarget.name == "logoBtn"){
				
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
				
				//mainContent
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
			MenuButton(e.currentTarget).enabled = false;
			
			loadSubStage(obj);
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
			//subStage.stageContent.loaderInfo.applicationDomain.getDefinition('CareerContent')
			var curStage:* = subStage.stageContent as Sprite;
			content.addChild(curStage);
			//curStage.addEventListener(SubStageEvent.SUBSTAGE_CLOSE, onSubStageCommand);
			TweenLite.from(curStage, 0.5, {blurFilter:{blurX:80}, autoAlpha:0, x:80, ease:Expo.easeOut});
			currentStage = curStage;
			subStageVisible = true;
			if (theOldStage != null && theOldStage != this)
			{
				//theOldStage.removeEventListener(SubStageEvent.SUBSTAGE_CLOSE, onSubStageCommand);
				TweenLite.to(theOldStage, 0.15, {alpha:0, onComplete:function ():void
				{
					//IMain(theOldStage).close();
					content.removeChild(theOldStage);
					return;
				}
				});
			}
			//CareerPage(curStage).initializeWithData(subStage.stageData);
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
