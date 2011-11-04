package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.GameConfig;
	import cn.sftech.www.util.DataManager;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;

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
		public function LevelList()
		{
			super();
//			init();
//			buildLevelBtn(type);
		}
		
//		private function init() : void
//		{
//		}
		
		public function buildLevelBtn(type : uint) : void
		{
			var col : int = 4;
			var row : int = 4;
			var horizontalLeading : uint = 8;
			var verticalLeading : uint = 16;
			
//			cleanBuild();
			for(var i : int = 1;i <= type;i++) {
				var lvBtn : LevelListBtn = new LevelListBtn();
				lvBtn.backgroundImage = LevelBtnBackground;
				
				lvBtn.level = getBase(type) + i;
				var levelNum : LevelNum = new LevelNum();
				levelNum.label.selectable = false;
				levelNum.label.text = i.toString();
				lvBtn.addChild(levelNum);
				//未解锁的关显示
				if(lvBtn.level > _model.unlockLevel) {
					lvBtn.backgroundImage.gotoAndStop(2);
				//解锁的关显示
				} else {
					lvBtn.backgroundImage.gotoAndStop(1);
					lvBtn.addEventListener(MouseEvent.CLICK,selectLv);
					
				}
				
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
			
			this.selectedIndex = (Math.min(_model.unlockLevel,type) - getBase(type))/(col*row);
		}
		
		public function cleanBuild() : void
		{
			while(this.numChildren > 0) {
				for each(var child : LevelListBtn in this.getChildAt(0)) {
					if(child.hasEventListener(MouseEvent.CLICK)) {
						child.removeEventListener(MouseEvent.CLICK,selectLv);
					}
					removeChild(child);
					child = null;
				}
				removeChildAt(0);
			}
			System.gc();
		}
		
		private function selectLv(event : MouseEvent) : void
		{
			_model.currentLv = (event.currentTarget as LevelListBtn).level;
			_model.userResolveArr = null;
//			var dataManager : DataManager = new DataManager();
//			dataManager.saveCheck();
			this.dispatchEvent(new ChangeGamePageEvent());
			
			cleanBuild();
		}
		
		private function getBase(type : uint) : uint
		{
			var _base : uint = 0;
			if(type == GameConfig.EASY_LV) {
				
			}
			if(type == GameConfig.NORMAL_LV) {
				_base = GameConfig.EASY_LV;
			}
			return _base;
		}
	}
}