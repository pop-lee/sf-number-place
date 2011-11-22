package cn.sftech.www.view
{
	import cn.sftech.www.event.SuccessEvent;
	
	import flash.events.MouseEvent;

	public class SuccessPage extends SFMovieClip
	{
		private var okBtn : SFMovieClip;
		
		public function SuccessPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = SuccessPageBackground;
			
			okBtn = new SFMovieClip();
			okBtn.backgroundImage = OkBtnBackground;
			okBtn.x = 96;
			okBtn.y = 165;
			okBtn.addEventListener(MouseEvent.CLICK,okHandle);
			addChild(okBtn);
		}
		
		private function okHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new SuccessEvent());
			SFApplication.application.removeChild(this);
		}
	}
}