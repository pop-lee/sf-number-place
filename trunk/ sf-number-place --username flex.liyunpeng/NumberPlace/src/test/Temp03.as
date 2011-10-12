package{
	
	import flash.display.Sprite;
	
	public class Sudoku extends Sprite{
		
		private var FillArr:Array=new Array(9);
		
		private var n:Array=new Array(9);
		
		public function Sudoku(){
			
			for(var i=0;i<9;i++){
				
				FillArr[i]=new Array(9);
				
				n[i]=new Array(9);
				
				for(var j=0;j<9;j++){
					
					FillArr[i][j]=new Array();}}
			
			
			for(i=0;i<9;i++)
				
				for(j=0;j<9;j++){
					
					fill(i,j);
					
					if(FillArr[i][j].length==0){
						
						
						while(FillArr[i][j].length<2){
							
							FillArr[i][j].shift();n[i][j]=10;
							
							if(j==0){i--;j=8;}
								
							else{j--;}
							
						}
						
						FillArr[i][j].shift();        }
					
					n[i][j]=FillArr[i][j][0];
					
					
				}
			
			for(i=0;i<9;i++){
				
				trace(n[i]);}
			
			for(i=0;i<9;i++){
				
				
				for(j=0;j<9;j++){
					
					trace(isFillable(i,j,n[i][j]));}}        
			
		}
		
		private function checkRow(row:int,col:int,num:uint){
			
			for(var i=0;i<col;i++){
				
				if(n[row][i]==num) return false;}
			
			return true;
			
		}
		
		private function checkCol(row:int,col:int,num:uint)        {
			
			for(var i=0;i<row;i++){
				
				if(n[i][col]==num) return false;}
			
			return true;
			
		}        
		private function checkNine(row:int,col:int,num:uint){
			
			var a=Math.floor(row/3)*3;
			
			var b=Math.floor(col/3)*3;
			
			var c:uint;
			
			var d:uint;
			
			if(a==0){c=row;}
				
			else{c=row%a; }
			
			if(b==0){d=col;}
				
			else{d=col%b;}
			
			for(var i=0;i<3;i++)
				
				for(var j=0;j<3&&!(i==c&&j==d);j++){
					
					if(n[a+i][b+j]==num) return false;
					
				}
			
			
			return true;}                
		private function isFillable(row:int,col:int,num:uint){
			
			return (checkRow(row,col,num)&&checkCol(row,col,num)&&checkNine(row,col,num));
			
		}        
		private function fill(row,col){
			
			FillArr[row][col]=[];
			
			for(var a=1;a<=9;a++){
				
				if(isFillable(row,col,a)){FillArr[row][col].push(a);}}
			
			FillArr[row][col].sort(randnsort);
			
			
		}        
		
		private function randnsort(a,b)        {
			
			var randnArr:Array=[-1,0,1];
			
			var randn=Math.floor(Math.random()*3);
			
			return randnArr[randn];
			
			
		}
		
		public function returnArr(){
			
			return n;}        
		
	}}