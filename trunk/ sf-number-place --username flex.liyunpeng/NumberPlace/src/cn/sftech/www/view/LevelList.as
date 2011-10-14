package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.MouseEvent;

	public class LevelList extends SFViewStack
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var oldP : uint = 0;
		
		/**
		 * 创建相关等级的关卡列表
		 * @param type 
		 * GameConfig中的关卡标记
		 * --EASY_LV
		 * --NORMAL_LV
		 * 
		 */
		public function LevelList(type : uint)
		{
			super();
			init();
			buildLevelBtn(type);
		}
		
		private function init() : void
		{
			this.backgroundAlpha = 1;
			this.backgroundColor = 0xcccccc;
			
		}
		
		private function buildLevelBtn(type : uint) : void
		{
			var col : int = 4;
			var row : int = 4;
			var horizontalLeading : uint = 8;
			var verticalLeading : uint = 8;
			
			var base : uint = 0;
			for(var i : int = 1;i <= type;i++) {
				var lvBtn : LevelListBtn = new LevelListBtn();
				lvBtn.backgroundImage = NumberBlockBackground;
				if(type > GameConfig.EASY_LV) base += GameConfig.EASY_LV;
				if(type > GameConfig.NORMAL_LV) base += GameConfig.NORMAL_LV;
				
				lvBtn.level = base + i;
				lvBtn.addEventListener(MouseEvent.CLICK,selectLv);
				
				lvBtn.width = 40;
				lvBtn.height = 40;
				lvBtn.x = (i-1)%col*(lvBtn.width+horizontalLeading) + 30;
				lvBtn.y = int((i-1)/col)*(lvBtn.height + verticalLeading) + 30;
				
//				lvBtn.y = int(i/col)%row*(lvBtn.height + verticalLeading);
				
				var levelListPane : SFContainer;
//				if(int(i/col)%row == 0) {
//					levelListPane = new SFContainer;
//					levelListPane.backgroundColor = 0xcccccc;
//					levelListPane.percentWidth = 100;
//					levelListPane.percentHeight = 100;
//					this.addItem(levelListPane);
//				}
				this.addChild(lvBtn);
			}
		}
		
		private function selectLv(event : MouseEvent) : void
		{
			_model.currentLv = (event.currentTarget as LevelListBtn).level;
			this.dispatchEvent(new ChangeGamePageEvent());
		}
		
	}
}