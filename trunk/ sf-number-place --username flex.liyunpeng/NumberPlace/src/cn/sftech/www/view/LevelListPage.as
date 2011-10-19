package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.MouseEvent;

	public class LevelListPage extends SFViewStack
	{
		private var backBtn : SFMovieClip;
		
		private var easyLevelList : LevelList;
		
		private var normalLevelList : LevelList;
		
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
			
			backBtn = new SFMovieClip();
			backBtn.backgroundImage = BackBtnBackground;
			backBtn.x = 4;
			backBtn.y = 4;
			backBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			mainLevelList.addChild(backBtn);
			
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
			easyLevelPane.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toLevelListPage);
			
			easyLevelList = new LevelList();
			easyLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			easyLevelList.x = 0;
			easyLevelList.y = 28;
			easyLevelList.width = 243;
			easyLevelList.height = 268;
			easyLevelList.backgroundAlpha = 0;
			easyLevelPane.list = easyLevelList;
			addItem(easyLevelPane);
			
			var normalLevelPane : LevelListPane = new LevelListPane();
			normalLevelPane.percentWidth = 100;
			normalLevelPane.percentHeight = 100;
			normalLevelPane.backgroundAlpha = 0;
			normalLevelPane.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toLevelListPage);
			
			normalLevelList = new LevelList();
			normalLevelList.x = 0;
			normalLevelList.y = 28;
			normalLevelList.width = 243;
			normalLevelList..height = 268;
			normalLevelList.backgroundAlpha = 0;
			normalLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			normalLevelPane.list = normalLevelList;
			addItem(normalLevelPane);
			
			var hardLevelList : LevelList = new LevelList();
			
		}
		
		private function toEasyList(event : MouseEvent) : void
		{
			this.selectedIndex = 1;
			easyLevelList.buildLevelBtn(GameConfig.EASY_LV);
		}
		
		private function toNoramlList(event : MouseEvent) : void
		{
			this.selectedIndex = 2;
			normalLevelList.buildLevelBtn(GameConfig.NORMAL_LV);
		}
		
		private function toGamePanel(event : ChangeGamePageEvent) : void
		{
			
			var changePageEvent : ChangeGamePageEvent = new ChangeGamePageEvent();
			changePageEvent.data = ChangeGamePageEvent.TO_GAMEPANEL_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function toLevelListPage(event : ChangeGamePageEvent) : void
		{
			this.selectedIndex = 0;
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		
	}
}