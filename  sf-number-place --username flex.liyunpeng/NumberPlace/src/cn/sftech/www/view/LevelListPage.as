package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.GameConfig;
	import cn.sftech.www.util.DataManager;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	public class LevelListPage extends SFViewStack
	{
		private var backBtn : SFMovieClip;
		
		private var easyLevelPane : LevelListPane;
		
		private var normalLevelPane : LevelListPane;
		
		private var hardLevelPane : LevelListPane;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
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
			easyBtn.x = 70;
			easyBtn.y = 70;
			easyBtn.addEventListener(MouseEvent.CLICK,toEasyList);
			mainLevelList.addChild(easyBtn);
			var normalBtn : SFMovieClip = new SFMovieClip();
			normalBtn.backgroundImage = NormalBtnBackground;
			normalBtn.x = 70;
			normalBtn.y = 130;
			normalBtn.addEventListener(MouseEvent.CLICK,toNormalList);
			mainLevelList.addChild(normalBtn);
			var hardBtn : SFMovieClip = new SFMovieClip();
			hardBtn.backgroundImage = HardBtnBackground;
			hardBtn.x = 70;
			hardBtn.y = 190;
			hardBtn.addEventListener(MouseEvent.CLICK,toHardList);
			mainLevelList.addChild(hardBtn);
			
			easyLevelPane = new LevelListPane(GameConfig.EASY_TYPE);
			easyLevelPane.percentWidth = 100;
			easyLevelPane.percentHeight = 100;
			easyLevelPane.backgroundAlpha = 0;
			easyLevelPane.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toLevelListPage);
			
			var easyLevelList : LevelList = new LevelList();
			easyLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			easyLevelList.x = 0;
			easyLevelList.y = 28;
			easyLevelList.width = 243;
			easyLevelList.height = 268;
			easyLevelList.backgroundAlpha = 0;
			easyLevelPane.list = easyLevelList;
			addItem(easyLevelPane);
			
			normalLevelPane = new LevelListPane(GameConfig.NORMAL_TYPE);
			normalLevelPane.percentWidth = 100;
			normalLevelPane.percentHeight = 100;
			normalLevelPane.backgroundAlpha = 0;
			normalLevelPane.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toLevelListPage);
			
			var normalLevelList : LevelList = new LevelList();
			normalLevelList.x = 0;
			normalLevelList.y = 28;
			normalLevelList.width = 243;
			normalLevelList..height = 268;
			normalLevelList.backgroundAlpha = 0;
			normalLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			normalLevelPane.list = normalLevelList;
			addItem(normalLevelPane);
			
			hardLevelPane = new LevelListPane(GameConfig.HARD_TYPE);
			hardLevelPane.percentWidth = 100;
			hardLevelPane.percentHeight = 100;
			hardLevelPane.backgroundAlpha = 0;
			hardLevelPane.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toLevelListPage);
			
			var hardLevelList : LevelList = new LevelList();
			hardLevelList.x = 0;
			hardLevelList.y = 28;
			hardLevelList.width = 243;
			hardLevelList..height = 268;
			hardLevelList.backgroundAlpha = 0;
			hardLevelList.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			hardLevelPane.list = hardLevelList;
			addItem(hardLevelPane);
			
		}
		
		public function toEasyList(event : MouseEvent = null) : void
		{
			showHelp();
			easyLevelPane.buildLevelBtn(GameConfig.EASY_TYPE);
			this.selectedIndex = 1;
		}
		
		public function toNormalList(event : MouseEvent = null) : void
		{
			showHelp();
			normalLevelPane.buildLevelBtn(GameConfig.NORMAL_TYPE);
			this.selectedIndex = 2;
		}
		
		public function toHardList(event : MouseEvent = null) : void
		{
			showHelp();
			if(_model.buyLevel == 0) {
				var buyHardLvPage : BuyHardLvPage = new BuyHardLvPage();
				buyHardLvPage.percentWidth = 100;
				buyHardLvPage.percentHeight = 100;
				buyHardLvPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,hardLvHandle);
				hardLevelPane.addChild(buyHardLvPage);
			} else {
				hardLevelPane.buildLevelBtn(GameConfig.HARD_TYPE);
			}
			
			this.selectedIndex = 3;
		}
		
		private function showHelp() : void
		{
			if(_model.unlockLevel < 2) {
				ModelLocator.getInstance().popIntrPage();
				_model.unlockLevel = GameConfig.UNLOCK_INIT_LV;
				var dataManager : DataManager = new DataManager();
//				dataManager.saveCheck();
				dataManager.saveUnlockLevel();
//				_model.showHelpTip = false;
			}
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
		
		private function hardLvHandle(event : ChangePageEvent) : void
		{
			hardLevelPane.removeChild(event.currentTarget as DisplayObject);
			
			if(_model.buyLevel != 0) {
				hardLevelPane.buildLevelBtn(GameConfig.HARD_TYPE);
			} else {
				this.selectedIndex = 0;
			}
		}
	}
}