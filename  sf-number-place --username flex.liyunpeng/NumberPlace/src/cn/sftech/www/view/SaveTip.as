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
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
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
			saveLvBtn.x = 91;
			saveLvBtn.y = 115;
			saveLvBtn.addEventListener(MouseEvent.CLICK,saveLvDataHandle);
			addChild(saveLvBtn);
			
			notSaveLvBtn = new SFMovieClip();
			notSaveLvBtn.backgroundImage = NotSaveLvBtnBackground;
			notSaveLvBtn.x = 81;
			notSaveLvBtn.y = 158;
			notSaveLvBtn.addEventListener(MouseEvent.CLICK,notSaveLvDataHandle);
			addChild(notSaveLvBtn);
			
			cancelSaveLvBtn = new SFMovieClip();
			cancelSaveLvBtn.backgroundImage = CancelSaveLvBtnBackground;
			cancelSaveLvBtn.x = 94;
			cancelSaveLvBtn.y = 208;
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
		
		private function removeSelf() : void
		{
			SFApplication.application.removeChild(this);
			cancelSaveLvBtn.removeEventListener(MouseEvent.CLICK,cancelHandle);
			saveLvBtn.removeEventListener(MouseEvent.CLICK,saveLvDataHandle);
			notSaveLvBtn.removeEventListener(MouseEvent.CLICK,notSaveLvDataHandle);
			System.gc();
		}
		
		private function cancelHandle(event : MouseEvent = null) : void
		{
			this.dispatchEvent(new SaveGameEvent(SaveGameEvent.CANCEL_SAVE));
			removeSelf();
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
			_model.userResolveArr = null;
			var dataManager : DataManager = new DataManager();
			dataManager.saveLvData();
			this.dispatchEvent(new SaveGameEvent(SaveGameEvent.NOT_SAVE));
			removeSelf();
		}
		
		private function saveHandle(event : SaveGameEvent) : void
		{
			SFApplication.application.removeEventListener(SaveGameEvent.SAVE_GAME_EVENT,saveHandle);
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