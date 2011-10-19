package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class StartResolveEvent extends Event
	{
		public static const START_RESOLVE_EVENT : String = "startResolveEvent";
		
		public function StartResolveEvent()
		{
			super(START_RESOLVE_EVENT);
		}
	}
}