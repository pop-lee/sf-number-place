package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class ChooseNumEvent extends Event
	{
		public static const CHOOSE_NUM_EVENT : String = "chooseNumEvent";
		
		public var data : String;
		
		public function ChooseNumEvent(value : String = null)
		{
			data = value;
			super(CHOOSE_NUM_EVENT);
		}
	}
}