package com.grid.model
{
	import com.boboeye.basic.date.DateParser;
	import com.demonsters.debugger.MonsterDebugger;
	import com.funcs.FuncsLoader;
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.IGrid;
	import com.grid.model.header.ColProp;
	import com.grid.model.header.NormalHeaderFuncProp;
	import com.grid.model.header.RowProp;
	import com.grid.utils.ArrayUtil;
	import com.grid.utils.CellUtil;
	import com.grid.utils.NormalStringUtil;
	
	import flash.events.Event;
	
	import r1.deval.D;
	
	
	

	public class GridController
	{
		private var _model:Object={};
		private static var _inst:GridController;
		private var _gridIndex:int=-1;
		private var _mouseState:GridMouseState=new GridMouseState();
		
		public function GridController()
		{
			GridEventDispatcher.getInstance().addEventListener(GridEvent.GRIDEVENT_FUNCTIONLOADED,functionLoaded);
			initModules();
		}
		
		private function functionLoaded(e:Event=null):void
		{
			GridEventDispatcher.getInstance().removeEventListener(GridEvent.GRIDEVENT_FUNCTIONLOADED,functionLoaded);
			for(var gridName:String in this._model){
				var gridView:GridView = this.getGridView(gridName);
				var gridModel:IGrid = this.getGrid(gridName);
				var rowcount:int = gridModel.rowcount;
				var colcount:int = gridModel.colcount;
				for(var j:int=0;j<rowcount;j++){
					for(var colIndex:int=0;colIndex<colcount;colIndex++){
						var cell:ICell = gridModel.getCellInPosition(j,colIndex);
						if(cell.type==CellConst.CELLTYPE_TEXT){
							var calcResult:String = calcCellValueForDisp(cell,gridName);
							if(calcResult!=null){
								cell.extendProp.text = calcResult;
							}
						}
					}
				}
				gridView.drawPages(gridName);
			}
		}
		private function isExp(value:Object):Boolean{
			if((value is String)
				&&value!=null&&value!=""
				&&value.indexOf("=")==0){
				return true;
			}
			return false;
		}
		private function calcCellValueForDisp(cell:ICell,gridname:String):String
		{
			var valueObj:Object = cell.extendProp.value;
			if(isExp(valueObj)){
				var value:String = valueObj.toString().substring(1);
				MonsterDebugger.trace(this,"开始计算表达式："+value);
				value = NormalStringUtil.expandExp(value);
				MonsterDebugger.trace(this,"扩展后表达式的参数："+value);
				var cellnames:Array = NormalStringUtil.getAllCellName(value);
				var context:Object = {};
				for(var i:int=0;i<cellnames.length;i++){
					var cellname:String = cellnames[i];
					var indexarr:Array = CellUtil.splitCellToIndex(cellname);
					var cell:ICell = 
						GridController.getInstance().getGrid(gridname).getCellInPosition(indexarr[0],indexarr[1]);
					context[cellname] = cell.extendProp.text;
				}
				value = value.replace(/[$]/g,"");
				MonsterDebugger.trace(this,"转换后表达式的参数："+value);
				value = ""+D.evalToNumber(value,context);
				MonsterDebugger.trace(this,"计算后表达式的值："+value);
				return value;
			}
			return null;
		}
		//====== interface======//
		public function showGrid(gridName:String,refresh:Boolean=false):void{
			var gridModel:IGrid = this.getGrid(gridName);
			var gridView:GridView = this.getGridView(gridName);
			//根据gridModel的数据，调用gridView的方法，创建子组件，而后调用显示方法
			gridView.drawPages(gridName);
		}
		
		public function styleChanged():void
		{
			for(var key:String in _model){
				var gv:GridView = this.getGridView(key);
				gv.removeStyle();
				gv.constructStyle();
			}
		}
		
		public function filterCol(colindex:int,rowindex:int,gridname:String):void
		{
			var grid:IGrid = GridController.getInstance().getGrid(gridname);
			var cp:ColProp = grid.getColProp(colindex);
			var rowcount:int = grid.rowcount;
			var notdispvalues:Array = cp.headerFunc.filterValues[grid.getCellInPosition(rowindex,colindex).extendProp.text];
			for(var i:int=0;i<rowcount;i++){
				var rp:RowProp = grid.getRowProp(i);
				var cell:ICell = grid.getCellInPosition(i,colindex);
				if(notdispvalues!=null
					&&notdispvalues.length>0
					&&notdispvalues.indexOf(cell.extendProp.value)!=-1){
					rp.visiable = false;
				}else{
					rp.visiable = true;
				}
				MonsterDebugger.trace(this,rp.visiable+"=="+i,"BB");
			}
			showGrid(gridname,true);
		}
		
		public function sortCol(colindex:int,gridname:String):void
		{
			var grid:IGrid = GridController.getInstance().getGrid(gridname);
			var cp:ColProp = grid.getColProp(colindex);
			
			var sortTar:int = 0;
			var needSort:Boolean = true;
			if(cp.headerFunc.currSort==NormalHeaderFuncProp.SORT_NOSORT){
				cp.headerFunc.currSort = NormalHeaderFuncProp.SORT_ASC;
			}else if(cp.headerFunc.currSort==NormalHeaderFuncProp.SORT_ASC){
				cp.headerFunc.currSort = NormalHeaderFuncProp.SORT_DESC;
				needSort = false;
			}else if(cp.headerFunc.currSort==NormalHeaderFuncProp.SORT_DESC){
				cp.headerFunc.currSort = NormalHeaderFuncProp.SORT_ASC;
				needSort = false;
			}
			var rowcount:int = grid.rowcount;
			var headerCount:int=0;
			if(needSort){
				var arr:Array = [];
				for(var i:int=0;i<rowcount;i++){
					var rp:RowProp = grid.getRowProp(i);
					if(rp.type!=RowProp.ROWTYPE_TABLEHEADER){
						var cell:ICell = grid.getCellInPosition(i,colindex);
						arr.push(cell.extendProp.text+"_"+i+"_"+grid.getColProp(colindex).colDataType);
					}else{
						headerCount++;
					}
				}
				arr.sort(campareFunction);
				
				var newcells:Array = [];
				for(var j:int=0;j<rowcount;j++){
					var rp:RowProp = grid.getRowProp(j);
					if(rp.type==RowProp.ROWTYPE_TABLEHEADER){
						newcells.push(grid.cells[j]);
					}else{
						var currRow:int = parseInt((arr[j-headerCount] as String).split("_")[1]);
						newcells.push(grid.cells[currRow]);
					}
				}
				grid.cells = newcells;
			}else{
				var newcells:Array = [];
				for(var j:int=0;j<rowcount;j++){
					var rp:RowProp = grid.getRowProp(j);
					if(rp.type!=RowProp.ROWTYPE_TABLEHEADER){
						newcells.unshift(grid.cells[j]);
					}else{
						headerCount++;
					}
				}
				var cellsheader:Array = [];
				for(var j:int=0;j<headerCount;j++){
					cellsheader.push(grid.cells[j]);
				}
				grid.cells = cellsheader.concat(newcells);
			}
			
			showGrid(gridname,true);
		}
		
		private function campareFunction(o1:String,o2:String):int{
			var d1:Array = o1.split("_");
			var d2:Array = o2.split("_");
			var datatype:int = parseInt(d1[2]);
			var result:int = -1;
			var value1:String = d1[0];
			var value2:String = d2[0];
			if(datatype==ColProp.COLDATATYPE_NUMBER){
				result = parseFloat(value1)-parseFloat(value2);
			}else if(datatype==ColProp.COLDATATYPE_DATETIME){
				var date1:Date = DateParser.parse2Date(value1);
				var date2:Date = DateParser.parse2Date(value2);
				result = date1.getTime()-date2.getTime();
			}else{
				var len:int = value1.length;
				var len2:int = value2.length;
				var hasResult:Boolean = false;
				for(var i:int=0;i<len;i++){
					var code1:Number = value1.charCodeAt(i);
					if(len2>i){
						var code2:Number = value2.charCodeAt(i);
						result = code1-code2;
						if(result!=0){
							hasResult = true;
							break;
						}
					}else{
						result = 1; 
						hasResult = true;
						break;
					}
				}
				if(!hasResult){
					result = 0;
				}
			}
			return result;
		}
		
		/**
		 * 加载表格所需模块
		 */
		private function initModules():void
		{
			//公式
			loadFunctionsModule();
			//统计图
		}
		
		private function loadFunctionsModule():void
		{
			FuncsLoader.getInst().init();
		}
		public function moveRow(fromIndex:int,toIndex:int,gridName:String):void
		{
			if(fromIndex==toIndex||fromIndex==-1||toIndex==-1){
				return;
			}else{
				if(fromIndex==toIndex+1){
					return;
				}
			}
			
			var grid:IGrid = this.getGrid(gridName);
			grid.rowProps = ArrayUtil.moveItem(grid.rowProps,fromIndex,toIndex);
			
			var cs:Array = grid.cells;
			for(var ci:int=0;ci<grid.colcount;ci++){
				ArrayUtil.switchItem(cs[fromIndex],ci,cs[toIndex],ci);
			}
			
			for(var k:int=0;k<grid.rowcount;k++){
				var rp:RowProp = grid.getRowProp(k);
				rp.rowindex = k;
				if(k==0){
					rp.y = 0 ;
				}else{
					rp.y = grid.getRowProp(k-1).y+grid.getRowProp(k-1).height;
				}
			}
			showGrid(gridName,false);
		}
		public function moveCol(fromIndex:int,toIndex:int,gridName:String):void
		{
			if(fromIndex==toIndex){
				return;
			}
			var grid:IGrid = this.getGrid(gridName);
			grid.colProps = ArrayUtil.moveItem(grid.colProps,fromIndex,toIndex);
			var cs:Array = grid.cells;
			for(var j:int=0;j<cs.length;j++){
				var ritem:Array = cs[j] as Array;
				cs[j] = ArrayUtil.moveItem(ritem,fromIndex,toIndex);
			}
			
			for(var k:int=0;k<grid.colcount;k++){
				var cp:ColProp = grid.getColProp(k);
				cp.colindex = k;
				if(k==0){
					cp.x = 0 ;
				}else{
					cp.x = grid.getColProp(k-1).x+grid.getColProp(k-1).width;
				}
			}
			showGrid(gridName,false);
		}
		public function resizeRow(gridName:String,rowIndex:int,changeRowHeight:Number):void
		{
			var grid:IGrid = this.getGrid(gridName);
			var rowProp:RowProp = grid.getRowProp(rowIndex);
			var resultHeight:Number = rowProp.height+changeRowHeight;
			resultHeight = resultHeight<0?0:resultHeight;
			
			rowProp.height = resultHeight;
			grid.setRowProp(rowIndex,rowProp);
			
			for(var i:int=rowIndex+1;i<grid.rowcount;i++){
				grid.getRowProp(i).y = grid.getRowProp(i-1).y+grid.getRowProp(i-1).height;
			}
			showGrid(gridName,false);
		}
		public function resizeCol(gridName:String,colIndex:int,changeWidth:Number):void
		{
			var time1:Number = new Date().getTime();
			var grid:IGrid = this.getGrid(gridName);
			var colProp:ColProp = grid.getColProp(colIndex);
			var resultWidth:Number = colProp.width+changeWidth;
			resultWidth = resultWidth<0?0:resultWidth;
			
			colProp.width = resultWidth;
			grid.setColProp(colIndex,colProp);
			
			for(var i:int=colIndex+1;i<grid.colcount;i++){
				grid.getColProp(i).x = grid.getColProp(i-1).x+grid.getColProp(i-1).width;
			}
			var time2:Number = new Date().getTime();
			MonsterDebugger.trace(this,(time2-time1)+"=time1=");
			MonsterDebugger.trace(this,(time2)+"=time1 end=");
			showGrid(gridName,false);
		}
		public static function getInstance():GridController{
			if(!_inst){
				_inst = new GridController();
			}
			return _inst;
		}
		/**
		 * 	{
		 * 		name:{"grid":grid,"view":view}
		 * 	}
		 */
		public function regist(gridName:String,grid:IGrid,gridView:GridView):void{
			this._model[gridName] = {};
			this._model[gridName]["grid"] = grid;
			this._model[gridName]["view"] = gridView;
		}
		public function getGrid(gridName:String):IGrid{
			if(this._model[gridName]){
				return IGrid(this._model[gridName]["grid"]);
			}else{
				return null;
			}
		}
		public function getGridView(gridName:String):GridView{
			if(this._model[gridName]){
				return GridView(this._model[gridName]["view"]);
			}else{
				return null;
			}
		}

		public function get gridIndex():int
		{
			return _gridIndex;
		}

		public function set gridIndex(value:int):void
		{
			_gridIndex = value;
		}
		
		public function getPageBuilder(gridName:String):PageBuilder{
			var pager:PageBuilder = this._model[gridName]["pager"] as PageBuilder;
			var gridView:GridView = this.getGridView(gridName);
			var grid:IGrid = this.getGrid(gridName);
			if(pager==null){
				pager = new PageBuilder(grid,gridView.scrollWidth,gridView.scrollHeight);
				this._model[gridName]["pager"] = pager; 
			}
			return pager;
		}

		public function get mouseState():GridMouseState
		{
			return _mouseState;
		}

		public function set mouseState(value:GridMouseState):void
		{
			_mouseState = value;
		}

	}
}