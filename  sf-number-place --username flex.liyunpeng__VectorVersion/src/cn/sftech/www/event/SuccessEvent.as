package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class SuccessEvent extends Event
	{
		public static const SUCCESS_EVENT : String = "successEvent";
		
		public function SuccessEvent()
		{
			super(SUCCESS_EVENT);
		}
	}
}