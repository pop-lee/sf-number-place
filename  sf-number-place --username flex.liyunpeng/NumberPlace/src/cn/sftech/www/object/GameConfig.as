package cn.sftech.www.object
{
	public class GameConfig
	{
		public function GameConfig()
		{
		}
		
//		/**
//		 * 大块宽度
//		 */		
//		public static const BLOCK9_WIDTH : uint = 78;
//		
//		/**
//		 * 大块高度
//		 */		
//		public static const BLOCK9_HEIGHT : uint = 84;
		
		/**
		 * 每块的宽大小
		 */		
		public static const BLOCK_WIDTH : uint = 23;
		/**
		 * 每块的高大小
		 */
		public static const BLOCK_HEIGHT : uint = 25;
		
		/**
		 * 保存最多步数 
		 */		
		public static const HISTORY_COUNT : uint = 30;
//		/**
//		 * 小块留边宽高
//		 */		
//		public static const BLOCK_SPACING : uint = 2.5;
		
//		/**
//		 * 线条宽度
//		 */
//		public static const BLOCK_LINESIZE : uint = 1;
		
//		/**
//		 * 行列数
//		 */		
//		public static const NUMBER_RC : uint = 9;
		
		public static const EASY_TYPE : uint = 1;
		public static const NORMAL_TYPE : uint = 2;
		public static const HARD_TYPE : uint = 3;
		
		/**
		 * EASY级别的游戏关数
		 */		
		public static const EASY_LV : uint = 4;
		/**
		 * NORMAL级别游戏关数
		 */
		public static const NORMAL_LV : uint = 72;
		/**
		 * HARD级别游戏关数
		 */
		public static const HARD_LV : uint = 48;
		
		public static const UNLOCK_INIT_LV : uint = 5;
		
		public static const PAY_URL : String = "http://mpay.3g.qq.com/";
		
	}
}