package cn.sftech.www.model
{
	import cn.sftech.www.object.Block;
	import cn.sftech.www.object.MapData;
	import cn.sftech.www.object.NumberBlock;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Timer;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		/**
		 * 当前关数
		 */		
		public var currentLv : uint = 1;
		
		public var userSaveLv : uint = 1;
		
		public var lvMapArr : Vector.<Object> = new Vector.<Object>();
		
		//用户当前填写在面板上的解
		public var userResolveArr : Vector.<Object>;
		
		//以解锁的关数
		public var unlockLevel : uint = 20;
		
		//用户是否以开始玩本关，用来判断是否需要存储当前关
		public var isPlayLv : Boolean = false;
		//用户是当前解的违规状态 true代表没有违规的块 false代表有违规的块
		public var isResolve : Boolean = true;
		// 保存用户求解的历史
		public var userResolveHistory : Vector.<Block>;
		
		public var _currentFocus : NumberBlock;
		
		public function ModelLocator()
		{
			if(_model != null) {
				throw new IllegalOperationError("这是一个单例类，请使用getInstance方法来获取对象");
			}
		}
		
		public static function getInstance() : ModelLocator
		{
			return _model;
		}
		
	}
}