package cn.sftech.www.business
{
	import cn.sftech.www.event.DataManageEvent;
	import cn.sftech.www.event.SaveGameEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.UserLvData;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttService;
	
	import flash.utils.ByteArray;

	public class UserLvDataDelegate implements IDataDelegate
	{
		private const USER_LV_DATA_KEY : String = "userLvDataKey";
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function UserLvDataDelegate()
		{
		}
		
		public function initData() : void {
			save();
		}
		
		public function query() : void {
			MttGameData.get(USER_LV_DATA_KEY,queryUserLvDataResult);
		}
		
		public function save() : void {
			_model.userSaveLv = _model.currentLv;
			
			var userLvDataObejct : ByteArray = new ByteArray();
			var userLvData : UserLvData = new UserLvData();
			userLvData.saveLv = _model.currentLv;
			userLvData.userLvData = _model.userResolveArr;
			userLvDataObejct.writeObject(userLvData);
			userLvDataObejct.position = 0;
			MttGameData.put(USER_LV_DATA_KEY,userLvDataObejct,saveLvDataResult);
		}
		
		
		//-------------------request---------------
		
		private function saveLvDataResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
//				LogManager.print("保存当前关成功");
//				saveCheck();
				SFApplication.application.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVED));
				SFApplication.application.dispatchEvent(new DataManageEvent());
				return;
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，保存失败");
			} else { //其他错误
			}
			SFApplication.application.dispatchEvent(new SaveGameEvent(SaveGameEvent.SAVE_ERROR));
		}
		
		private function queryUserLvDataResult(result : Object) : void
		{
			if(result.code == 0) { //返回成功
//				LogManager.print("加载用户数据成功");
//				var byteArray : ByteArray = result.value;
//				byteArray.position = 0
//				trace(byteArray.position);
				result.value.position = 0;
				var userLvData : Object = result.value.readObject();
				_model.userSaveLv = userLvData.saveLv;
				_model.userResolveArr = userLvData.userLvData;
				
				SFApplication.application.dispatchEvent(new DataManageEvent());
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
//				LogManager.print("因网络原因，提交失败");
			} else if(result.code == MttService.ENOENT) { //没有相关的用户存储关卡数据
				initData();
			} else {
//				LogManager.print("查询数据发生错误,错误号" + result.code);
			}
		}
		
	}
}