package cn.sftech.www.util
{
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.MapData;
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
		public static const LV_MAP_KEY : String = "lvMapKey";
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		//关卡地图是否初始化
		private var lvMapInited : Boolean = false;
		
		public function DataManager()
		{
		}
		
		public function initData() : void
		{
			queryLvMap();
			MttScore.query(queryScoreHandle);
		}
		
		public function saveLvMap() : void
		{
			var lvData : ByteArray = new ByteArray();
			lvData.writeObject(_model.lvMapArr);
			lvData.position = 0;
			MttGameData.put(LV_MAP_KEY,lvData,saveLvMapResult);
		}
		
		public function queryLvMap() : void
		{
			MttGameData.get(LV_MAP_KEY,queryLvMapResult);
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
		private function queryLvMapResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				_model.lvMapArr = Vector.<Object>(result.value.readObject());
				lvMapInited = true;
				SFApplication.application.dispatchEvent(new SFInitializeDataEvent());
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				LogManager.print("因网络原因，查询失败");
			} else {
				initLvMapData();
//				LogManager.print("查询数据发生错误");
			}
		}
		
		private function initLvMapData() : void
		{
			LogManager.print("正在为您的第一次游戏初始化数据...");
			MapData.initLvData();
//			saveLvMap();
		}
		
		private function queryScoreHandle(result : Object) : void
		{
			if(result.code == 0) {
				var items:Array = result.board as Array;
				for (var i:int = 0; i < items.length; i++)
				{
//				sInfo += "\n好友[" + (i + 1) + "]:" + items[i].nickName + " " + items[i].score + " " + items[i].playTime;
					var _score: int = items[i].score;
//					_model.topScoreArr[i] = _score;
				}
			}
		}
	}
}