package test{
	import cn.sftech.www.util.MathUtil;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class NPJava extends Sprite{
		private var map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(10);
//		private int[][] map = new int[10][10];
		
		public function NPJava()
		{
			for(var i:int=0;i<10;i++){
				run();
//				System.out.println();
			}
		}
		
		public function run() : void{
			init();
			draw();
			print();
		}
		
		private function init() : void{
			for(var i:int =1;i<10;i++){
				map[i] = new Vector.<int>(10);
				for(var j:int=1;j<10;j++){
					map[i][j] = 0;
				}
			}
			randomInit();
		}
		
		private function print() : void{
			var str : String = "";
			for(var i : int=1;i<10;i++){
				for(var j: int=1;j<10;j++){
					str += map[i][j];
//					System.out.print(map[i][j] + "\t");
				}
				str +="\n";
//				System.out.println();
			}
			trace(str);
		}
//		
//		private static class Point{
//			public Point(int x, int y){
//				this.x = x;
//				this.y = y;
//			}
//			int x,y;
//		}
		
		public function draw() : void{
			var p : Point = new Point(2, 1);
			var s : int = 1;
			
			while(p != null){
				if(!lay(p.x, p.y, s)){
					p = previous(p.x, p.y);
					s = map[p.x][p.y] + 1;
				}else{
					p = next(p.x, p.y);
					s = 1;
				}
			}
		}
		
		private function randomInit() : void{
			var startNumbers : Vector.<int> = new Vector.<int>
//			List<Integer> startNumbers = new ArrayList<Integer>();
			for(var i : int=1;i<=9;i++){
				startNumbers.push(i);
			}
			
			var tmpNum : int;
			for(var j : int = 0;j < 200; j++) {
				var aIndex : int = MathUtil.random(0,startNumbers.length);
				var bIndex : int = MathUtil.random(0,startNumbers.length);
				
				tmpNum = startNumbers[aIndex];
				startNumbers[aIndex] = startNumbers[bIndex];
				startNumbers[bIndex] = tmpNum;
			}
			
			for(var k : int=1;k<=9;k++){
				map[k][1] = startNumbers[k - 1];
			}
		}
		
		public function lay(x : int, y : int, s : int) : Boolean{
			for(var v : int=s;v<10;v++){
				map[x][y] = v;
				if(isValid(x, y)){
					return true;
				}
			}
			map[x][y] = 0;
			return false;
		}
		
		private function next( x : int, y : int) : Point{
			if(x == 9 && y == 9){
				return null;
			}else if(x == 9){
				return new Point(1, y+1);
			}else{
				return new Point(x+1, y);
			}
		}
		
		private function previous(x : int,y : int) : Point{
			if(x == 1 && y == 1){
				throw new Error("Nan solution found!");
//				throw new RuntimeException("Nan solution found!");
			}else if(x == 1){
				return new Point(9, y-1);
			}else{
				return new Point(x-1, y);
			}
		}
		
		private function isValid(x : int, y : int) : Boolean{
			for(var i : int=1;i<10;i++){
				if(i != y && map[x][i] == map[x][y]){
					return false;
				}
				if(i != x && map[i][y] == map[x][y]){
					return false;
				}
			}
			
			var xStart : int = getZone(x)*3;
			var yStart : int = getZone(y)*3;
			for(var i : int=xStart+1;i<=xStart+3;i++){
				for(var j : int=yStart+1;j<=yStart+3;j++){
					if(map[i][j] == map[x][y] && !(x == i && y == j)){
						return false;
					}
				}
			}
			return true;
		}
		
		private function getZone( n : int) : int{
			return (n -1)/3;
		}
	}
}