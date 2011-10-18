package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.Event;
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
		}
		
		private function buildLevelBtn(type : uint) : void
		{
			var col : int = 4;
			var row : int = 4;
			var horizontalLeading : uint = 8;
			var verticalLeading : uint = 16;
			
			var base : uint = 0;
			if(type > GameConfig.EASY_LV) base += GameConfig.EASY_LV;
			if(type > GameConfig.NORMAL_LV) base += GameConfig.NORMAL_LV;
			for(var i : int = 1;i <= type;i++) {
				var lvBtn : LevelListBtn = new LevelListBtn();
				lvBtn.backgroundImage = NumberBlockBackground;
				
				lvBtn.level = base + i;
				lvBtn.addEventListener(MouseEvent.CLICK,selectLv);
				
				lvBtn.width = 40;
				lvBtn.height = 40;
				lvBtn.x = (i-1)%col*(lvBtn.width+horizontalLeading) + 30;
				lvBtn.y = int((i-1)/col)%row*(lvBtn.height + verticalLeading) + 30;
//				lvBtn.y = int((i-1)/col)*(lvBtn.height + verticalLeading) + 30;
				
				
				var levelListPane : SFContainer;
				if(int(i%(col*row)) == 1) {
					levelListPane = new SFContainer;
					levelListPane.backgroundAlpha = 0;
					levelListPane.percentWidth = 100;
					levelListPane.percentHeight = 100;
					
					this.addItem(levelListPane);
					
				}
				levelListPane.addChild(lvBtn);
			}
		}
		
		private function selectLv(event : MouseEvent) : void
		{
			_model.currentLv = (event.currentTarget as LevelListBtn).level;
			this.dispatchEvent(new ChangeGamePageEvent());
		}
		
	}
}