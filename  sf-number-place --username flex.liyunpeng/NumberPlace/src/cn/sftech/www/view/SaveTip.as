package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.DataManager;
	
	import flash.events.MouseEvent;
	import flash.system.System;

	public class SaveTip extends SFMovieClip
	{
		private var saveLvBtn : SFMovieClip;
		
		private var notSaveLvBtn : SFMovieClip;
		
		private var cancelSaveLvBtn : SFMovieClip;
		
		public function SaveTip()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = SaveTipBackground;
			
			saveLvBtn = new SFMovieClip();
			saveLvBtn.backgroundImage = SaveLvBtnBackground;
			saveLvBtn.x = 70;
			saveLvBtn.y = 55;
			saveLvBtn.addEventListener(MouseEvent.CLICK,saveLvDataHandle);
			addChild(saveLvBtn);
			
			notSaveLvBtn = new SFMovieClip();
			notSaveLvBtn.backgroundImage = NotSaveLvBtnBackground;
			notSaveLvBtn.x = 60;
			notSaveLvBtn.y = 98;
			notSaveLvBtn.addEventListener(MouseEvent.CLICK,notSaveLvDataHandle);
			addChild(notSaveLvBtn);
			
			cancelSaveLvBtn = new SFMovieClip();
			cancelSaveLvBtn.backgroundImage = CancelSaveLvBtnBackground;
			cancelSaveLvBtn.x = 73;
			cancelSaveLvBtn.y = 148;
			cancelSaveLvBtn.addEventListener(MouseEvent.CLICK,cancelHandle);
			addChild(cancelSaveLvBtn);
		}
		
		private function cancelHandle(event : MouseEvent = null) : void
		{
			SFApplication.application.removeChild(this);
			cancelSaveLvBtn.removeEventListener(MouseEvent.CLICK,cancelHandle);
			saveLvBtn.removeEventListener(MouseEvent.CLICK,saveLvDataHandle);
			notSaveLvBtn.removeEventListener(MouseEvent.CLICK,notSaveLvDataHandle);
			System.gc();
		}
		
		private function saveLvDataHandle(event : MouseEvent) : void
		{
			var dataManager : DataManager = new DataManager();
			dataManager.saveLvData();
			cancelHandle();
		}
		
		private function notSaveLvDataHandle(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
			cancelHandle();
		}
		
	}
}