package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	public class GamePage extends SFContainer
	{
		private var gamePane : GamePane;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			this.backgroundImage = GamePageBackground;
			
			gamePane = new GamePane();
			gamePane.width = 243;
			gamePane.height = 268;
			gamePane.x = 0;
			gamePane.y = 26;
			gamePane.backgroundAlpha = 0;
			addChild(gamePane);
			
			var _backMainBtn : SFMovieClip = new SFMovieClip;
			_backMainBtn.backgroundImage = BackBtnBackground;
			_backMainBtn.x = 4;
			_backMainBtn.y = 4;
//			_backMainBtn.backgroundAlpha = 0;
			_backMainBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			addChild(_backMainBtn);
			
			var restartBtn : SFMovieClip = new SFMovieClip();
			restartBtn.backgroundImage = RestartBtnBackground;
			restartBtn.x = 4;
			restartBtn.y = 300;
			addChild(restartBtn);
			
			var prevStepBtn : SFMovieClip = new SFMovieClip();
			prevStepBtn.backgroundImage = PrevStepBtnBackground;
			prevStepBtn.x = 80;
			prevStepBtn.y = 300;
			addChild(prevStepBtn);
			
			var helpBtn : SFMovieClip = new SFMovieClip();
			helpBtn.backgroundImage = HelpBtnBackground;
			helpBtn.x = 144;
			helpBtn.y = 300;
			addChild(helpBtn);
			
		}
		
		public function startGame() : void
		{
			//创建游戏界面
			gamePane.initGame();
			gamePane.startGame(_model.currentLv);
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
		
	}
}