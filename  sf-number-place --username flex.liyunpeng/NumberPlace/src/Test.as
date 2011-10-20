package
{
	import cn.sftech.www.util.LevelMapData;
	
	import flash.display.Sprite;
	
	public class Test extends Sprite
	{
		private var _currentLvMap : Vector.<Vector.<int>>;
		
		public function Test()
		{
			super();
			_currentLvMap = Vector.<Vector.<int>>(getLvData(1));
		}
		
		public static function getLvData(lv : uint) : Array {
			var levelMapData : LevelMapData = new LevelMapData();
			var arr : Array = levelMapData.GAME_MAP_DATA[lv-1] as Array;
			var mapArr : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(9);
			for(var i:int = 0;i < arr.length;i++) {
				mapArr[i] = new Vector.<int>(arr[i].length);
				for(var j:int = 0;j < arr[i].length;j++) {
					mapArr[i][j] = arr[i][j];
				}
			}
			return arr;
		}
	}
}