﻿package  {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quad;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.CacheAsBitmapPlugin;
	import com.greensock.plugins.ColorMatrixFilterPlugin;
	import com.greensock.plugins.DropShadowFilterPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.SoundTransformPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	
	[SWF(height = '800')]
	public class Main extends MovieClip {
		
		private var loader:LoaderMax;
		/**
		 *进度条 
		 */		
		private var preLoader:Preloader;
		/**
		 * 主容器 放入所有SWF 
		 */		
		private var mainStage:Sprite;
		/**
		 *视频容器 
		 */		
		private var videoLayer:VideoContainer;
		
		private var startPointReached:Boolean;
		
		private var logoPage:LogoPage
		public function Main() {
			System.useCodePage = true;
			stop();
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		private function addToStageHandler(e:Event):void{
			initTween();
			initMc();
		}
		private function initMc():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, onResize, false, 0, true);
			
			mainStage = new Sprite();
			addChild(mainStage);
			
			preLoader = new Preloader();
			preLoader.x =(stage.stageWidth - preLoader.width)/2;
			preLoader.y = (stage.stageHeight - preLoader.height)/2;
			//preLoader.alpha = 0;
			addChild(preLoader);	
			
			TweenLite.to(preLoader, 0.2, {alpha:1, ease:Quad.easeOut});
			loader = new LoaderMax({auditSize:false});
			loader.addEventListener(LoaderEvent.CHILD_COMPLETE, onItemCompleted);
			loader.addEventListener(LoaderEvent.COMPLETE, onAllItemsCompleted);
			loader.addEventListener(LoaderEvent.PROGRESS, onLoadProgress);
			loader.addEventListener(LoaderEvent.IO_ERROR, onLoadError);
			loader.addEventListener(LoaderEvent.ERROR, onLoadError);
			loader.addEventListener(LoaderEvent.FAIL, onLoadError);
			loader.append(new SWFLoader(Consts.resURL("site.swf"), {name:"swfLoader"}));//加载主要的SWF
			///loader.append(new VideoLoader(Consts.resURL("resources/hs_video.flv"), {name:"videoLoader", bgColor:16777215, autoPlay:false}));//加载视频
			loader.load();
		}
		
		private function onLoadError(event:LoaderEvent) : void
		{
			//trace(event.text);
			return;
		}
		
		private function onItemCompleted(event:LoaderEvent) : void
		{
			//trace("item loaded... :" + event.target.name + " ::: " + (typeof(event.target)));
			return;
		}
		
		private function onLoadProgress(evt:LoaderEvent) : void
		{
			preLoader.setProgress(evt.target.progress);
			return;
		}
		
		private function onAllItemsCompleted(event:LoaderEvent) : void
		{
			trace("all items are ready, now get started...");
			TweenLite.killTweensOf(preLoader);
			TweenLite.to(preLoader, 0.5, {y:"-25", alpha:0, ease:Expo.easeIn, onComplete:removeLoading});
			return;
		}
		private function removeLoading():void{
			removeChild(preLoader);
			preLoader = null;
			loader.removeEventListener(LoaderEvent.CHILD_COMPLETE, onItemCompleted);
			loader.removeEventListener(LoaderEvent.COMPLETE, onAllItemsCompleted);
			loader.removeEventListener(LoaderEvent.PROGRESS, onLoadProgress);
			loader.removeEventListener(LoaderEvent.IO_ERROR, onLoadError);
			loader.removeEventListener(LoaderEvent.ERROR, onLoadError);
			loader.removeEventListener(LoaderEvent.FAIL, onLoadError);
			//setLogoAndOther();//设置logo等杂七杂八的东东 
			//videoStart(loader.getLoader("videoLoader") as VideoLoader);//播放视频 
			startPlayMainSwf();//开始播放SWF
		}
		private function setLogoAndOther():void{
			
		}
		private function videoStart(vLoader:VideoLoader) : void
		{
			videoLayer = new VideoContainer(vLoader);
			addChildAt(videoLayer, 1);
			vLoader.addEventListener(VideoLoader.PLAY_PROGRESS, videotimeChange);
			vLoader.addEventListener(VideoLoader.VIDEO_COMPLETE, videoEnd);
			vLoader.playVideo();
			return;
		}
		
		private function videotimeChange(event:Event) : void
		{
			var vLoader:VideoLoader= VideoLoader(event.target);
			if (vLoader.videoTime > vLoader.duration - 2.8 && !startPointReached)
			{
				videoLayer.overlayVisible = false;
			}
			if (vLoader.videoTime > vLoader.duration - 2.41 && !startPointReached)
			{
				startPointReached = true;
				videoLayer.visible = false;
				startPlayMainSwf();//开始播放SWF
			}
			return;
		}
		private function startPlayMainSwf() : void
		{
			//stage.removeEventListener(Event.RESIZE, onResize);
			var sloader:SWFLoader = loader.getLoader("swfLoader") as SWFLoader;
			var content:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition("MainContent") as Class;
			var menu:Class= sloader.rawContent.loaderInfo.applicationDomain.getDefinition("MainMenuBar") as Class;
			var bg:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition("SiteBackground") as Class;
			var tw1:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition('Tuowei1') as Class;
			var tw2:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition('Tuowei2') as Class;
			var tw3:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition('Tuowei3') as Class;
			var tw4:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition('Tuowei4') as Class;
			
			var bm1:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition("Bomb1") as Class;
			var bm2:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition("Bomb2") as Class;
			var bm3:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition("Bomb3") as Class;

			var haze:Class = sloader.rawContent.loaderInfo.applicationDomain.getDefinition("Haze") as Class;
			logoPage = new LogoPage(new content(),new menu(),new bg() as BitmapData);
			logoPage.haze = new haze() as MovieClip;
			logoPage.mainContent.tuowei1 = new tw1() as MovieClip;
			logoPage.mainContent.tuowei2 = new tw2() as MovieClip;
			logoPage.mainContent.tuowei3 = new tw3() as MovieClip;
			logoPage.mainContent.tuowei4 = new tw4() as MovieClip;
			
			logoPage.mainContent.bomb1 = new bm1() as MovieClip;
			logoPage.mainContent.bomb2 = new bm2() as MovieClip;
			logoPage.mainContent.bomb3 = new bm3() as MovieClip;
			
			//logoPage.mainContent.haze = new haze() as MovieClip;
			logoPage.initializeWithData();
			mainStage.addChild(logoPage);
			//var i:IMain = sloader.rawContent as IMain;
			//mainStage.addChild(sloader.rawContent);
			//i.initializeWithData();
			return;
		}
		private function videoEnd(event:LoaderEvent) : void
		{
			removeVideo();
			loader.dispose();
			return;
		}
		private function removeVideo():void{
			var vLoader:VideoLoader = loader.getLoader("videoLoader") as VideoLoader;
			vLoader.removeEventListener(VideoLoader.VIDEO_COMPLETE, videoEnd);
			vLoader.removeEventListener(VideoLoader.PLAY_PROGRESS, videotimeChange);
			videoLayer.destroy();
			removeChild(videoLayer);
		}
		private function initTween():void
		{
			LoaderMax.activate([XMLLoader, SWFLoader, VideoLoader, ImageLoader]);
			TweenPlugin.activate([AutoAlphaPlugin, ColorMatrixFilterPlugin, DropShadowFilterPlugin, SoundTransformPlugin, BlurFilterPlugin, GlowFilterPlugin]);
		}
		private function onResize(event:Event = null) : void
		{
			if (!stage)
			{
				return;
			}
			if(preLoader){
				preLoader.layout();
			}
			if(logoPage){
				logoPage.onResize();
			}
		}

	}
	
}
