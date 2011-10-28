package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.MouseEvent;
	
	public class GamePage extends SFViewStack
	{
		private var levelListPage : LevelListPage;
		
		private var gamePanel : GamePanel;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = GamePageBackground;
			
			levelListPage = new LevelListPage();
			levelListPage.backgroundAlpha = 0;
			levelListPage.percentWidth = 100;
			levelListPage.percentHeight = 100;
			levelListPage.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,changeGamePageHandle);
			addItem(levelListPage);
			
			gamePanel = new GamePanel();
			gamePanel.backgroundAlpha = 0;
			gamePanel.percentWidth = 100;
			gamePanel.percentHeight = 100;
			gamePanel.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,changeGamePageHandle);
			addItem(gamePanel);
		}
		
		private function toMainPage(event : MouseEvent):void
		{
//			if(_model.currentScore > 0) {
//			} else {
				var changePageEvent : ChangePageEvent = new ChangePageEvent();
				changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
				SFApplication.application.dispatchEvent(changePageEvent);
//			}
		}
		
		private function changeGamePageHandle(event : ChangeGamePageEvent) : void
		{
			if(event.data == ChangeGamePageEvent.TO_GAMEPANEL_PAGE) {
				gamePanel.startGame();
			} else if(event.data == ChangeGamePageEvent.TO_LVLIST_PAGE) {
				if(_model.currentLv <= GameConfig.EASY_LV) {
					levelListPage.toEasyList();
				} else if(_model.currentLv <= GameConfig.NORMAL_LV + GameConfig.EASY_LV) {
					levelListPage.toNormalList();
				}
				gamePanel.cleanGamePane();
			}
			this.selectedIndex = event.data;
			
		}
		
		public function resumeGame() : void
		{
			_model.currentLv = _model.userSaveLv;
			
			var changeGamePageEvent : ChangeGamePageEvent = new ChangeGamePageEvent();
			changeGamePageEvent.data = ChangeGamePageEvent.TO_GAMEPANEL_PAGE;
			changeGamePageHandle(changeGamePageEvent);
		}
		
	}
}