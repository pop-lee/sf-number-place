package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.object.GameConfig;
	
	import flash.events.MouseEvent;

	public class LevelListPane extends SFContainer
	{
		public var _list : LevelList;
		
		private var backBtn : SFMovieClip;
		
		private var title : SFMovieClip;
		
		private var prevPageBtn : SFMovieClip;
		
		private var nextPageBtn : SFMovieClip;
		
		private var type : uint;
		
		public function LevelListPane(type : uint)
		{
			this.type = type;
			super();
			init();
		}
		
		private function init() : void
		{
			backBtn = new SFMovieClip();
			backBtn.backgroundImage = BackBtnBackground;
			backBtn.x = 4;
			backBtn.y = 4;
			backBtn.addEventListener(MouseEvent.CLICK,backHandle);
			addChild(backBtn);
			
			title = new SFMovieClip();
			title.backgroundImage = LevelTitleBackground;
			title.x = 165;
			title.y = 4;
			switch(type) {
				case GameConfig.EASY_LV:title.backgroundImage.gotoAndStop(2); break;
				case GameConfig.NORMAL_LV:title.backgroundImage.gotoAndStop(3); break;
			}
			addChild(title);
			
			
			prevPageBtn = new SFMovieClip();
			prevPageBtn.backgroundImage = prevPageBtnBackground;
			prevPageBtn.visible = false;
			prevPageBtn.x = 18;
			prevPageBtn.y = 300;
			prevPageBtn.addEventListener(MouseEvent.CLICK,prevPageHandle);
			addChild(prevPageBtn);
			
			nextPageBtn = new SFMovieClip();
			nextPageBtn.backgroundImage = nextPageBtnBackground;
			nextPageBtn.visible = true;
			nextPageBtn.x = 165;
			nextPageBtn.y = 300;
			nextPageBtn.addEventListener(MouseEvent.CLICK,nextPageHandle);
			addChild(nextPageBtn);
		}
		
		private function prevPageHandle(event : MouseEvent) : void
		{
			_list.selectedIndex --;
			checkBtnVisible()
		}
		
		private function nextPageHandle(event : MouseEvent) : void
		{
			_list.selectedIndex ++;
			checkBtnVisible();
		}
		
		public function set list(list : LevelList) : void
		{
			_list = list;
			addChild(_list);
		}
		
		public function buildLevelBtn(type : uint) : void
		{
			_list.buildLevelBtn(type);
			checkBtnVisible();
		}
		
		private function checkBtnVisible() : void
		{
			prevPageBtn.visible = _list.selectedIndex == 0?false : true;
			nextPageBtn.visible = _list.selectedIndex == _list.numChildren-1?false : true;
		}
		
		private function backHandle(event : MouseEvent) : void
		{
			_list.cleanBuild();
			this.dispatchEvent(new ChangeGamePageEvent());
		}
	}
}