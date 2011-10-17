package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.MouseEvent;

	public class LevelListPage extends SFViewStack
	{
		private var backBtn : SFMovieClip;
		
		public function LevelListPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			var mainLevelList : SFContainer = new SFContainer();
			mainLevelList.backgroundAlpha = 0;
			mainLevelList.percentWidth = 100;
			mainLevelList.percentHeight = 100;
			addItem(mainLevelList);
			
			var easyBtn : SFMovieClip = new SFMovieClip();
			easyBtn.backgroundImage = EasyBtnBackground;
			easyBtn.x = 50;
			easyBtn.y = 50;
			easyBtn.addEventListener(MouseEvent.CLICK,toEasyList);
			mainLevelList.addChild(easyBtn);
			var normalBtn : SFMovieClip = new SFMovieClip();
			normalBtn.backgroundImage = NormalBtnBackground;
			normalBtn.x = 50;
			normalBtn.y = 100;
			normalBtn.addEventListener(MouseEvent.CLICK,toNoramlList);
			mainLevelList.addChild(normalBtn);
			
			var easyLevelPane : LevelListPane = new LevelListPane();
			easyLevelPane.percentWidth = 100;
			easyLevelPane.percentHeight = 100;
			easyLevelPane.backgroundAlpha = 0;
			
			var easyLevelList : LevelList = new LevelList(GameConfig.EASY_LV);
			easyLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			easyLevelList.x = 0;
			easyLevelList.y = 30;
			easyLevelList.width = 243;
			easyLevelList.height = 243;
			easyLevelList.backgroundAlpha = 1;
			easyLevelPane.list = easyLevelList;
			addItem(easyLevelPane);
			
			var normalLevelPane : LevelListPane = new LevelListPane();
			normalLevelPane.percentWidth = 100;
			normalLevelPane.percentHeight = 100;
			normalLevelPane.backgroundAlpha = 0;
			
			var normalLevelList : LevelList = new LevelList(GameConfig.NORMAL_LV);
			normalLevelList.x = 0;
			normalLevelList.y = 30;
			normalLevelList.width = 243;
			normalLevelList..height = 243;
			normalLevelList.backgroundAlpha = 1;
			normalLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			normalLevelPane.list = normalLevelList;
			addItem(normalLevelPane);
			
			var hardLevelList : LevelList = new LevelList(0);
			
		}
		
		private function toEasyList(event : MouseEvent) : void
		{
			this.selectedIndex = 1;
		}
		
		private function toNoramlList(event : MouseEvent) : void
		{
			this.selectedIndex = 2;
		}
		
		private function toGamePanel(event : ChangeGamePageEvent) : void
		{
			
			var changePageEvent : ChangeGamePageEvent = new ChangeGamePageEvent();
			changePageEvent.data = ChangeGamePageEvent.TO_GAMEPANEL_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
	}
}