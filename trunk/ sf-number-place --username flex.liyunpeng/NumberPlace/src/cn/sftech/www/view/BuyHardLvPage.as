package cn.sftech.www.view
{
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.DataManager;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BuyHardLvPage extends SFViewStack
	{
		private var coinsBar : CoinsBar;
		
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
			buyHardLvPane.addChild(coinsBar);
			
			var backBtn1 : SFMovieClip = new SFMovieClip();
			backBtn1.x = 4;
			backBtn1.y = 4;
			backBtn1.backgroundImage = BackBtnBackground;
			backBtn1.addEventListener(MouseEvent.CLICK,backLevelListPageHandle);
			buyHardLvError.addChild(backBtn1);
			
			var buyBtn : SFButton = new SFButton();
			buyBtn.backgroundImage = BuyHardLvBtn;
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
			
			var rBuyBtn : MovieClip = new RBuyBtn();
			rBuyBtn.x = 130;
			rBuyBtn.y = 280;
			rBuyBtn.addEventListener(MouseEvent.CLICK,buyHardLvHandle);
			buyHardLvError.addChild(rBuyBtn);
			
		}
		
		private function buyHardLvHandle(event : MouseEvent) : void
		{
//			var dataManager : DataManager = new DataManager();
//			dataManager.buyHardLevel();
			if(_model.currentCoins>=_model.price) {
				this.selectedIndex = 1;
			} else {
				this.selectedIndex = 2;
			}
			
		}
		
		private function toGamePageHandle(event : MouseEvent) : void
		{
			
		}
		
		private function rechargeHandle(event : MouseEvent) : void
		{
			
		}
		
		private function backLevelListPageHandle(event : MouseEvent) : void
		{
			
		}
		
		private function backBuyMainHandle(event : MouseEvent) : void
		{
			coinsBar.label.text = _model.currentCoins.toString();
		}

	}
}