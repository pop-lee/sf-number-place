package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	
	public class GamePage extends SFViewStack
	{
		private var levelListPage : LevelListPage;
		
		private var gamePanel : GamePanel;
		
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
			levelListPage.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,toGamePanel);
			addItem(levelListPage);
			
			gamePanel = new GamePanel();
			gamePanel.backgroundAlpha = 0;
			gamePanel.percentWidth = 100;
			gamePanel.percentHeight = 100;
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
		
		public function toGamePanel(event : ChangeGamePageEvent) : void
		{
			if(event.data == ChangeGamePageEvent.TO_GAMEPANEL_PAGE) {
				gamePanel.startGame();
			}
			this.selectedIndex = event.data;
		}
		
	}
}