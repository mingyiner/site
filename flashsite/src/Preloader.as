package {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	
	public class Preloader extends MovieClip {

		private var loadingMc:Loading;
		private var lightLoadingMc:Loading;
		private var maskMc:MovieClip;
		private var txt:TextField;
		public function Preloader() {
			var mat:Array =[0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
			var colorMat:ColorMatrixFilter = new ColorMatrixFilter(mat);
			
			loadingMc = new Loading();
			addChild(loadingMc);
			loadingMc.filters = [colorMat];
			
			lightLoadingMc = new Loading();
			addChild(lightLoadingMc);
			
			maskMc = new MovieClip();
			maskMc.graphics.clear();
			maskMc.graphics.beginFill(0x0,1);
			maskMc.graphics.drawRect(0,0,loadingMc.width,loadingMc.height);
			maskMc.graphics.endFill();
			addChild(maskMc);
			
			lightLoadingMc.mask = maskMc;
			
			txt = new TextField();
			txt.width = 200;
			addChild(txt);
			txt.x = 50;
			txt.y =226 ;
		}
		
		public function setProgress(value:Number) : void
		{
			
			TweenLite.killTweensOf(maskMc);
			TweenLite.to(maskMc, 0.2, {scaleX:value, ease:Quad.easeInOut});
			txt.text = '正在为你努力加载'+ int(value * 100) + "%";
			if(value == 1){
				maskMc.scaleX = 1;
			}
			return;
		}
		public function layout() : void
		{
			
			if (!stage)
			{
				return;
			}
			var _width:Number = Consts.limitWidth(stage.stageWidth);
			var _height:Number = stage.stageHeight;
			this.x = (_width - this.width) / 2;
			this.y = (_height - this.height) / 2;
		}
	}
}
