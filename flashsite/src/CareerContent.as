﻿package  {
	
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
	
	
	public class CareerContent extends MovieClip implements ILayoutable{
		
		/**
		 *人 logo
		 */		
		public var personLogo:MovieClip;
		/**
		 *兽 logo
		 */		
		public var orcLogo:MovieClip;
		/**
		 *亡灵 logo
		 */		
		public var ghostLogo:MovieClip;
		
		public var personLogoBtn:FlashButton;
		public var orcLogoBtn:FlashButton;
		public var ghostLogoBtn:FlashButton;
		
		private var effectPerson:EffectPerson;
		private var effectOrc:EffectPerson;
		private var effectGhost:EffectPerson;
		
		private var btnArr:Vector.<FlashButton>
		private var careerArr:Vector.<EffectPerson>;
		
		private var fitArea:AutoFitArea;
		
		public var personDes:MovieClip;
		public var ghostDes:MovieClip;
		public var orcDes:MovieClip;
		private var desArr:Vector.<MovieClip>;
		public var pContainerMc:MovieClip;
		
		public var midPersonArr:Object = {"orc":{'x':0,'y':95,"scale":0.7},"person":{'x':374,'y':0,"scale":1},"ghost":{'x':665,'y':85,"scale":0.7},'height':643};
		public var midOrcArr:Object = {"orc":{'x':110,'y':0,"scale":1},"person":{'x':0,'y':324,"scale":0.7},"ghost":{'x':764,'y':212,"scale":0.7},'height':783};
		public var midGhostArr:Object = {"orc":{'x':0,'y':236,"scale":0.7},"person":{'x':822,'y':330,"scale":0.7},"ghost":{'x':192,'y':0,"scale":1},'height':784};//784
		
		
		private var bg:MovieClip;
		public function CareerContent() {
		

			//========================按钮===========================
			personLogoBtn = new FlashButton(personLogo);
			personLogoBtn.index = 0;
			
			orcLogoBtn = new FlashButton(orcLogo);
			orcLogoBtn.index = 1;
			
			ghostLogoBtn = new FlashButton(ghostLogo);
			ghostLogoBtn.index = 2;
			
			addChild(personLogoBtn);
			addChild(ghostLogoBtn);
			addChild(orcLogoBtn);
			
			personLogoBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			orcLogoBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			ghostLogoBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			btnArr = new Vector.<FlashButton>();
			btnArr.push(personLogoBtn);
			btnArr.push(orcLogoBtn);
			btnArr.push(ghostLogoBtn);
			//====================人物========================

			effectPerson = new EffectPerson(pContainerMc.personMc);
			effectOrc = new EffectPerson(pContainerMc.orcMc);
			effectGhost = new EffectPerson(pContainerMc.ghostMc);
			
			pContainerMc.addChild(effectPerson);
			pContainerMc.addChild(effectOrc);
			pContainerMc.addChild(effectGhost);
			
			careerArr = new Vector.<EffectPerson>;
			careerArr.push(effectPerson);
			careerArr.push(effectOrc);
			careerArr.push(effectGhost);
			//=================介绍文字====================
			desArr = new Vector.<MovieClip>();
			desArr.push(personDes);
			desArr.push(orcDes);
			desArr.push(ghostDes);
			addChild(personDes);
			addChild(orcDes);
			addChild(ghostDes);
			//=======================背景====================
			bg = new MovieClip();
			addChildAt(bg,0);

			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE,removeFromStage);
			trace("caree");
		}
		protected function addToStageHandler(event:Event):void
		{
			layout();
			initElements();
		}
		
		protected function clickHandler(evt:MouseEvent):void
		{
			var index:int = FlashButton(evt.currentTarget).index;
			setSelctBtnIndex(index);			
		}
		/**
		 * 初始元素
		 * 默认 是人
		 */		
		private function initElements():void{
			
			bg.graphics.clear();
			bg.graphics.beginFill(0x0,0.7);
			bg.graphics.drawRect(0,0,Capabilities.screenResolutionX,stage.stageWidth);
			bg.graphics.endFill();
			setSelctBtnIndex(0);
		}
		private function setSelctBtnIndex(index:int):void{
			for (var i:int = 0; i < 3; i++) 
			{
				if(btnArr[i].index == index){
					btnArr[i].startEffect();
					btnArr[i].enabled = false;
					playCareer(index);
					TweenLite.to(desArr[i],0.4,{alpha:1,x:stage.stageWidth -desArr[i].width});
				}else{
					careerArr[i].gray();
					btnArr[i].destroy();
					btnArr[i].enabled = true;
					TweenLite.to(desArr[i],0.2,{alpha:0,x:stage.stageWidth,ease:Expo.easeOut});
				}
			}
			pContainerMc.x = (Capabilities.screenResolutionX-pContainerMc.width)/2;
		}
		/**
		 * 
		 * @param index	
		 *0人
		 *1兽
		 *2亡灵 
		 * 
		 */		
		private function playCareer(index:int):void{
			var obj:Object = {};
			switch(index)
			{
				case 0:
					obj = midPersonArr;
					break;
				case 1:
					obj = midOrcArr;
					break;
				case 2:
					obj = midGhostArr;
					break;

			}
			trace(index +"index");
		
			pContainerMc.y=stage.stageHeight - obj.height;
			TweenLite.to(effectPerson,0.5,{x:obj.person.x,y:obj.person.y,scaleX:obj.person.scale,scaleY:obj.person.scale});
			TweenLite.to(effectOrc,0.5,{x:obj.orc.x,y:obj.orc.y,scaleX:obj.orc.scale,scaleY:obj.orc.scale});
			TweenLite.to(effectGhost,0.5,{x:obj.ghost.x,y:obj.ghost.y,scaleX:obj.ghost.scale,scaleY:obj.ghost.scale})

			//TweenLite.delayedCall(0.6,function():void{
				//pContainerMc.y=stage.stageHeight - pContainerMc.height;
				//trace(pContainerMc.height +"pContainerMc.height");
			//})
			//pContainerMc.y=stage.stageHeight - obj.height;
			pContainerMc.setChildIndex(careerArr[index],pContainerMc.numChildren - 1);
			careerArr[index].light();
			
		}
		public function layout():void{
			//fitArea = new AutoFitArea(this, 0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			//fitArea.attach(this["bg"], {crop:true, scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE, hAlign:AlignMode.CENTER, vAlign:AlignMode.TOP, roundPosition:true, minWidth:Consts.MIN_WIDTH, maxWidth:Consts.MAX_WIDTH, minHeight:Consts.MIN_HEIGHT, maxHeight:Consts.MAX_HEIGHT});			
			
			//pContainerMc.x = 250//(Capabilities.screenResolutionX-pContainerMc.width)/2;
			for (var i:int = 0; i < 3; i++) 
			{
				btnArr[i].x = 100;
				btnArr[i].y = 200+(btnArr[i].height+30)*i;
			}
			zoomCharactersByScale(true);
		}
		private function zoomCharactersByScale(value:Boolean) : void
		{
			var useAnimation:Boolean = value;
			var scalex:Number = Consts.getStageScaleX(stage);
			var scaley:Number = Consts.getStageScaleY(stage);
			trace(scalex,scaley + "scale");
			if (useAnimation)
			{
				TweenLite.to(this.pContainerMc, 1, {scaleX:scalex, scaleY:scalex, ease:Expo.easeOut});
			}
		}// end function
		private function removeFromStage(e:Event):void{
			personLogoBtn.destroy();
			orcLogoBtn.destroy();
			ghostLogoBtn.destroy();
		}
	}
	
}
