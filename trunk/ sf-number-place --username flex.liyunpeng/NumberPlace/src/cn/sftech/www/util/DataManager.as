package cn.sftech.www.util
{
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.MapData;
	import cn.sftech.www.object.UserLvData;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	
	import flash.errors.EOFError;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class DataManager
	{
		//关卡地图数据Key
		public const LV_MAP_KEY : String = "lvMapKey";
		
		public const USER_LV_DATA_KEY : String = "userLvDataKey";
		
		public const UNLOCK_LEVEL_KEY : String = "unlockLevel";
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var initFlag : uint ;
		
		private var isInitializing : Boolean = false;
		
		private var initDataCount : uint ;
		
		
		//关卡地图是否初始化
		private var lvMapInited : Boolean = false;
		
		public function DataManager()
		{
		}
		
		public function initData() : void
		{
			LogManager.print("正在加载用户数据...");
//			initLvMapData();
			initDataCount = 3;
			queryLvMap();
			queryUserSaveData();
			queryUnlockLevel();
//			MttScore.query(queryScoreHandle);
		}
		
		/**
		 * 存储用户的关卡地图数据
		 */		
		public function saveLvMap() : void
		{
			var lvMap : ByteArray = new ByteArray();
			lvMap.writeObject(_model.lvMapArr);
			lvMap.position = 0;
			MttGameData.put(LV_MAP_KEY,lvMap,saveLvMapResult);
		}
		
		/**
		 * 存储用户所玩的当前关数据
		 */		
		public function saveLvData() : void
		{
			var userLvDataObejct : ByteArray = new ByteArray();
			var userLvData : UserLvData = new UserLvData();
			userLvData.saveLv = _model.currentLv;
			userLvData.userLvData = _model.userResolveArr;
			userLvDataObejct.writeObject(userLvData);
			userLvDataObejct.position = 0;
			MttGameData.put(USER_LV_DATA_KEY,userLvDataObejct,saveLvDataResult);
		}
		
		public function saveUnlockLevel() : void
		{
			var unlockLevel : ByteArray = new ByteArray();
			unlockLevel.writeObject(_model.unlockLevel);
			unlockLevel.position = 0;
			MttGameData.put(UNLOCK_LEVEL_KEY,unlockLevel,saveUnlockLevelResult);
		}
		
		public function queryLvMap() : void
		{
			MttGameData.get(LV_MAP_KEY,queryLvMapResult);
		}
		
		private function queryUserSaveData() : void
		{
			MttGameData.get(USER_LV_DATA_KEY,queryUserLvDataResult);
		}
		
		private function queryUnlockLevel() : void
		{
			MttGameData.get(UNLOCK_LEVEL_KEY,queryUnlockLevelResult);
		}
		
		public function saveCurrentLv() : void
		{
			
		}
		
		private function saveLvMapResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，提交失败");
			}
		}
		private function saveLvDataResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				LogManager.print("保存当前关成功");
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，保存失败");
			} else { //其他错误
			}
		}
		private function saveUnlockLevelResult(result: Object) : void
		{
			if(result.code == 0) { //返回成功
				LogManager.print("保存以解锁关卡成功");
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，保存失败");
			} else { //其他错误
			}
		}
		private function queryLvMapResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				LogManager.print("加载关卡地图成功");
				_model.lvMapArr = Vector.<Object>(result.value.readObject());
				lvMapInited = true;
				
				initCheck();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，查询失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
				initLvMapData();
			} else {
				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		private function queryUserLvDataResult(result : Object) : void
		{
			if(result.code == 0) { //返回成功
				LogManager.print("加载用户数据成功");
//				var byteArray : ByteArray = result.value;
//				byteArray.position = 0
//				trace(byteArray.position);
				result.value.position = 0;
				trace(result.value.position);
				var userLvData : Object = result.value.readObject();
				_model.currentLv = userLvData.saveLv;
				_model.userResolveArr = userLvData.userLvData;
				
				initCheck();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，提交失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
				initLvMapData();
			} else {
				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		private function queryUnlockLevelResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				LogManager.print("加载以解锁关卡成功");
				_model.unlockLevel = uint(result.value.readObject());
				
				initCheck();
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，查询失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
				initLvMapData();
			} else {
				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		
		private function initLvMapData() : void
		{
			if(isInitializing) return;
			isInitializing = true;
			LogManager.print("正在为您的第一次游戏初始化数据...");
			MapData.initLvData();
			saveLvMap();
			saveLvData();
			saveUnlockLevel();
		}
		
//		private function queryScoreHandle(result : Object) : void
//		{
//			if(result.code == 0) {
//				LogManager.print("加载积分榜成功");
//				var items:Array = result.board as Array;
//				for (var i:int = 0; i < items.length; i++)
//				{
////				sInfo += "\n好友[" + (i + 1) + "]:" + items[i].nickName + " " + items[i].score + " " + items[i].playTime;
//					var _score: int = items[i].score;
////					_model.topScoreArr[i] = _score;
//				}
//				
//				initCheck();
//			}
//		}
		
		private function initCheck() : void
		{
			initFlag++;
			if(initFlag == initDataCount) {
				SFApplication.application.dispatchEvent(new SFInitializeDataEvent());
				LogManager.hideLog();
			}
//			LogManager.print(initFlag + "");
		}
	}
}