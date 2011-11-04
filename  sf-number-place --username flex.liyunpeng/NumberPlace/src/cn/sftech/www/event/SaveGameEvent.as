package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class SaveGameEvent extends Event
	{
		public static const SAVE_GAME_EVENT : String = "saveGameEvent";
		
		public static const SAVED : String = "saved";
		
		public static const SAVE_ERROR : String = "saveError";
		
		public static const NOT_SAVE : String = "notSave";
		
		public static const CANCEL_SAVE : String = "cancelSave"
		
		public var saveType : String;
		
		public function SaveGameEvent(type : String)
		{
			saveType = type;
			super(SAVE_GAME_EVENT);
		}
	}
}