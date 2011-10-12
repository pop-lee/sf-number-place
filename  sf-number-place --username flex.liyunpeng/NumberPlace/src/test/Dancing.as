package test
{
	import flash.display.Sprite;

	public class Dancing extends Sprite
	{
		private var LENGTH : int = 9;
		private var SQRLEN : int = 3;
		private var MAXN : int =  (LENGTH*LENGTH*LENGTH);
		private var MAXM : int = (4*LENGTH*LENGTH);
		private var MAXNODE : int = MAXN*MAXM;
		
		private var  map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>;//[MAXN][MAXM]
		private var U : Vector.<int> = new Vector.<int>(MAXNODE);
		private var D : Vector.<int> = new Vector.<int>(MAXNODE);
		private var L : Vector.<int> = new Vector.<int>(MAXNODE);
		private var R : Vector.<int> = new Vector.<int>(MAXNODE);
		private var S : Vector.<int> = new Vector.<int>(MAXNODE);
		private var C : Vector.<int> = new Vector.<int>(MAXNODE);
		private var ROW : Vector.<int> = new Vector.<int>(MAXNODE);
		private var n : int;
		private var m : int;
		private var h : int = 0;//the Leftest and Upest node 
		private var a : Vector.<Vector.<int>> = new Vector.<Vector.<int>>;//[LENGTH][LENGTH]
		
		private var  SEC_POS : int =  0;
		private var  SEC_ROW : int =  1;
		private var  SEC_COL : int =  2;
		private var  SEC_SQR : int =  3;
		private var  PER_SEC : int =  LENGTH*LENGTH;
		
		private var ScoreTable : Array = [
			[6,6,6,6,6,6,6,6,6],
			[6,7,7,7,7,7,7,7,6],
			[6,7,8,8,8,8,8,7,6],
			[6,7,8,9,9,9,8,7,6],
			[6,7,8,9,10,9,8,7,6],
			[6,7,8,9,9,9,8,7,6],
			[6,7,8,8,8,8,8,7,6],
			[6,7,7,7,7,7,7,7,6],
			[6,6,6,6,6,6,6,6,6]
		];

		
		
		public function Dancing()
		{
			Init();
			Solve();
		}
		
		private function Init() : void{
//			freopen("sudoku.in","r",stdin);
//			freopen("sudoku.out","w",stdout);
			for (var i :int = 0; i<LENGTH; i++) {
				a[i] = new Vector.<int>(LENGTH);
				map[i] = new Vector.<int>(LENGTH);
				for (var j :int= 0; j<LENGTH; j++)
					trace(a[i][j]);
			}
		}
		
		private function Solve() : void{
			BuildGraph();
			DancingLinks();
		}
		
		private function  max(a : int,b : int) : int{
			return a>b?a:b;
		}
		private function Row(x : int,y: int,num : int) : int{
			return (x*LENGTH+y)*LENGTH+num-1;
		}
		
		private var cnt : int;
		public function BuildGraph() : void {
			// Build The 0-1 Matrix
			for(var i : int = 0; i<LENGTH;i++)
				for(var j : int = 0;j<LENGTH;j++)
					if (a[i][j])
						Fill(i,j,a[i][j]);
					else for (var k : int = 1; k<=LENGTH; k++)
						Fill(i,j,k);
			
			// Build Dacing Links
			n = MAXN;
			m = MAXM;
			
			for (var i : int = 0; i<n; i++)
				for (var j : int = 0; j<m; j++)
					if (map[i][j])
						map[i][j] = ++cnt;
			var tmp : int;
			var s : int;
			var t : int;
			
			for (var i : int = 0; i<n; i++){
				for (var j : int = 0; j<m; j++)
					if (tmp=map[i][j])
						L[tmp] = t, S[tmp] = i,t = tmp;
				for (var j : int = m-1; j>=0; j--)
					if (tmp=map[i][j])
						R[tmp] = s, s =tmp;
				R[t] = s,L[s] = t;
			}
			
			for (var j : int = 0;j<this.m;j++){
				t = ++this.cnt;
				for (var i : int = 0; i<n; i++)
					if (tmp=map[i][j])
						U[tmp] = t, t = tmp,C[tmp] = cnt, ++S[cnt];
				s = cnt;
				for (var i : int = n-1; i>=0; i--)
					if (tmp=map[i][j])
						D[tmp] = s, s = tmp;
				D[cnt] = s,U[cnt] = t;
			}
			for (var i : int = cnt-m+1; i<=cnt; i++)
				L[i] = i-1;
			for (var i : int = cnt; i>cnt-m; i--)
				R[i] = i+1;
			R[h] = cnt-m+1,L[h] = cnt;
			L[cnt-m+1] = R[cnt] = h;
		}
		
		private function Fill(x : int,y : int,num : int) : void{
			var  row : int = this.Row(x,y,num);
			map[row][SEC_POS*PER_SEC+x*LENGTH+y] = 1;
			map[row][SEC_ROW*PER_SEC+x*LENGTH+num-1] = 1;
			map[row][SEC_COL*PER_SEC+y*LENGTH+num-1] = 1;
			map[row][SEC_SQR*PER_SEC+((x/SQRLEN)*SQRLEN+(y/SQRLEN))*LENGTH+num-1] = 1;
		}
		
		private var Ans : int = -1;
		
		public function DancingLinks() : void {
			search(0,0);
			trace(""+Ans);
		}
		
		public function search(step : int,v : int) : void{
			if (R[h] == h){
				Ans = max(Ans,v);
				/*    GetAns(step);
				for (int i = 0; i<LENGTH; i++){
				for (int j = 0; j<LENGTH; j++)
				printf("%d ",ansmap[i][j]);
				printf("\n");
				}
				printf("\n");*/
				return;
			}
			var c : int,s : int = MAXNODE;
			for (var i : int = R[h];i!=h; i=R[i])
				if (S[i]<s)
					s = S[i],c = i;
			Cover(c);
			for (var i : int = D[c];i!=c;i=D[i]){
				ans[step] = S[i];
				for (var j : int = R[i];j!=i;j = R[j])
					Cover(C[j]);
				search(step+1,v+score(i));
				for (var j : int = L[i];j!=i;j = L[j])
					UnCover(C[j]);
			}
			UnCover(c);
		}
		
		private var ans : Vector.<int> = new Vector.<int>(MAXM+1);
		
		private function score(c : int) : int {
			var t : int = S[c];
			var num : int = t%LENGTH+1;
			var x : int = t/LENGTH/LENGTH%LENGTH;
			var y : int = t/LENGTH%LENGTH;
			return num*ScoreTable[x][y];
		}
		
		public function Cover(c : int) : void{
			L[R[c]] = L[c],R[L[c]] = R[c];
			for (var i : int = D[c];i!=c;i = D[i])
				for (var j : int = R[i];j!=i;j = R[j])
					U[D[j]] = U[j],D[U[j]] = D[j],S[C[j]]--;
		}
		public function UnCover(c : int) : void{
			for (var i : int = U[c];i!=c;i=U[i])
				for (var j : int = L[i];j!=i;j = L[j])
					S[C[j]]++,U[D[j]] = D[U[j]] = j;
			L[R[c]] = R[L[c]] = c;
		}
		
	}
}