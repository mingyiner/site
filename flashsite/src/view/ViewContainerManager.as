package view
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	public class ViewContainerManager
	{
		private var views:Dictionary = new Dictionary();
		private static var _instance:ViewContainerManager;
		public static function get instance():ViewContainerManager{
			if(_instance == null){
				_instance = new ViewContainerManager();
			}
			return _instance;
		}
		public function ViewContainerManager()
		{
		}
		public function hasPageView(name:String):Boolean{
			return views[name]!= null;
		}
		public function getPageview(name:String):DisplayObject{
			return views[name];
		}
		public function setPageView(name:String,value:DisplayObject):void{
			views[name] = value;
		}
	}
}