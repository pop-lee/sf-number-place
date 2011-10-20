package cn.sftech.www.view
{
	
	import cn.sftech.www.event.ChangePageEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
//	[Embed(source="access/mainPage.swf",symbol="intrPage")]
	public class IntrPage extends SFContainer
	{
		private var _intr : String = "" +
			"游戏说明：\n" +
			"使用触摸屏操作游戏，第一次点击一个图案，这时此图案被选定，如果再次点击此图案则取消选定，如果不重复点击该图案，" +
			"而是找到另一个与此图案完全相同的图案并点击，同时保证两个图案之间的连接线在三条以内的情况下，则这对图案连接成功，并消失。"
//			"■将所有箱子推到目的地即为过关。\n" +
//			"■使用时间越少，则最后积分越高。\n" +
//			"■我们将记录玩家每一关的最高记录，以算去所有以解锁的关卡的总分数进行排名。";
		
		private var label : SFLabel;
		
		private var backMainBtn : SFMovieClip;
		
		private var tf : TextFormat = new TextFormat();
		
		public function IntrPage()
		{
			super();
//			init();
		}
		
		public function init() : void
		{
			label = new SFLabel();
			label.text = _intr;
			label.bold = true;
			label.wordWrap = true;
			label.color = 0xff0000;
			label.size = 14;
			label.width = 180;
			label.height = 220;
			label.x = 30;
			label.y = 50;
			addChild(label);
			
			
			backMainBtn = new SFMovieClip();
			backMainBtn.backgroundImage = BackBtnBackground;
			backMainBtn.x = 4;
			backMainBtn.y = 4;
			backMainBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			addChild(backMainBtn);
		}
		
		private function loadComplete(event : Event) :void
		{
//			this.backgroundImage = event.target.loader.content;
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			removeChild(label);
			label = null;
			if(backMainBtn.hasEventListener(MouseEvent.CLICK)) {
				backMainBtn.removeEventListener(MouseEvent.CLICK,toMainPage);
			}
			removeChild(backMainBtn);
			backMainBtn = null;
			System.gc();
			
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
	}
}