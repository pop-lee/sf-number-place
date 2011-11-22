package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.SaveGameEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.GameConfig;
	import cn.sftech.www.util.DataManager;
	
	import com.qq.openapi.MttService;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BuyHardLvPage extends SFViewStack
	{
		private var coinsBar : CoinsBar;
		
		private var buyBtn : BuyHardLvBtn;
		
		private var rBuyBtn : MovieClip;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function BuyHardLvPage()
		{
			super();
			
			init();
		}
		
		private function init() : void
		{
			
			var buyHardLvPane : SFContainer = new SFContainer();
			buyHardLvPane.backgroundImage = BuyHardLvMainPaneBackground;
			buyHardLvPane.percentWidth = 100;
			buyHardLvPane.percentHeight = 100;
			addItem(buyHardLvPane);
			
			var buyHardLvSuccess : SFContainer = new SFContainer();
			buyHardLvSuccess.backgroundImage = BuyHardLvSuccessBackground;
			buyHardLvSuccess.percentWidth = 100;
			buyHardLvSuccess.percentHeight = 100;
			addItem(buyHardLvSuccess);
			
			var buyHardLvError : SFContainer = new SFContainer();
			buyHardLvError.backgroundImage = BuyHardLvErrorBackground;
			buyHardLvError.percentWidth = 100;
			buyHardLvError.percentHeight = 100;
			addItem(buyHardLvError);
			
			coinsBar = new CoinsBar();
			coinsBar.x = 58;
			coinsBar.y = 31;
			coinsBar.label.text = _model.currentCoins.toString();
			buyHardLvPane.addChild(coinsBar);
			
			var backBtn1 : SFMovieClip = new SFMovieClip();
			backBtn1.x = 4;
			backBtn1.y = 4;
			backBtn1.backgroundImage = BackBtnBackground;
			backBtn1.addEventListener(MouseEvent.CLICK,backLevelListPageHandle);
			buyHardLvError.addChild(backBtn1);
			
			buyBtn = new BuyHardLvBtn();
			buyBtn.x = 33;
			buyBtn.y = 280;
			buyBtn.addEventListener(MouseEvent.CLICK,buyHardLvHandle);
			buyHardLvPane.addChild(buyBtn);
			
			var toGameBtn : MovieClip = new ToGamePageBtn();
			toGameBtn.x = 33;
			toGameBtn.y = 280;
			toGameBtn.addEventListener(MouseEvent.CLICK,toGamePageHandle);
			buyHardLvSuccess.addChild(toGameBtn);
			
			var backBtn2 : SFMovieClip = new SFMovieClip();
			backBtn2.x = 4;
			backBtn2.y = 4;
			backBtn2.backgroundImage = BackBtnBackground;
			backBtn2.addEventListener(MouseEvent.CLICK,backBuyMainHandle);
			buyHardLvError.addChild(backBtn2);
			
			var rechargeBtn : MovieClip = new RechargeBtn();
			rechargeBtn.x = 10;
			rechargeBtn.y = 280;
			rechargeBtn.addEventListener(MouseEvent.CLICK,rechargeHandle);
			buyHardLvError.addChild(rechargeBtn);
			
			rBuyBtn = new RBuyBtn();
			rBuyBtn.x = 130;
			rBuyBtn.y = 280;
			rBuyBtn.addEventListener(MouseEvent.CLICK,rBuyHandle);
			buyHardLvError.addChild(rBuyBtn);
			
		}
		
		private function buyHardLvHandle(event : MouseEvent) : void
		{
			buyBtn.visible = false;
			if(_model.currentCoins>=_model.price) {
				SFApplication.application.addEventListener(SaveGameEvent.SAVE_GAME_EVENT,buyHandle);
				var dataManager : DataManager = new DataManager();
				dataManager.buyHardLevel();
			} else {
				this.selectedIndex = 2;
			}
			
		}
		
		private function toGamePageHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new ChangePageEvent());
		}
		
		//跳转到充值页面
		private function rechargeHandle(event : MouseEvent) : void
		{
			MttService.jump(uint(GameConfig.PAY_URL),true);
		}
		
		private function rBuyHandle(event : MouseEvent) : void
		{
			rBuyBtn.visible = false;
			SFApplication.application.addEventListener(SaveGameEvent.SAVE_GAME_EVENT,buyHandle);
			
			var dataManager : DataManager = new DataManager();
			dataManager.buyHardLevel();
		}
		
		private function backLevelListPageHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new ChangePageEvent());
		}
		
		private function backBuyMainHandle(event : MouseEvent) : void
		{
			coinsBar.label.text = _model.currentCoins.toString();
			buyBtn.visible = true;
			this.selectedIndex = 0;
		}

		private function buyHandle(event : SaveGameEvent) : void
		{
			SFApplication.application.removeEventListener(SaveGameEvent.SAVE_GAME_EVENT,buyHandle);
			
			if(event.saveType == SaveGameEvent.SAVED) {
				this.selectedIndex = 1;
			} else {
				this.selectedIndex = 2;
				rBuyBtn.visible = true;
			}
		}
	}
}