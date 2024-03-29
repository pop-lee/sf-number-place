package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.SaveGameEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.DataManager;
	
	import flash.events.MouseEvent;
	import flash.system.System;

	public class SaveTip extends SFMovieClip
	{
		private var saveLvBtn : SFMovieClip;
		
		private var notSaveLvBtn : SFMovieClip;
		
		private var cancelSaveLvBtn : SFMovieClip;
		
		private var okBtn : SFMovieClip;
		
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
			
			okBtn = new SFMovieClip();
			okBtn.backgroundImage = OkBtnBackground;
			okBtn.visible = false;
			okBtn.x = 60;
			okBtn.y = 98;
			okBtn.addEventListener(MouseEvent.CLICK,okHandle);
			addChild(okBtn);
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
			this.backgroundImage.gotoAndStop(2);
			saveLvBtn.visible = false;
			notSaveLvBtn.visible = false;
			cancelSaveLvBtn.visible = false;
			SFApplication.application.addEventListener(SaveGameEvent.SAVE_GAME_EVENT,saveHandle);
			var dataManager : DataManager = new DataManager();
			dataManager.saveLvData();
		}
		
		private function notSaveLvDataHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVE_ERROR));
			cancelHandle();
		}
		
		private function saveHandle(event : SaveGameEvent) : void
		{
			if(event.saveType == SaveGameEvent.SAVED) {
				this.backgroundImage.gotoAndStop(3);
				okBtn.visible = true;
			} else {
				this.backgroundImage.gotoAndStop(4);
				okBtn.visible = false;
				saveLvBtn.visible = true;
				notSaveLvBtn.visible = true;
			}
		}
		
		private function okHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVED));
			cancelHandle();
		}
		
	}
}