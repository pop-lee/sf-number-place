package cn.sftech.www.util
{
	public class NPMaker
	{
		private var solves : int;
		
		private var black : uint = 9;
		
		private var map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(9);
		
		public function NPMaker()
		{
		}
		
		public function makeNP(black : uint) : Object
		{
			for(var a : int = 1;a <= map.length;a++) {
				map[a-1] = new Vector.<int>(9);
			}
			var i : int,j : int;
			
			do
			{
				for(i=0;i<9;++i)
				{
					for(j=0;j<9;++j) {
						map[i][j]=0;
					}
					j = Math.random()*10%9;
					map[i][j]=i+1;
				}
			}
			while(!resolve());
			
			// 挖窟窿
			for(var k:int=0;k<black;)
			{
				i = Math.random()*100%81;
				j=i%9;
				i=int(i/9);
				if(map[i][j]>0)
				{
					map[i][j]=0;
					++k;
				}
			}
			
			return map;
		}
		
		// 解数独
		public function resolve() : Boolean
		{
				try
				{
					dfs();
					return true;
				}
				catch(error : Error)
				{
					return true;
				}
			return false;
		}
		
		private var temp : uint = 0;
		private function dfs() : void
		{
			LogManager.print(temp++ + "");
			trace(temp);
			
			var i : int , j : int,im : int=-1,jm : int;
			var min : int = 10;
			//			var mark[10] : vect;
			var mark : Vector.<int> =  new Vector.<int>(10);
			for(i=0;i<9;++i)
			{
				for(j=0;j<9;++j)
				{
					if(map[i][j])
						continue;
					var c : int=check(i,j,mark);
					if(c==0)
						return;
					if(c<min)
					{
						im=i;
						jm=j;
						min=c;
					}
				}
			}
			if(im==-1)
			{
					throw(new Error());
			}
			check(im,jm,mark);
			for(i=1;i<=9;++i)
			{
				if(mark[i]==0)
				{
					map[im][jm]=i;
					dfs();
				}
			}
			map[im][jm]=0;
		}
		
		private function check(y : int,x : int,mark : Vector.<int>) : int
		{
			var i : int,j : int;
			var i_s : int , js : int
			var count : int = 0;
			for(i=1;i<=9;++i)
				mark[i]=0;
			for(i=0;i<9;++i)
				mark[map[y][i]]=1;
			for(i=0;i<9;++i)
				mark[map[i][x]]=1;
			i_s=int(y/3)*3;
			js=int(x/3)*3;
			for(i=0;i<3;++i)
			{
				for(j=0;j<3;++j)
					mark[map[i_s+i][js+j]]=1;
			}
			for(i=1;i<=9;++i)
				if(mark[i]==0)
					count++;
			return count;
		}
		
		// 显示数独
		public function display() : void
		{
			for(var i : int=0;i<9;++i)
			{
				for(var j : int=0;j<9;++j)
				{
					if(map[i][j]>0)
						trace("< "+map[i][j]+" > ");
					else
						trace("[   ] ");
				}
				trace("\n");
			}
		}
	}
}