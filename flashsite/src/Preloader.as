package {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.MovieClip;
	import flash.system.Capabilities;
	
	
	public class Preloader extends MovieClip {

		private var loadingMc:Loading;
		public function Preloader() {
			loadingMc = new Loading();
			addChild(loadingMc);
		}
		
		public function setProgress(value:Number) : void
		{
			
			TweenLite.killTweensOf(loadingMc.bar);
			TweenLite.to(loadingMc.bar, 0.2, {scaleX:value, ease:Quad.easeInOut});
			loadingMc.txt.text = int(value * 100) + "%";
			if(value == 1){
				loadingMc.bar.scaleX = 1;
			}
			return;
		}
		public function layout() : void
		{
			
			if (!stage)
			{
				return;
			}
			var _width:Number = Consts.limitWidth(Capabilities.screenResolutionX);
			var _height:Number = Consts.limitHeight(Capabilities.screenResolutionY);
			this.x = (_width - this.width) / 2;
			this.y = (_height - this.height) / 2;
			return;
		}
	}
}
