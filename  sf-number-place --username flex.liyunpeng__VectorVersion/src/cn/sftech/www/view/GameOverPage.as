package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.DataManager;
	
	import com.qq.openapi.MttScore;
	
	import flash.events.MouseEvent;
	import flash.system.System;
	
	public class GameOverPage extends SFContainer
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var submitScoreTip : SubmitScoreTip;
		
//		private var submitBtn : SubmitBtn;
//		
//		private var canelBtn : CanelBtn;
//		
//		private var okBtn : OkBtn;
		
		public function GameOverPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			submitScoreTip = new SubmitScoreTip();
			submitScoreTip.x = 5;
			submitScoreTip.y = 192;
			addChild(submitScoreTip);
			
//			submitBtn = new SubmitBtn();
//			submitBtn.x = 12;
//			submitBtn.y = 284;
//			submitBtn.addEventListener(MouseEvent.CLICK,submitScore);
//			addChild(submitBtn);
//			
//			canelBtn = new CanelBtn();
//			canelBtn.x = 195;
//			canelBtn.y = 284;
//			canelBtn.addEventListener(MouseEvent.CLICK,canelSubmit);
//			addChild(canelBtn);
//			
//			okBtn = new OkBtn();
//			okBtn.x = 79;
//			okBtn.y = 284;
//			okBtn.addEventListener(MouseEvent.CLICK,okHandle);
		}
		
		public function submitScore(event : MouseEvent) : void
		{
//			submitBtn.visible = false;
//			canelBtn.visible = false;
			submitScoreTip.gotoAndStop(2);
			var dataManager : DataManager = new DataManager();
			dataManager.saveLvData();
		}
		
		private function canelSubmit(event : MouseEvent) : void
		{
			gameOver();
		}
		
		private function submitRequest(result : Object):void
		{
			//上传成功
			if(result.code == 0) {
				submitScoreTip.gotoAndStop(4);
//				addChild(okBtn);
//				MttScore.query(queryScoreHandle);
			} 
			//上传失败
			else {
				submitScoreTip.gotoAndStop(3);
//				submitBtn.visible = true;
//				canelBtn.visible = true;
			}
		}
		
		private function okHandle(event : MouseEvent) : void
		{
			gameOver();
		}
		
		private function gameOver() : void
		{
			removeSelf();
			this.dispatchEvent(new GameOverEvent());
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		
		private function removeSelf():void
		{
//			if(submitBtn.hasEventListener(MouseEvent.CLICK))
//				submitBtn.removeEventListener(MouseEvent.CLICK,submitScore);
//			if(canelBtn.hasEventListener(MouseEvent.CLICK))
//				canelBtn.removeEventListener(MouseEvent.CLICK,canelSubmit);
//			if(okBtn.hasEventListener(MouseEvent.CLICK))
//				okBtn.removeEventListener(MouseEvent.CLICK,okHandle);
			
			SFApplication.application.removeChild(this);
			System.gc();
		}
	}
}