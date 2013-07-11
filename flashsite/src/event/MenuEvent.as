package event
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const MENU_CLICKED:String = "menuClicked";
		public static const MENU_ACTIVE:String = "menuActived";
		public static const MENU_DEACTIVE:String = "menuDeactived";
		public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}