package effect
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quad;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;
	
	import utils.ColorMatrix;
	
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
			mc.addEventListener(MouseEvent.ROLL_OVER,mouseHandler);
			mc.addEventListener(MouseEvent.ROLL_OUT,mouseHandler);
			mc.addEventListener(MouseEvent.CLICK,mouseHandler);
			super();
		}
		public function show(value:Boolean):void{
			value?light():gray();
		}
		public function light():void{
			TweenLite.killTweensOf(mc);
			TweenLite.to(mc, 0.1, {colorMatrixFilter:{saturation:1}, blurFilter:{blurX:0, blurY:0}, autoAlpha:1, ease:Quad.easeInOut});

			mc.filters = null;			
		}
		public function gray():void{
			
			//var mat:Array =[0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
			//var colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
			//mc.filters = [colorMat];

			var ld_Matrix:ColorMatrix=new ColorMatrix();
			ld_Matrix.adjustBrightness(-50);
			ld_Matrix.adjustSaturation(-20);
			ld_Matrix.adjustContrast(-70);
			//ld_Matrix.adjustBrightness();
			var ld_Filter:ColorMatrixFilter=new ColorMatrixFilter(ld_Matrix);
			
			//ld_Matrix.SetBrightnessMatrix;  //设置亮度值，值的大小是 -255--255   0为中间值，向右为亮向左为暗。
			
			//ld_Filter.matrix = ld_Matrix.GetFlatArray();
			
			mc.filters = [ld_Filter];
			TweenLite.to(mc, 0.1, {colorMatrixFilter:{saturation:0.3}, blurFilter:{blurX:4, blurY:4}, autoAlpha:1, ease:Quad.easeInOut});

			//TweenLite.to(mc,0.2,{blurFilter:{blurX:10, blurY:10}});
		}
		private function mouseHandler(e:MouseEvent):void{
			
		}
	}
}