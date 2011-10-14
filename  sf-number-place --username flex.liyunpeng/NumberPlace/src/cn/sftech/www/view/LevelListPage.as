package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.MouseEvent;

	public class LevelListPage extends SFViewStack
	{
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
			
			var easyLevelList : LevelList = new LevelList(GameConfig.EASY_LV);
			easyLevelList.percentWidth = 100;
			easyLevelList.percentHeight = 100;
			easyLevelList.backgroundAlpha = 0;
			easyLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			addItem(easyLevelList);
			
			var normalLevelList : LevelList = new LevelList(GameConfig.NORMAL_LV);
			normalLevelList.percentWidth = 100;
			normalLevelList.percentHeight = 100;
			normalLevelList.backgroundAlpha = 0;
			normalLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			addItem(normalLevelList);
			
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