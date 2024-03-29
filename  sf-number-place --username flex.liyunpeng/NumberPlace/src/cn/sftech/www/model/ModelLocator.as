package cn.sftech.www.model
{
	import cn.sftech.www.event.CloseEvent;
	import cn.sftech.www.object.Block;
	import cn.sftech.www.object.GameConfig;
	import cn.sftech.www.object.MapData;
	import cn.sftech.www.object.NumberBlock;
	import cn.sftech.www.view.IntrPage;
	import cn.sftech.www.view.SFApplication;
	
	import flash.errors.IllegalOperationError;
	import flash.system.System;
	import flash.utils.Timer;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		/**
		 * 当前关数
		 */		
		public var currentLv : uint = 1;
		
		public var userSaveLv : uint = 1;
		
		public var lvMapArr : Array = new Array();
		
		//描述数据类型 是普通的还是需要收费的
		public var mapDataClass : Class;
		
		//用户当前填写在面板上的解
		public var userResolveArr : Array;
		//当前模式是否为困难模式
		public var isHardType : Boolean = false;
		
		//以解锁的关数
		public var unlockLevel : uint = 1;
		//购买关卡
		public var buyLevel : uint = 0;
		//当前金币
		public var currentCoins : uint = 0;
		//道具价格
		public var price:uint = 0;
		//道具ID
		public var hardLvKeyId : uint = 0;
		
		//用户是否以开始玩本关，用来判断是否需要存储当前关
		public var isStartPlay : Boolean = false;
		//用户是当前解的违规状态 true代表没有违规的块 false代表有违规的块
		public var resolveIsTrue : Boolean = true;
		//当前关是否以完成
		public var isSuccess : Boolean = false;
		// 保存用户求解的历史
		public var userResolveHistory : Vector.<NumberBlock>;
		
		public var currentScore : uint = 0;
		
//		public var showHelpTip : Boolean = true;
		
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
		
		public function popIntrPage() : void
		{
			var _intrPage : IntrPage = new IntrPage();
			_intrPage.addEventListener(CloseEvent.CLOSE_EVENT,
				function closeHandle(event : CloseEvent) : void {
					var intrPage : IntrPage = event.currentTarget as  IntrPage;
					intrPage.removeEventListener(CloseEvent.CLOSE_EVENT,closeHandle);
					SFApplication.application.removeChild(intrPage);
					intrPage = null;
					System.gc();
				}
			);
			SFApplication.application.addChild(_intrPage);
		}
	}
}