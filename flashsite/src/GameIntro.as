package  {
	
	import flash.display.MovieClip;
	
	
	public class GameIntro extends MovieClip {
		
		public var bitmap:GameInfo;
		public function GameIntro() {
			// constructor code
			bitmap = new GameInfo();
			addChild(bitmap);
		}
	}
	
}
