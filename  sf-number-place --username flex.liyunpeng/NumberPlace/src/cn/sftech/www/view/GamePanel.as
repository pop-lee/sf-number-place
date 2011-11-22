package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.event.SaveGameEvent;
	import cn.sftech.www.event.StartResolveEvent;
	import cn.sftech.www.model.ModelLocator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GamePanel extends SFViewStack
	{
		private var gamePane : GamePane;
		
		private var saveTip : SaveTip;
		
		private var prevStepBtn : SFMovieClip
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function GamePanel()
		{
			super();
			init();
		}
		
		private function init():void
		{
			
			gamePane = new GamePane();
			gamePane.width = 243;
			gamePane.height = 268;
			gamePane.x = 0;
			gamePane.y = 26;
			gamePane.backgroundAlpha = 0;
			gamePane.addEventListener(ChangeGamePageEvent.CHANGE_GAMEPAGE_EVENT,successLv);
			gamePane.addEventListener(StartResolveEvent.START_RESOLVE_EVENT,startResolve);
			addChild(gamePane);
			
			var _backMainBtn : SFMovieClip = new SFMovieClip;
			_backMainBtn.backgroundImage = BackBtnBackground;
			_backMainBtn.x = 4;
			_backMainBtn.y = 2;
			//			_backMainBtn.backgroundAlpha = 0;
			_backMainBtn.addEventListener(MouseEvent.CLICK,saveTipHandle);
			addChild(_backMainBtn);
			
			var restartBtn : SFMovieClip = new SFMovieClip();
			restartBtn.backgroundImage = RestartBtnBackground;
			restartBtn.x = 4;
			restartBtn.y = 300;
			restartBtn.addEventListener(MouseEvent.CLICK,restartHandle);
			addChild(restartBtn);
			
			prevStepBtn = new SFMovieClip();
			prevStepBtn.backgroundImage = PrevStepBtnBackground;
			prevStepBtn.backgroundImage.gotoAndStop(2);
			prevStepBtn.x = 100;
			prevStepBtn.y = 300;
			prevStepBtn.addEventListener(MouseEvent.CLICK,prevStepHandle);
			addChild(prevStepBtn);
			
		}
		
		public function startGame() : void
		{
			//创建游戏界面
			gamePane.initGame();
			gamePane.startGame(_model.currentLv);
		}
		
		private function restartHandle(event : MouseEvent) : void
		{
			if(_model.isSuccess) return;
			cleanGamePane();
			_model.userResolveArr = null;
			gamePane.initGame();
			gamePane.startGame(_model.currentLv);
		}
		
		private function prevStepHandle(event : MouseEvent) : void
		{
			if(_model.isSuccess) return;
			gamePane.prevStep();
			if(_model.userResolveHistory.length == 0) {
				prevStepBtn.backgroundImage.gotoAndStop(2);
			}
		}
		
		private function startResolve(event : StartResolveEvent) : void
		{
			prevStepBtn.backgroundImage.gotoAndStop(1);
		}
		
//		private function toMainPage(event : MouseEvent) : void
//		{
//			var changePageEvent : ChangePageEvent = new ChangePageEvent();
//			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
//			SFApplication.application.dispatchEvent(changePageEvent);
//		}
		
		private function successLv(event : ChangeGamePageEvent) : void
		{
			_model.userResolveArr = null;
			var changeGamePageEvent : ChangeGamePageEvent = new ChangeGamePageEvent();
			changeGamePageEvent.data = event.data;
			this.dispatchEvent(changeGamePageEvent);
		}
		
		private function saveTipHandle(event : MouseEvent) : void
		{
			if(_model.isSuccess) return;
			if(_model.isStartPlay) {
				if(saveTip == null) {
					saveTip = new SaveTip();
					saveTip.addEventListener(SaveGameEvent.SAVE_GAME_EVENT,saveFinishHandle);
					SFApplication.application.addChild(saveTip);
				}
			} else {
				_model.userResolveArr = null;
				var changeGamePageEvent : ChangeGamePageEvent = new ChangeGamePageEvent();
				changeGamePageEvent.data = ChangeGamePageEvent.TO_LVLIST_PAGE;
				this.dispatchEvent(changeGamePageEvent);
			}
//			gameOverPage = new GameOverPage();
//			gameOverPage.addEventListener(GameOverEvent.GAME_OVER_EVENT,cleanGamePane);
//			gameOverPage.width = parentPage.width;
//			gameOverPage.height = parentPage.height;
//			gameOverPage.backgroundAlpha = .5;
//			SFApplication.application.addChild(gameOverPage);
		}
		
		public function cleanGamePane(event : GameOverEvent = null) : void
		{
			gamePane.cleanGamePane();
			prevStepBtn.backgroundImage.gotoAndStop(2);
		}
		
		private function saveFinishHandle(event : SaveGameEvent) : void
		{
			saveTip = null;
			if(event.saveType == SaveGameEvent.NOT_SAVE) {
				_model.userResolveArr = null;
			} else if(event.saveType == SaveGameEvent.CANCEL_SAVE) {
				return;
			}
			
			var changeGamePageEvent : ChangeGamePageEvent = new ChangeGamePageEvent();
			changeGamePageEvent.data = ChangeGamePageEvent.TO_LVLIST_PAGE;
			this.dispatchEvent(changeGamePageEvent);
		}
	}
}