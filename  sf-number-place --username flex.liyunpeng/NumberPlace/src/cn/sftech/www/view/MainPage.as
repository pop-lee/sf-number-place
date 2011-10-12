package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	
	import flash.events.MouseEvent;
	
	public class MainPage extends SFContainer
	{
		public function MainPage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			this.backgroundImage = MainPageBackground;
			
			var startGameBtn : SFMovieClip = new SFMovieClip();
			startGameBtn.backgroundImage = StartGameBtnBackground;
			startGameBtn.x = 80;
			startGameBtn.y = 168;
//			startGameBtn.backgroundAlpha = 0;
			startGameBtn.addEventListener(MouseEvent.CLICK,startGameHandle);
			this.addChild(startGameBtn);
			
			var resumeGameBtn : SFMovieClip = new SFMovieClip();
			resumeGameBtn.backgroundImage = ResumeGameBtnBackground;
			resumeGameBtn.x = 80;
			resumeGameBtn.y = 198;
//			scoreListBtn.backgroundAlpha = 0;
			resumeGameBtn.addEventListener(MouseEvent.CLICK,resumeGameBtntHandle);
			this.addChild(resumeGameBtn);
			
			var gameIntrBtn : SFMovieClip = new SFMovieClip();
			gameIntrBtn.backgroundImage = GameIntrBtnBackground;
			gameIntrBtn.x = 80;
			gameIntrBtn.y = 228
//			intrGameBtn.backgroundAlpha = 0;
			gameIntrBtn.addEventListener(MouseEvent.CLICK,gameIntrHandle);
			this.addChild(gameIntrBtn);
			
			var exitBtn : SFMovieClip = new SFMovieClip();
			exitBtn.backgroundImage = ExitGameBtnBackground;
			exitBtn.x = 80;
			exitBtn.y = 258;
//			exitBtn.backgroundAlpha = 0;
			exitBtn.addEventListener(MouseEvent.CLICK,exitGameHandle);
			this.addChild(exitBtn);
		}
		
		private function startGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_GAME_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		private function resumeGameBtntHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_SCORELIST_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		private function gameIntrHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_INTR_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		private function exitGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.EXIT;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
	}
}