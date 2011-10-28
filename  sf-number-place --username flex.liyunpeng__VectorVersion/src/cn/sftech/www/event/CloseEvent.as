package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class CloseEvent extends Event
	{
		public static const CLOSE_EVENT : String = "closeEvent";
		
		public function CloseEvent()
		{
			super(CLOSE_EVENT);
		}
	}
}