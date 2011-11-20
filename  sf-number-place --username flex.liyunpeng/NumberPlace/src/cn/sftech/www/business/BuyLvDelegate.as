package cn.sftech.www.business
{
	import cn.sftech.www.event.DataManageEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttService;
	
	import flash.utils.ByteArray;

	public class BuyLvDelegate implements IDataDelegate
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public const BUY_LEVEL_KEY : String = "buyLevelKey";
		
		public function BuyLvDelegate()
		{
		}
		
		public function initData():void
		{
			save();
		}
		
		public function query():void
		{
			MttGameData.get(BUY_LEVEL_KEY,queryBuyLevelResult);
		}
		
		public function save():void
		{
			var buyLevel : ByteArray = new ByteArray();
			buyLevel.writeObject(_model.buyLevel);
			buyLevel.position = 0;
			MttGameData.put(BUY_LEVEL_KEY,buyLevel,saveBuyLevelResult);
		}
		
		
		private function saveBuyLevelResult(result : Object) : void
		{
			if(result.code == 0) { //返回成功
//				saveCheck();
				SFApplication.application.dispatchEvent(new DataManageEvent());
			} else if(result.code == MttService.EIOERROR) { //网络原因出错
			} else { //其他错误
			}
		}
		
		private function queryBuyLevelResult(result:Object) : void
		{
			if(result.code == 0) { //返回成功
				//				LogManager.print("加载以解锁关卡成功");
				_model.buyLevel = uint(result.value.readObject());
				
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