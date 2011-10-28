package cn.sftech.www.util
{
	import cn.sftech.www.object.NumberBlock;
	
	import flash.display.MovieClip;

	public class GetNum
	{
		public function GetNum()
		{
		}
		
		public static function get(num : uint) : NumberBlock
		{
			return new NumberBlock(num);
		}
	}
}