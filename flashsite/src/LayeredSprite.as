package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class LayeredSprite extends Sprite
	{
		protected var layers:Dictionary;
		protected var nativeName:String;
		
		public function LayeredSprite(name:String)
		{
			this.nativeName = name;
			this.layers = new Dictionary();
			this.generateLayers();
			return;
		}
		
		override public function get name() : String
		{
			return nativeName;
		}
		
		override public function set name(param1:String) : void
		{
			this.nativeName = param1;
			return;
		}
		
		private function generateLayers() : void
		{
			this.layers["background"] = new Sprite();
			this.layers['contentMask'] = new Sprite();
			this.layers["content"] = new Sprite();
			this.layers["toppest"] = new Sprite();
			this.layers["tip"] = new Sprite();
			this.layers["mask"] = new Sprite();
			addChild(this.layers["background"] as Sprite);
			addChild(this.layers["contentMask"] as Sprite);
			addChild(this.layers["content"] as Sprite);
			addChild(this.layers["toppest"] as Sprite);
			addChild(this.layers["mask"] as Sprite);
			addChild(this.layers["tip"] as Sprite);
		}
		
		public function getLayer(name:String) : Sprite
		{
			return this.layers[name] as Sprite || null;
		}
		
		public function get background() : Sprite
		{
			return this.getLayer("background");
		}
		
		public function get content() : Sprite
		{
			return this.getLayer("content");
		}
		public function get contentMask() : Sprite
		{
			return this.getLayer("contentMask");
		}
		public function get toppest() : Sprite
		{
			return this.getLayer("toppest");
		}
		
		public function get tip() : Sprite
		{
			return this.getLayer("tip");
		}
		
		public function get maskLay():Sprite{
			return this.getLayer("mask");
		}
	}
}