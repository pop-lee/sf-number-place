package cn.sftech.www.business
{
	import cn.sftech.www.event.DataManageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttService;
	
	import flash.utils.ByteArray;

	public class UnLockLvDelegate implements IDataDelegate
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private const UNLOCK_LEVEL_KEY : String = "unlockLevel";
		
		public function UnLockLvDelegate()
		{
		}
		
		public function initData():void
		{
			save();
		}
		
		public function query():void
		{
			MttGameData.get(UNLOCK_LEVEL_KEY,queryUnlockLevelResult);
		}
		
		public function save():void
		{
			var unlockLevel : ByteArray = new ByteArray();
			unlockLevel.writeObject(_model.unlockLevel);
			unlockLevel.position = 0;
			MttGameData.put(UNLOCK_LEVEL_KEY,unlockLevel,saveUnlockLevelResult);
		}
		
		
		private function saveUnlockLevelResult(result: Object) : void
		{
			if(result.code == 0) { //返回成功
//				saveCheck();
//				LogManager.print("保存以解锁关卡成功");
				SFApplication.application.dispatchEvent(new DataManageEvent());
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，保存失败");
			} else { //其他错误
			}
		}
		
		private function queryUnlockLevelResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				//				LogManager.print("加载以解锁关卡成功");
				_model.unlockLevel = uint(result.value.readObject());
				
				SFApplication.application.dispatchEvent(new DataManageEvent());
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
				//				LogManager.print("因网络原因，查询失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
				initData();
			} else {
				//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
	}
}