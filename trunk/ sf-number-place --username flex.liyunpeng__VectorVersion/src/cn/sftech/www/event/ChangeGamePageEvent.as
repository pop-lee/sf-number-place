package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class ChangeGamePageEvent extends Event
	{
		
		public static const CHANGE_GAMEPAGE_EVENT : String = "changeGamePageEvent";
		
		public static const TO_LVLIST_PAGE : int = 0;
		
		public static const TO_GAMEPANEL_PAGE : int = 1;
		
		public var data : int;
		
		public function ChangeGamePageEvent()
		{
			super(CHANGE_GAMEPAGE_EVENT);
		}
	}
}