package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class ChooseNumEvent extends Event
	{
		public static const CHOOSE_NUM_EVENT : String = "chooseNumEvent";
		
		public var data : uint;
		
		public function ChooseNumEvent(value : uint)
		{
			data = value;
			super(CHOOSE_NUM_EVENT);
		}
	}
}