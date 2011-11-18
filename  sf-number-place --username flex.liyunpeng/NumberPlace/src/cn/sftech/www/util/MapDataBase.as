package cn.sftech.www.util
{
	public class MapDataBase
	{
		public function MapDataBase()
		{
		}
		
		public function getMapData() : Array
		{
			throw new Error("this function must be override");
		}
	}
}