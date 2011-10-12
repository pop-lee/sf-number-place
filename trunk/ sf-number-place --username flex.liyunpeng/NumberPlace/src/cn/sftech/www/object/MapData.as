package cn.sftech.www.object
{
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.DataManager;
	import cn.sftech.www.util.LogManager;
	import cn.sftech.www.util.NPMaker;

	public class MapData
	{
		private static var _model : ModelLocator = ModelLocator.getInstance();
		
		public function MapData()
		{
		}
		
		private function init() : void
		{
		}
		
		public static function initLvData() : void
		{
			var npMaker : NPMaker = new NPMaker();
			for(var i : int = 1; i <= 5;i++) {
				_model.lvMapArr[i-1] = npMaker.makeNP(9+i);
			}
		}
		
		public static function getLvData(lv : uint) : Object
		{
			if(_model.lvMapArr.length - lv < 2) {
				var npMaker : NPMaker = new NPMaker();
				if(lv < 5) {
					for(var i : int = 0;i < 5;i++) {
						_model.lvMapArr[5+i] = npMaker.makeNP(20 + i);
					}
				} else if(lv < 10) {
					for(var j : int = 0;j < 5;j++) {
						_model.lvMapArr[5+j] = npMaker.makeNP(25 + j);
					}
				} else if(lv < 15) {
					for(var k : int = 0;k < 5;k++) {
						_model.lvMapArr[5+k] = npMaker.makeNP(30 + k);
					}
				} else if(lv < 20) {
					for(var l : int = 0;l < 5;l++) {
						_model.lvMapArr[5+l] = npMaker.makeNP(35 + l);
					}
				} else if(lv < 25) {
					for(var m : int = 0;m < 5;m++) {
						_model.lvMapArr[5+m] = npMaker.makeNP(40 + m);
					}
				} else if(lv < 30) {
					for(var n : int = 0;n < 5;n++) {
						_model.lvMapArr[5+n] = npMaker.makeNP(42 + n);
					}
				} else if(lv < 35) {
					for(var o : int = 0;o < 5;o++) {
						_model.lvMapArr[5+o] = npMaker.makeNP(45 + o);
					}
				}
				(new DataManager()).saveLvMap();
			}
			return _model.lvMapArr[lv-1];
		}
		
	}
}