package cn.sftech.www.view
{
	import flash.events.MouseEvent;

	public class LevelListPane extends SFContainer
	{
		public var _list : SFViewStack;
		
		private var backBtn : SFMovieClip;
		
		private var prevPageBtn : SFMovieClip;
		
		private var nextPageBtn : SFMovieClip;
		
		public function LevelListPane()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			backBtn = new SFMovieClip();
			backBtn.backgroundImage = BackBtnBackground;
			backBtn.x = 18;
			backBtn.y = 5;
			addChild(backBtn);
			
			prevPageBtn = new SFMovieClip();
			prevPageBtn.backgroundImage = prevPageBtnBackground;
			prevPageBtn.visible = false;
			prevPageBtn.x = 18;
			prevPageBtn.y = 298;
			prevPageBtn.addEventListener(MouseEvent.CLICK,prevPageHandle);
			addChild(prevPageBtn);
			
			nextPageBtn = new SFMovieClip();
			nextPageBtn.backgroundImage = nextPageBtnBackground;
			nextPageBtn.visible = true;
			nextPageBtn.x = 165;
			nextPageBtn.y = 298;
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
		
		private function checkBtnVisible() : void
		{
			prevPageBtn.visible = _list.selectedIndex == 0?false : true;
			nextPageBtn.visible = _list.selectedIndex == _list.numChildren-1?false : true;
		}
	}
}