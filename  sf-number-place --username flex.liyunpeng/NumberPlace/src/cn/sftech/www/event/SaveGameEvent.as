package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class SaveGameEvent extends Event
	{
		public static const SAVE_GAME_EVENT : String = "saveGameEvent";
		
		public static const SAVED : String = "saved";
		
		public static const SAVE_ERROR : String = "saveError";
		
		public var saveType : String;
		
		public function SaveGameEvent(type : String)
		{
			saveType = type;
			super(SAVE_GAME_EVENT);
		}
	}
}