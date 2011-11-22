package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangeGamePageEvent;
	import cn.sftech.www.event.ChooseNumEvent;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.event.StartResolveEvent;
	import cn.sftech.www.event.SuccessEvent;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.object.Block;
	import cn.sftech.www.object.Block9;
	import cn.sftech.www.object.GameConfig;
	import cn.sftech.www.object.MapData;
	import cn.sftech.www.object.NumberBlock;
	import cn.sftech.www.util.DataManager;
	import cn.sftech.www.util.GetNum;
	import cn.sftech.www.util.LevelMapData;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;
	
//	[Embed(source="access/Main.swf",symbol="GamePane")]
	public class GamePane extends SFContainer
	{
//		private var block9Map:Vector.<Vector.<Block>> = new Vector.<Vector.<Block>>;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _currentLvMap : Array;
		
		private var _currentLvBlock : Array;
		
		private var _currentBlock : NumberBlock;
		
		private var _NumPane : ChooseNumPane;
		
		private var _isInit : Boolean = false;
		
		private var successPage : SuccessPage;
		
		public function GamePane()
		{
			super();
			init();
		}
		
		private function init() : void
		{
//			for(var i : int = 0;i < 3;i++) {
//				block9Map[i] = new Vector.<Block>(3);
//				for(var j : int = 0;j < 3;j++) {
//					var block : Block = new Block();
//					block.indexX = j;
//					block.indexY = i;
//					block9Map[i][j] = block;
//				}
//			}
		}
		
		public function initGame():void
		{
			buildBlock();
			_NumPane = new ChooseNumPane();
			_NumPane.x = 20;
			_NumPane.y = 50;
			_NumPane.addEventListener(ChooseNumEvent.CHOOSE_NUM_EVENT,chooseNumHandle);
			SFApplication.application.addChild(_NumPane);
		}
		
		public function startGame(lv : uint) : void
		{
			initLv(lv);
			buildMap(lv);
		}
		
		private function initLv(lv : uint) : void
		{
			_model.isStartPlay = false;
			_model.resolveIsTrue = true;
			_model.isSuccess = false;
		}
		
		/**
		 * 创建数独地图
		 * 
		 */
		private function buildBlock() : void
		{
			this.backgroundImage = Block9Background;
			
			if(!_model.userResolveArr) {
				_model.userResolveArr = new Array(9);
				for(var b : int = 0;b<_model.userResolveArr.length;b++) {
					_model.userResolveArr[b] = new Array(9);
				}
			}
			
//			for(var i : int = 0;i < blockMap.length;i++) {
//				for(var j : int = 0;j < blockMap[i].length;j++) {
//					var block : Block9 = blockMap[i][j];
////					block.width = GameConfig.BLOCK_SIZE*3;
////					block.height = GameConfig.BLOCK_SIZE*3;
//					block.x = block.indexX * GameConfig.BLOCK9_WIDTH + j*GameConfig.MAP_LEADING;
//					block.y = block.indexY * GameConfig.BLOCK9_HEIGHT + i*GameConfig.MAP_LEADING;
//					addChild(block);
//				}
//			}
		}
		
		private function removeBlock(block : NumberBlock) : void
		{
			if(block.hasEventListener(MouseEvent.CLICK)) {
				block.removeEventListener(MouseEvent.CLICK,chooseNumPaneHandle);
			}
			removeChild(block);
		}
		
		private function chooseNumPaneHandle(event : MouseEvent) : void
		{
			_currentBlock = event.currentTarget as NumberBlock;
			_NumPane.visible = true;
		}
		
		private function chooseNumHandle(event : ChooseNumEvent) :void
		{
			if(!event.data) return;
			
			if(_model.userResolveHistory.length == GameConfig.HISTORY_COUNT) {
				_model.userResolveHistory[0] = null;
				_model.userResolveHistory.splice(0,1);
			}
			if(!_isInit) {
				//将填入的放入历史中
				_model.userResolveHistory.push(_currentBlock);
				//派发时间，来更改“上一步”的显示状态
				this.dispatchEvent(new StartResolveEvent());
			}
			
			//获取玩家新选择的数字
			var newBlock : NumberBlock = GetNum.get(uint(event.data));
			newBlock.isOld();
			if(newBlock.type != 0) newBlock.backgroundImage = NumberBlockBackground;
			//拷贝原来位置的坐标及数组索引
			newBlock.copyData(_currentBlock);
			//先将与原块发生冲突的恢复
			restore(_currentBlock);
			//删除原位置上的数据块
			removeBlock(_currentBlock);
			//将当前位置块指定为新块
			_currentBlock = newBlock;
			//替换数组中的类型为最新选择的类型
			_currentLvMap[newBlock.indexY][newBlock.indexX] = newBlock.type;
			//当前关块设定
			_currentLvBlock[newBlock.indexY][newBlock.indexX] = newBlock;
			//为此块添加事件
			newBlock.addEventListener(MouseEvent.CLICK,chooseNumPaneHandle);
			//添加新数字块到显示列表
			addChild(newBlock);
			//添加到用户的已填数字列表中
			_model.userResolveArr[newBlock.indexY][newBlock.indexX] = newBlock.type;
			//用户是否以开始本关
			_model.isStartPlay = true;
			for(var i : int = 0; i <_model.userResolveArr.length;i++) {
				for(var j : int = 0; j < _model.userResolveArr[i].length;j++) {
					if(_model.userResolveArr[i][j] == 0) continue;
					//鉴证填写的数字快是否合理
					if(checkNum(_currentLvBlock[i][j])) {
						successLv();
						return;
					}
				}
			}
			
			System.gc();
		}
		
		//先将与原块发生冲突的恢复
		private function restore(block : NumberBlock) : void
		{
			if(block.type == 0) return;
			//检测列
			for(var i : int = 0;i < 9;i++) {
				if(i == block.indexY) continue;
				if(_currentLvMap[i][block.indexX] == block.type) {
					_currentLvBlock[i][block.indexX].notMakeError();
				}
			}
			//检测行
			for(var j : int = 0;j < 9;j++) {
				if(j == block.indexX) continue;
				if(_currentLvMap[block.indexY][j] == block.type) {
					_currentLvBlock[block.indexY][j].notMakeError();
				}
			}
			//检测所在九格
			for(var k: int = int(block.indexY/3)*3;k<int(block.indexY/3 + 1)*3;k++) {
				for(var l: int = int(block.indexX/3)*3;l<int(block.indexX/3 + 1)*3;l++) {
					if(k == block.indexY && l == block.indexX) continue;
					if(_currentLvMap[k][l] == block.type) {
						_currentLvBlock[k][l].notMakeError();
					}
				}
			}
			_model.resolveIsTrue = true;
		}
		
		private function checkNum(block : NumberBlock) : Boolean
		{
			if(block.type == 0) return false;
			//检测列
			for(var i : int = 0;i < 9;i++) {
				if(i == block.indexY) continue;
				if(_currentLvMap[i][block.indexX] == block.type) {
					_model.resolveIsTrue = false;
					block.makeError();
//					trace(i + "  " + block.indexX);
					_currentLvBlock[i][block.indexX].makeError();
				}
			}
			//检测行
			for(var j : int = 0;j < 9;j++) {
				if(j == block.indexX) continue;
				if(_currentLvMap[block.indexY][j] == block.type) {
					_model.resolveIsTrue = false;
					block.makeError();
//					trace(block.indexY + "  " + j);
					_currentLvBlock[block.indexY][j].makeError();
				}
			}
			//检测所在九格
			for(var k: int = int(block.indexY/3)*3;k<int(block.indexY/3 + 1)*3;k++) {
				for(var l: int = int(block.indexX/3)*3;l<int(block.indexX/3 + 1)*3;l++) {
					if(k == block.indexY && l == block.indexX) continue;
					if(_currentLvMap[k][l] == block.type) {
						_model.resolveIsTrue = false;
						block.makeError();
//						trace(k + "  " + l);
						_currentLvBlock[k][l].makeError();
					}
				}
			}
			//验证是否全部填写完成
			for(var m : int = 0;m < 9;m++) {
				for(var n : int = 0;n < 9;n++) {
					if(_currentLvMap[m][n] == 0) { //还有空地没有填写数字
						return false;
					}
				}
			}
			return _model.resolveIsTrue ?true:false;
		}
		
		private function buildMap(lv : uint) : void
		{
			_currentLvMap = MapData.getLvData(lv);
			_currentLvBlock = new Array(_currentLvMap.length);
			var num : NumberBlock;
			for(var i : int = 0;i < _currentLvMap.length;i++) {
				_currentLvBlock[i] = new Array(_currentLvMap[i].length);
				for(var j : int = 0;j < _currentLvMap[i].length;j++) {
					num = null;
					num = GetNum.get(_currentLvMap[i][j]);
					if(_currentLvMap[i][j] == 0) num.addEventListener(MouseEvent.CLICK,chooseNumPaneHandle);
//					switch(currentLvMap[i][j]) {
//						case 0:num = new Blank as MovieClip;num.addEventListener(MouseEvent.CLICK,clickHandle);break;
//						case 1:num = new One() as MovieClip;break;
//						case 2:num = new Two() as MovieClip;break;
//						case 3:num = new Three() as MovieClip;break;
//						case 4:num = new Four() as MovieClip;break;
//						case 5:num = new Five() as MovieClip;break;
//						case 6:num = new Six() as MovieClip;break;
//						case 7:num = new Seven() as MovieClip;break;
//						case 8:num = new Eight() as MovieClip;break;
//						case 9:num = new Nine() as MovieClip;break;
//					}
					if(num) {
//						num.x = (j-int(j/3)*3)*(GameConfig.BLOCK_WIDTH + GameConfig.BLOCK_LINESIZE) + GameConfig.BLOCK_SPACING + 1;
//						num.y = (i-int(i/3)*3)*(GameConfig.BLOCK_HEIGHT + GameConfig.BLOCK_LINESIZE) + GameConfig.BLOCK_SPACING + 1;
						num.x = j*(GameConfig.BLOCK_WIDTH + 2) + 3 + int(j/3) + j%9; //2左侧空出位置宽度 ===========int(j/3)*2 粗线宽度===========int(j/9)细线宽度
//						num.x = j*GameConfig.BLOCK_WIDTH + 5 + j + int(j/3) + j*2;
						num.y = i*(GameConfig.BLOCK_HEIGHT + 3) + 3 + int(i/3) + i%9;//2上侧空出位置宽度 ===========int(i/3)*2 粗线高度===========int(i/9)细线高度
//						num.y = i*GameConfig.BLOCK_HEIGHT + 5.5  + i + int(i/3) + i*3;
						num.indexX = j;
						num.indexY = i;
						_currentLvBlock[i][j] = num;
						addChild(num);
					}
				}
			}
			
			//填入用户存储的关卡信息
			if(_model.userResolveArr) {
				_model.userResolveHistory = new Vector.<NumberBlock>();
				_isInit = true;
				for(var k : int = 0;k < _model.userResolveArr.length;k++) {
					for(var l : int = 0;l < _model.userResolveArr[k].length;l++) {
						if(_model.userResolveArr[k][l] == 0) continue;
						_currentBlock = _currentLvBlock[k][l];
						chooseNumHandle(new ChooseNumEvent(_model.userResolveArr[k][l]));
					}
				}
				_isInit = false;
			}
		}
		
		private function successLv() : void
		{
			var dataManager : DataManager = new DataManager();
			if(_model.mapDataClass == LevelMapData) {
				if(_model.currentLv == _model.unlockLevel) {
					_model.unlockLevel ++;
					_model.currentScore = (_model.unlockLevel + _model.buyLevel - GameConfig.UNLOCK_INIT_LV)*10;
					dataManager.saveUnlockLevel();
					dataManager.submitScore();
//					dataManager.saveCheck();
				}
			} else {
				if(_model.currentLv == _model.buyLevel) {
					_model.buyLevel ++;
					_model.currentScore = (_model.unlockLevel + _model.buyLevel - GameConfig.UNLOCK_INIT_LV)*10;
					dataManager.saveBuyLevel();
					dataManager.submitScore();
//					dataManager.saveCheck();
				}
			}
			
			_model.isSuccess = true;
			successPage = new SuccessPage();
			successPage.addEventListener(SuccessEvent.SUCCESS_EVENT,successHandle);
			SFApplication.application.addChild(successPage);
		}
		
		private function successHandle(event : SuccessEvent) : void
		{
			successPage.removeEventListener(SuccessEvent.SUCCESS_EVENT,successHandle);
			successPage = null;
			this.dispatchEvent(new ChangeGamePageEvent());
		}
		
//		/**
//		 * 下一关
//		 * 
//		 */		
//		private function nextLv():void
//		{
//			_model.currentLv ++;
//		}
		
		public function cleanGamePane() : void
		{
			for(var i : int = 0;i < _currentLvBlock.length;i++) {
				for(var j : int = 0;j < _currentLvBlock[i].length;j++) {
					removeBlock(_currentLvBlock[i][j]);
				}
			}
			_currentLvBlock = null;
			if(_NumPane.hasEventListener(ChooseNumEvent.CHOOSE_NUM_EVENT)) {
				_NumPane.removeEventListener(ChooseNumEvent.CHOOSE_NUM_EVENT,chooseNumHandle);
			}
			SFApplication.application.removeChild(_NumPane);
			_NumPane = null;
		}
		
		public function prevStep() : void
		{
			if(_model.userResolveHistory.length == 0) return;
			
			var lastBlock : Block = _model.userResolveHistory[_model.userResolveHistory.length-1] as Block;
			_currentBlock = _currentLvBlock[lastBlock.indexY][lastBlock.indexX];
			chooseNumHandle(new ChooseNumEvent(lastBlock.type.toString()));
			_model.userResolveHistory.splice(_model.userResolveHistory.length-2,2);
			
		}
	}
}