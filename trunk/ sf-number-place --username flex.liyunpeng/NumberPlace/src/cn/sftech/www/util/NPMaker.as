package cn.sftech.www.util
{
	import cn.sftech.www.object.Block;
	
	public class NPMaker
	{
		private var map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(9);
		
		private var _resolveHistory : Vector.<Block> = new Vector.<Block>();
		
		public function NPMaker()
		{
			
		}
		
		public function makeNP(black : uint) : Object
		{
			for(var a : int = 1;a <= map.length;a++) {
				map[a-1] = new Vector.<int>(9);
			}
			var i : int,j : int;
			
			//			do
			//			{
			for(i=0;i<9;++i)
			{
				for(j=0;j<9;++j) {
					map[i][j]=0;
				}
				j = Math.random()*10%9;
				map[i][j]=i+1;
			}
			//			}
			//			while(false);
			//			while(!resolve());
			resolve();
			
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
			display();
			
			return map;
		}
		
		// 解数独
		public function resolve() : Boolean
		{
//			try
//			{
				dfs();
				return true;
//			}
//			catch(error : Error)
//			{
//				return true;
//			}
			return false;
		}
		
		private function dfs() : void
		{
			
			//当前级别从indexFlag位置判断接下来的搜索
			var indexFlag : uint = 1;
			
			var resolveFlag : int;
			do{
				//				display();
				//当前空快
				var currentBlock : Block = new Block();
				//当前块需要做的标记
				var currentMark : Vector.<int> =  new Vector.<int>(10);
				
				resolveFlag = findBlankBlock(currentBlock,currentMark);
				
				//				currentBlock = findBlankBlock(currentBlock,currentMark);
				
				//当前解暂时可用，继续向下查找
				if(resolveFlag == 1) {
					check(currentBlock.indexY,currentBlock.indexX,currentMark);
					for(indexFlag;indexFlag<=9;indexFlag++)
					{
						//给目前可能性最小的空格添值
						if(currentMark[indexFlag]==0)
						{
							currentBlock.type = indexFlag;
							map[currentBlock.indexY][currentBlock.indexX]=indexFlag;
							_resolveHistory.push(currentBlock);
							indexFlag = 1;
							break;
						}
					}
					if(indexFlag == 10) {
						resolveFlag = 0;
					}
				}
				//当前解无解，回退上一层解
				if(resolveFlag == 0) {
//					//					currentBlock = null;
//					if(_resolveHistory.length - 1 < 0) {trace("当前数独无解");return;}
//					var lastBlock : Block = _resolveHistory[_resolveHistory.length-1] as Block;
//					indexFlag = lastBlock.type +1;
////					if(indexFlag == 10) {
////						resolveFlag = 0;
////					}
//					_resolveHistory.splice(_resolveHistory.length-1,1);
//					map[lastBlock.indexY][lastBlock.indexX] = 0;
					return;
				}
				
			//全部空块均填写完成
			}while(resolveFlag != -1);
			
		}
		
		//判断是否有可填写的空快，若块无解返回false，若块可填写，则确定填写可能性最少的空格
		private function findBlankBlock(currentBlock : Block,mark : Vector.<int>) : int
		{
			var min : int = 10;
			var m : int = -1;
			var n : int = -1;
			
			for(var i:int=0;i<9;++i) {
				for(var j:int=0;j<9;++j) {
					if(map[i][j])
						continue;
					var c : int=check(i,j,mark);
					
					//代表当前写法无解，只要目前填写的正确，不会执行
					if(c==0)
						return 0;
					if(c<min)
					{
						currentBlock.indexX = j;
						currentBlock.indexY = i;
						m = i;
						n = j;
						min=c;
					}
				}
			}
			if(m == -1) {
				return -1
				//				currentBlock = null;
				//				currentBlock.indexX = n;
				//				currentBlock.indexY = m;
			}
			return 1;
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
			var num : String = "";
			for(var i : int=0;i<9;++i)
			{
				for(var j : int=0;j<9;++j)
				{
					if(map[i][j]>0)
						num += "< "+map[i][j]+" > ";
					else
						num += "[   ] ";
				}
				trace(num);
				num = "";
			}
			trace("\n");
		}
	}
}