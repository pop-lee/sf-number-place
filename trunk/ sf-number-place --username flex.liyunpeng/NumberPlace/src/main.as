package
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.MapData;
	import cn.sftech.www.util.DataManager;
	import cn.sftech.www.util.LevelMapData;
	import cn.sftech.www.util.LogManager;
	import cn.sftech.www.view.GamePage;
	import cn.sftech.www.view.IntrPage;
	import cn.sftech.www.view.MainPage;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFLogo;
	import cn.sftech.www.view.SFScoreList;
	import cn.sftech.www.view.SFViewStack;
	
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	[SWF(width="243",height="324")]
	public class main extends SFApplication
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		//主显示栈
		private var vs : SFViewStack = new SFViewStack();
		
		private var mainPage : MainPage;
		private var gamePage : GamePage;
		
		private var logo : SFLogo;
		
		public function main()
		{
		}
		
		override protected function init():void 
		{
			logo = new SFLogo();
			logo.width = this.width;
			logo.height = this.height;
			addChild(logo);
			
			MttService.initialize(root, "D5FE393C02DB836FFDE413B8794056ED","733");
			MttService.addEventListener(MttService.ETLOGOUT, onLogout);
			
			initData();
		}
		
		private function hideLogo(event : Event) : void
		{
			if(logo.alpha > 0.8) {
				logo.alpha -= 0.08;
			} else {
				this.removeEventListener(Event.ENTER_FRAME,hideLogo);
				removeChild(logo);
				logo = null;
			}
		}
		
		private function initData() : void
		{
			var dataManager : DataManager = new DataManager();
			SFApplication.application.addEventListener(SFInitializeDataEvent.INITIALIZE_DATA_EVENT,initializedData);
			dataManager.initData();
//			initializedData(new SFInitializeDataEvent());
		}
		
		private function initializedData(event : SFInitializeDataEvent) : void
		{
			initUI();
			setTimeout(hideLogoTime,1000);
		}
		private function hideLogoTime() : void
		{
			this.addEventListener(Event.ENTER_FRAME,hideLogo);
		}
		
		private function onLogout(e:Event):void
		{
			MttService.login();
		}
		
		private function initUI():void
		{
			vs.backgroundColor = 0x0000ff;
			vs.backgroundAlpha = 1;
			vs.percentWidth = 100;
			vs.percentHeight = 100;
			addChildAt(vs,0);
			
			
			SFApplication.application.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			
			mainPage = new MainPage();
			mainPage.percentWidth = 100;
			mainPage.percentHeight = 100;
			mainPage.backgroundAlpha = 0;
			vs.addItem(mainPage);
			
			gamePage = new GamePage();
			gamePage.percentWidth = 100;
			gamePage.percentHeight = 100;
			gamePage.backgroundAlpha = 0;
			vs.addItem(gamePage);
			
		}
		
		private function changePageHandle(event : ChangePageEvent):void
		{
			if(event.data == ChangePageEvent.TO_MAIN_PAGE) {
				if(_model.userResolveArr) {
					mainPage.canResume(true);
				} else {
					mainPage.canResume(false);
				}
			} else if(event.data == ChangePageEvent.TO_GAME_PAGE) {
//				_model.userResolveArr = null;
			} else if(event.data == ChangePageEvent.TO_RESUME_PAGE) {
				gamePage.resumeGame()
				event.data = ChangePageEvent.TO_GAME_PAGE;
			} else if(event.data == ChangePageEvent.TO_INTR_PAGE) {
				_model.popIntrPage();
				return;
			} else if(event.data == ChangePageEvent.EXIT) {
				MttService.exit();
				return;
			}
			vs.selectedIndex = event.data;
		}
		
	}
}