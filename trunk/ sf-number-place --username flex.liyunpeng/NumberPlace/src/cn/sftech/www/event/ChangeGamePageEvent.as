package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class ChangeGamePageEvent extends Event
	{
		
		public static const CHANGE_GAMEPAGE_EVENT : String = "changeGamePageEvent";
		
		public static const TO_LVLIST_PAGE : int = 0;
		
		public function ChangeGamePageEvent()
		{
			super(CHANGE_GAMEPAGE_EVENT);
		}
	}
}