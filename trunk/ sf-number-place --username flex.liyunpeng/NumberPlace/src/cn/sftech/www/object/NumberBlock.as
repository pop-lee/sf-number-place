package cn.sftech.www.object
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class NumberBlock extends Block
	{
		public function NumberBlock(type : uint)
		{
			this.type = type;
			if(type != 0) this.backgroundImage = NumberBlockBackground;
			switch(type) {
				case 0:this.addChild(new Blank());break;
				case 1:this.addChild(new One());break;
				case 2:this.addChild(new Two());break;
				case 3:this.addChild(new Three());break;
				case 4:this.addChild(new Four());break;
				case 5:this.addChild(new Five());break;
				case 6:this.addChild(new Six());break;
				case 7:this.addChild(new Seven());break;
				case 8:this.addChild(new Eight());break;
				case 9:this.addChild(new Nine());break;
			}
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
	}
}