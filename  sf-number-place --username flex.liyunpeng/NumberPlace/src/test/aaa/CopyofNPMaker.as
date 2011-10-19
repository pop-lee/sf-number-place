package test.aaa
{
	import cn.sftech.www.util.LogManager;
	
	import flash.display.Sprite;

	public class CopyofNPMaker extends Sprite
	{
		private var solves : int;
		
		private var black : uint = 9;
		
		private var map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(9);
		
		private var count : uint = 1;
		
		public function CopyofNPMaker()
		{
			//入门
//			makeNP(10);
//			makeNP(11);
//			makeNP(12);
//			makeNP(15);
//			makeNP(16);
			//标准
//			makeNP(25);  //6
//			makeNP(25);  //7
//			makeNP(25);  //8
//			makeNP(25);  //9
//			makeNP(25);  //10
//			makeNP(25);  //11
//			makeNP(26);  //12
//			makeNP(27);  //13
//			makeNP(28);  //14
//			makeNP(29);  //15
//			makeNP(30);  //16
//			makeNP(31);  //17
//			makeNP(32);  //18
//			makeNP(33);  //19
//			makeNP(34);  //20
//			makeNP(35);  //21
//			makeNP(36);  //22
//			makeNP(37);  //23
//			makeNP(38);  //24
//			makeNP(39);  //25
//			makeNP(40);  //26
//			makeNP(40);  //27
//			makeNP(41);  //28
//			makeNP(42);  //29
//			makeNP(43);  //30
//			makeNP(44);  //31
//			makeNP(45);  //32
//			makeNP(45);  //33
//			makeNP(45);  //34
//			makeNP(45);  //35
			makeNP(45);  //36
			makeNP(45);  //37
			makeNP(45);  //38
			makeNP(45);  //39
			makeNP(45);  //40
			makeNP(45);  //41
			makeNP(45);  //42
			makeNP(45);  //43
			makeNP(45);  //44
			makeNP(45);  //45
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
//			while(false);
//			resolve();
			
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
			trace("//" + count);
			display();
			if(count == 5) {
				count = 1;
				trace("//-----------------");
			} else {
				count ++;
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
		//深度优先搜索
		private function dfs() : void
		{
//			LogManager.print(temp++ + "");
//			trace(temp);
			
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
			//以全部填完
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
		
		//返回有多少种可能值
		private function check(y : int,x : int,mark : Vector.<int>) : int
		{
			var i : int,j : int;
			var i_s : int , js : int
			var count : int = 0;
			for(i=1;i<=9;++i)
				mark[i]=0;
			//所属列
			for(i=0;i<9;++i)
				mark[map[y][i]]=1;
			//所属行
			for(i=0;i<9;++i)
				mark[map[i][x]]=1;
			i_s=int(y/3)*3;
			js=int(x/3)*3;
			//所属9块
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
			var text : String = "";
			text += "["+ "\n";
			for(var i : int=0;i<9;++i)
			{
				text += "	[";
				for(var j : int=0;j<9;++j)
				{
					text += map[i][j];
//					if(map[i][j]>0)
//					else
//						trace("[   ] ");
					if(j < 8) text += ",";
				}
				text += "]";
				if(i < 8) text += ",";
				trace(text);
				text = "";
			}
			text += "],";
			trace(text);
		}
	}
}