package cn.sftech.www.view
{
	import cn.sftech.www.event.ChooseNumEvent;
	import cn.sftech.www.object.NumberBlock;
	import cn.sftech.www.util.GetNum;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ChooseNumPane extends SFContainer
	{
		private const BtnSize : uint = 70;
		
		public function ChooseNumPane()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.width = 230;
			this.height = 230;
			this.visible = false;
			this.backgroundAlpha = 1;
			this.backgroundColor = 0x0000ff;
			var numBtn : NumberBlock;
			for(var i : int = 0;i < 3;i++) {
				for(var j : int = 0;j < 3;j++) {
					numBtn = null;
					numBtn = GetNum.get(i*3 + j + 1);
//					numBtn.data = i*3 + j + 1;
					numBtn.width = BtnSize;
					numBtn.height = BtnSize;
					numBtn.x = j * BtnSize;
					numBtn.y = i * BtnSize;
					numBtn.addEventListener(MouseEvent.CLICK,clickHandle);
					addChild(numBtn);
				}
			}
		}
		
		public function show() : void
		{
			this.visible = true;
		}
		
		private function clickHandle(event : MouseEvent) :void
		{
			this.dispatchEvent(new ChooseNumEvent(event.currentTarget.type));
			this.visible = false;
		}
	}
}