package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class DataManageEvent extends Event
	{
		public static const DATA_MANAGE_EVENT : String = "dataManageEvent";
		
		public function DataManageEvent()
		{
			super(DATA_MANAGE_EVENT);
		}
	}
}