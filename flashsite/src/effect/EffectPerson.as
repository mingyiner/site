﻿package effect
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;
	
	public class EffectPerson extends Sprite
	{
		public var mc:MovieClip
		private var w:Number;
		private var h:Number;
		public function EffectPerson(_mc:MovieClip)
		{
			mc = _mc;
			//mc.alpha = 0;
			_mc.x = 0;
			_mc.y = 0;
			addChild(mc);
			w = (Capabilities.screenResolutionX - mc.width);
			trace(w);
			//h = (Capabilities.screenResolutionY - mc.height)/2;
			super();
		}
		public function show(value:Boolean):void{
			value?light():gray();
		}
		public function light():void{
			TweenLite.killTweensOf(mc);
			mc.filters = null;			
		}
		public function gray():void{
			
			var mat:Array =[0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
			var colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
			mc.filters = [colorMat];

			//TweenLite.to(mc,0.2,{blurFilter:{blurX:10, blurY:10}});
		}
	
	}
}