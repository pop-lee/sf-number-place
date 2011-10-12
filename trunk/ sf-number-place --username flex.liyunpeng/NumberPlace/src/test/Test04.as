package test
{
	import flash.display.Sprite;
	import flash.geom.Point;


	public class Test04 extends Sprite
	{
		private var LENGTH :int = 9;
		private var map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>;
		
		public function Test04()
		{
			for(var i : int = 0 ;i < LENGTH;i++) {
				map[i] = new Vector.<int>(LENGTH);
			}
			
			main();
		}
		
		private function main() : void
		{
//			var su : Test04 = new Test04();
			for(var i : int=0;i<LENGTH;i++) {
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
			for(var i : int=0;i<LENGTH;i++){
				for(var j : int=0;j<LENGTH;j++){
					map[i][j] = 0;
				}
			}
			randomInit();
		}
		
		private var testStr : String = "";
		private function print() : void{
			for(var i : int=0;i<LENGTH;i++){
				for(var j : int=0;j<LENGTH;j++){
					testStr += map[i][j] + ",";
//					System.out.print(map[i][j] + "\t");
				}
				trace(testStr);
//				System.out.println();
			}
		}
		
		public function draw() : void{
			var p : Point = new Point(1, 0);
			var s : int = 0;
			
			while(p != null){
				if(!lay(p.x, p.y, s)){
					p = previous(p.x, p.y);
					s = map[p.x][p.y] + 1;
				}else{
					p = next(p.x, p.y);
					s = 0;
				}
			}
		}
		
		private function randomInit() :void{
			var startNumbers : Vector.<int> = new Vector.<int>;
			for(var i : int=0;i<LENGTH;i++){
				startNumbers.push(i);
			}

//			Collections.shuffle(startNumbers);
			for(var i : int=0;i<LENGTH;i++){
				map[i][0] = startNumbers[i];
			}
		}
		
		public function lay(x : int, y : int,s : int) : Boolean{
			for(var v : int=s;v<LENGTH;v++){
				map[x][y] = v;
				if(isValid(x, y)){
					return true;
				}
			}
			map[x][y] = 0;
			return false;
		}
		
		private function next(x : int,y : int) : Point{
			if(x == 8 && y == 8){
				return null;
			}else if(x == 8){
				return new Point(0, y+1);
			}else{
				return new Point(x+1, y);
			}
		}
		
		private function previous(x : int,y : int) : Point{
			if(x == 0 && y == 0){
				throw new Error("Nan solution found!");
			}else if(x == 0){
				return new Point(8, y-1);
			}else{
				return new Point(x-1, y);
			}
		}
		
		private function isValid(x : int,y : int) : Boolean{
			for(var i : int=0;i<LENGTH;i++){
				if(i != y && map[x][i] == map[x][y]){
					return false;
				}
				if(i != x && map[i][y] == map[x][y]){
					return false;
				}
			}
			
			var xStart : int = getZone(x)*3;
			var yStart : int = getZone(y)*3;
			for(var i : int=xStart;i<=xStart+2;i++){
				for(var j : int =yStart+0;j<=yStart+2;j++){
					if(map[i][j] == map[x][y] && !(x == i && y == j)){
						return false;
					}
				}
			}
			return true;
		}
		
		private function getZone(n : int) : int{
			return (n -1)/3;
		}
	}
}