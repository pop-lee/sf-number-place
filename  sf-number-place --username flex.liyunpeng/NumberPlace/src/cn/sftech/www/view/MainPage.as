package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.model.ModelLocator;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class MainPage extends SFContainer
	{
		private var startGameBtn : SFMovieClip;
		
		private var resumeGameBtn : SFMovieClip;
		
		private var gameIntrBtn : SFMovieClip;
		
		private var exitBtn : SFMovieClip;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function MainPage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			this.backgroundImage = MainPageBackground;
			
			startGameBtn = new SFMovieClip();
			startGameBtn.backgroundImage = StartGameBtnBackground;
			startGameBtn.x = 80;
			startGameBtn.y = 168;
//			startGameBtn.backgroundAlpha = 0;
			startGameBtn.addEventListener(MouseEvent.CLICK,startGameHandle);
			this.addChild(startGameBtn);
			
			resumeGameBtn = new SFMovieClip();
			resumeGameBtn.backgroundImage = ResumeGameBtnBackground;
			if(_model.userResolveArr) {
				canResume(true);
			} else {
				canResume(false);
			}
			resumeGameBtn.x = 80;
			resumeGameBtn.y = 198;
//			scoreListBtn.backgroundAlpha = 0;
			resumeGameBtn.addEventListener(MouseEvent.CLICK,resumeGameBtntHandle);
			this.addChild(resumeGameBtn);
			
			gameIntrBtn = new SFMovieClip();
			gameIntrBtn.backgroundImage = GameIntrBtnBackground;
			gameIntrBtn.x = 80;
			gameIntrBtn.y = 228
//			intrGameBtn.backgroundAlpha = 0;
			gameIntrBtn.addEventListener(MouseEvent.CLICK,gameIntrHandle);
			this.addChild(gameIntrBtn);
			
			exitBtn = new SFMovieClip();
			exitBtn.backgroundImage = ExitGameBtnBackground;
			exitBtn.x = 80;
			exitBtn.y = 258;
//			exitBtn.backgroundAlpha = 0;
			exitBtn.addEventListener(MouseEvent.CLICK,exitGameHandle);
			this.addChild(exitBtn);
		}
		
		public function canResume(value : Boolean) : void
		{
			if(value) {
				(resumeGameBtn.backgroundImage as MovieClip).gotoAndStop(1);
			} else {
				(resumeGameBtn.backgroundImage as MovieClip).gotoAndStop(2);
			}
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
			changePageEvent.data = ChangePageEvent.TO_RESUME_PAGE;
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