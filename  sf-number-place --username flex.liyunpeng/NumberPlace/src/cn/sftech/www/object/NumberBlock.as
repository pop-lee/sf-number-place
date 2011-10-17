package cn.sftech.www.object
{
	import cn.sftech.www.view.SFTextField;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	import flashx.textLayout.formats.TextAlign;

	public class NumberBlock extends Block
	{
		private var num : MovieClip = new MovieClip();
		
		public function NumberBlock(type : uint)
		{
			this.type = type;
//			if(type != 0) this.backgroundImage = NumberBlockBackground;
			switch(type) {
				case 0:num = new Blank();break;
				case 1:num = new One();break;
				case 2:num = new Two();break;
				case 3:num = new Three();break;
				case 4:num = new Four();break;
				case 5:num = new Five();break;
				case 6:num = new Six();break;
				case 7:num = new Seven();break;
				case 8:num = new Eight();break;
				case 9:num = new Nine();break;
				default : num = new Blank();
			}
//			num.font = new GameConfig.font().fontName;
//			num.size = 18;
//			num.width = this.width;
//			num.height = this.height;
//			num.textAlign = TextAlign.CENTER;
//			num.text = type + "";
			addChild(num);
		}
		
		public function isOld() : void
		{
			(this.backgroundImage as MovieClip).gotoAndStop(2);
		}
		
		public function setData(x : int,y : int) : void
		{
			indexX = x;
			indexY = y;
		}
		
		/**
		 * 拷贝数字块的数据
		 * 1.拷贝x,y坐标
		 * 2.拷贝在二维数组中的索引
		 * @param block要拷贝的数字块
		 * 
		 */		
		public function copyData(block : NumberBlock) : void
		{
			indexX = block.indexX;
			indexY = block.indexY;
			this.x = block.x;
			this.y = block.y;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
//			backgroundImage.width = value;
//			num.width = value;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
//			backgroundImage.height = value;
//			num.height = value;
		}
	}
}