package cn.sftech.www.view
{
	import cn.sftech.www.event.CloseEvent;
	import cn.sftech.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
		
	public class IntrPage extends SFMovieClip
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function IntrPage()
		{
			super();
			init();
		}
		
		public function init() : void
		{
			this.backgroundImage = IntrPageBackground;
			this.backgroundImage.stop();
			this.addEventListener(MouseEvent.MOUSE_DOWN,nextPage);
		}
		
		private function nextPage(event : MouseEvent) : void
		{
			if(this.backgroundImage.totalFrames == this.backgroundImage.currentFrame) {
				exitIntr();
			} else {
				this.backgroundImage.nextFrame();
			}
		}
		
		private function exitIntr() : void
		{
			if(this.hasEventListener(MouseEvent.MOUSE_DOWN)) {
				this.removeEventListener(MouseEvent.MOUSE_DOWN,nextPage);
			}
			this.dispatchEvent(new CloseEvent());
		}
	}
}