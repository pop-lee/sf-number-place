package cn.sftech.www.view
{
	import cn.sftech.www.object.Block9;
	
	import flash.display.MovieClip;
	
	[Embed(source="access/mainPage.swf",symbol="focusIn")]
	public class FocusIn extends MovieClip
	{
		public function FocusIn()
		{
			super();
		}
		
		public function setFocus(block : Block9) : void
		{
			if(block) {
				this.x = block.x;
				this.y = block.y
				this.visible = true;
			} else {
				this.visible = false;
			}
		}
	}
}