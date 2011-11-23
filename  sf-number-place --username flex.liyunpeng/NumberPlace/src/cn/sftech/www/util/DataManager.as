package cn.sftech.www.util
{
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.event.SaveGameEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.MapData;
	import cn.sftech.www.object.UserLvData;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttMall;
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	
	import flash.errors.EOFError;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class DataManager
	{
		public const USER_LV_DATA_KEY : String = "userLvDataKey";
		
		public const UNLOCK_LEVEL_KEY : String = "unlockLevel";
		
		public const BUY_LEVEL_KEY : String = "buyLevelKey";
		
		private var manageLock : Boolean = false;
		
		private static var isInitialized : Boolean = false;
		
		private static var manageFuncArr : Vector.<Function> = new Vector.<Function>();
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function DataManager()
		{
		}
		
		public function initData() : void
		{
			LogManager.print("正在加载用户数据...");
			queryUnlockLevel();
			queryUserSaveData();
			queryUserPackage();
			queryStore();
			queryCoins();
//			initFinished();
		}
		
		public function submitScore() : void
		{
			if(manageLock) {
				inList(submitScore);
			} else {
				manageLock = true;
				
				MttScore.submit(_model.currentScore,submitScoreResult);
			}
			
		}
		
		/**
		 * 存储用户所玩的当前关数据
		 */		
		public function saveLvData() : void
		{
			if(manageLock) {
				inList(saveLvData);
			} else {
				manageLock = true;
				
				_model.userSaveLv = _model.currentLv;
				
				var userLvDataObejct : ByteArray = new ByteArray();
				var userLvData : UserLvData = new UserLvData();
				userLvData.saveLv = _model.currentLv;
				userLvData.isHardType = _model.isHardType;
				userLvData.userLvData = _model.userResolveArr;
				userLvDataObejct.writeObject(userLvData);
				userLvDataObejct.position = 0;
				MttGameData.put(USER_LV_DATA_KEY,userLvDataObejct,saveLvDataResult);
			}
		}
		
		public function saveUnlockLevel() : void
		{
			if(manageLock) {
				inList(saveUnlockLevel);
			} else {
				manageLock = true;
				
				var unlockLevel : ByteArray = new ByteArray();
				unlockLevel.writeObject(_model.unlockLevel);
				unlockLevel.position = 0;
				MttGameData.put(UNLOCK_LEVEL_KEY,unlockLevel,saveUnlockLevelResult);
			}
		}
		
		public function saveBuyLevel() : void
		{
			if(manageLock) {
				inList(saveBuyLevel);
			} else {
				manageLock = true;
				
				var buyLevel : ByteArray = new ByteArray();
				buyLevel.writeObject(_model.buyLevel);
				buyLevel.position = 0;
				MttGameData.put(BUY_LEVEL_KEY,buyLevel,saveBuyLevelResult);
			}
		}
		
		public function buyHardLevel() : void
		{
			if(manageLock) {
				inList(buyHardLevel);
			} else {
				MttMall.purchase(_model.hardLvKeyId, 1, buyHardLevelResult);
			}
		}
		
		//---------------------------------------------------------------------------------------------
		
		private function queryUserSaveData() : void
		{
			if(manageLock) {
				inList(queryUserSaveData);
			} else {
				manageLock = true;
				
				MttGameData.get(USER_LV_DATA_KEY,queryUserLvDataResult);
			}
		}
		
		private function queryUnlockLevel() : void
		{
			if(manageLock) {
				inList(queryUnlockLevel);
			} else {
				manageLock = true;
				
				MttGameData.get(UNLOCK_LEVEL_KEY,queryUnlockLevelResult);
			}
			
		}
		
		private function queryBuyLevel() : void
		{
			if(manageLock) {
				trace(queryBuyLevel);
				inList(queryBuyLevel);
			} else {
				manageLock = true;
				
				MttGameData.get(BUY_LEVEL_KEY,queryBuyLevelResult);
			}
		}
		
		private function queryUserPackage() : void
		{
			if(manageLock) {
				inList(queryUserPackage);
			} else {
				manageLock = true;
				
				MttMall.list(queryUserPackageResult);
			}
		}
		
		private function queryStore() : void
		{
			if(manageLock) {
				inList(queryStore);
			} else {
				manageLock = true;
				
				MttMall.store(queryStoreResult);
			}
		}
		
		private function queryCoins() : void
		{
			if(manageLock) {
				inList(queryCoins);
			} else {
				manageLock = true;
				
				MttMall.coins(queryCoinsResult);
			}
		}
		
		private function initFinished() : void
		{
			isInitialized = true;
			LogManager.print("初始化成功");
			
			manageLock = true;
			
			SFApplication.application.dispatchEvent(new SFInitializeDataEvent());
			LogManager.hideLog();
		}
		
		//---------------------------------------------------------------------------------------------
		
		private function saveLvDataResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
//				LogManager.print("保存当前关成功");
				SFApplication.application.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVED));
				outList();
				return;
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，保存失败");
			} else { //其他错误
//				LogManager.print("保存数据发生错误,错误号" + result.code);
			}
			SFApplication.application.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVE_ERROR));
		}
		private function saveUnlockLevelResult(result: Object) : void
		{
			if(result.code == 0) { //返回成功
				outList();
//				LogManager.print("保存以解锁关卡成功");
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，保存失败");
			} else { //其他错误
//				LogManager.print("保存数据发生错误,错误号" + result.code);
			}
		}
		private function saveBuyLevelResult(result : Object) : void
		{
			if(result.code == 0) { //返回成功
				SFApplication.application.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVED));
				outList();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
			} else { //其他错误
//				LogManager.print("保存数据发生错误,错误号" + result.code);
			}
		}
		private function submitScoreResult(result:Object) : void
		{
			if(result.code == 0) {
				outList();
			}
		}
		
		private function buyHardLevelResult(result : Object) : void
		{
			if(result.code == 0) {
				_model.buyLevel = 1;
				saveBuyLevel();
				outList();
			} else if(result.code == MttService.ENOTENOUGH) {
//				LogManager.print("用户易贝余额不足");
				SFApplication.application.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVE_ERROR));
			}
		}
		
		//---------------------------------------------------------------------------------------------
		
		private function queryUserLvDataResult(result : Object) : void
		{
			if(result.code == 0) { //返回成功
//				LogManager.print("加载保存关卡成功");
				
				result.value.position = 0;
				var userLvData : Object = result.value.readObject();
				_model.userSaveLv = userLvData.saveLv;
				_model.isHardType = userLvData.isHardType;
				_model.userResolveArr = userLvData.userLvData;
				
				outList();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，提交失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
//				LogManager.print("正在为您初始化用户关卡数据");
				saveLvData();
				outList();
			} else {
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		private function queryUnlockLevelResult(result:Object) : void
		{
//			result.code = MttService.ENOENT;
			if(result.code == 0) { //返回成功
//				LogManager.print("加载以解锁关卡成功");
				
				_model.unlockLevel = uint(result.value.readObject());
				
				outList();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，查询失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
//				LogManager.print("正在为您初始化以解锁关卡数据");
				saveUnlockLevel();
				outList();
			} else {
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		
		private function queryBuyLevelResult(result:Object) : void
		{
//			result.code = MttService.ENOENT;
			if(result.code == 0) { //返回成功
//				LogManager.print("加载以解锁关卡成功");
				_model.buyLevel = uint(result.value.readObject());
				
				outList();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，查询失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
//				LogManager.print("正在为您初始化以购买关卡数据");
				_model.buyLevel = 1;
				saveBuyLevel();
				outList();
			} else {
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		
		private function queryUserPackageResult(result : Object) : void
		{
			if(result.code == 0) {
//				LogManager.print("加载以用户购买道具列表成功");
				
				if(result.items[0].total > 0) {
					queryBuyLevel();
				}
				outList();
			} else if(result.code == MttService.ENOENT) {
				outList();
			} else {
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		
		private function queryStoreResult(result : Object) : void
		{
			if(result.code == 0) {
//				LogManager.print("加载商城成功");
				var storeList : Array = result.items as Array;
				_model.price = result.items[0].price;
				_model.hardLvKeyId = result.items[0].id;
				
				outList();
			} else {
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		
		private function queryCoinsResult(result : Object) : void
		{
			if(result.code == 0) {
//				LogManager.print("加载钱币成功");
				_model.currentCoins = result.balance;
				outList();
			} else {
				outList();
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			} 
		}
		
		private function inList(func : Function) : void
		{
			manageFuncArr.push(func);
		}
		
		private function outList() : void
		{
			if(!isInitialized) {
				loading = loading>=100?100:loading += 10;
				LogManager.print("正在加载用户数据..." + loading + " %");
				
				if(manageFuncArr.length == 0) {
					loading = 100;
					LogManager.print("正在加载用户数据..." + loading + " %");
					initFinished();
				}
			}
			
			manageLock = false;
			if(manageFuncArr.length == 0) return;
			
			var func : Function = manageFuncArr[0];
			manageFuncArr.splice(0,1);
			if(manageFuncArr.length>=0) {
				func.call();
			}
			
		}
		
		private var loading : uint = 0;
	}
}