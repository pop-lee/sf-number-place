package cn.sftech.www.view
{
	import cn.sftech.www.event.ChooseNumEvent;
	import cn.sftech.www.object.NumberBlock;
	import cn.sftech.www.util.GetNum;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.events.ModelChange;

	public class ChooseNumPane extends SFContainer
	{
		private const BtnWidth : uint = 50;
		private const BtnHeight : uint = 43;
		
		private var _cancelBtn : SFMovieClip;
		
		private var _closeBtn : SFMovieClip;
		
		public function ChooseNumPane()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = chooseNumberPaneBackground;
			
			this.width = 190;
			this.height = 190;
			this.visible = false;
			var numBtn : NumberBlock;
			for(var i : int = 0;i < 3;i++) {
				for(var j : int = 0;j < 3;j++) {
					numBtn = null;
					numBtn = GetNum.get(i*3 + j + 1);
//					numBtn.data = i*3 + j + 1;
					numBtn.width = BtnWidth;
					numBtn.height = BtnHeight;
					numBtn.x = j * (BtnWidth + 5) + 15;
					numBtn.y = i * (BtnHeight + 2) + 15;
					numBtn.addEventListener(MouseEvent.CLICK,clickHandle);
					addChild(numBtn);
				}
			}
			
			_cancelBtn = new SFMovieClip();
			_cancelBtn.backgroundImage = CancelChooseNumBtn;
			_cancelBtn.x = 15;
			_cancelBtn.y = 150;
			_cancelBtn.addEventListener(MouseEvent.CLICK,cancelHandle);
			addChild(_cancelBtn);
			
			_closeBtn = new SFMovieClip();
			_closeBtn.backgroundImage = CloseChooseNumBtn;
			_closeBtn.x = 131;
			_closeBtn.y = 150;
			_closeBtn.addEventListener(MouseEvent.CLICK,closeHandle);
			addChild(_closeBtn);
		}
		
		override public function show() : void
		{
			this.visible = true;
		}
		
		private function clickHandle(event : MouseEvent) :void
		{
			this.dispatchEvent(new ChooseNumEvent(event.currentTarget.type + ""));
			this.visible = false;
		}
		
		private function cancelHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new ChooseNumEvent(0 + ""));
			this.visible = false;
		}
		
		private function closeHandle(event : MouseEvent) : void
		{
			this.dispatchEvent(new ChooseNumEvent(null));
			this.visible = false;
		}
	}
}