package cn.sftech.www.model
{
	import cn.sftech.www.object.MapData;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Timer;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		/**
		 * 当前关数
		 */		
		public var currentLv : uint = 1;
		
		public var lvMapArr : Vector.<Object> = new Vector.<Object>();
		
		public var userResolveArr : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(9);
		
		public var isResolve : Boolean = true;
		
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