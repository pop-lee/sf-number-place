package cn.sftech.www.object
{

	/**
	 * 用来存储当前用户 所保存的进度
	 * 保存的当前关数
	 * 保存的当前关 已填数据
	 * @author LiYunpeng
	 * 
	 */	
	public class UserLvData
	{
		/**
		 * 用户保存的当前关
		 */		
		public var saveLv : uint = 0;
		
		/**
		 * 用户保存的当前关以填入数字
		 */		
		public var userLvData : Vector.<Object>;
		
		public function UserLvData()
		{
		}
	}
}