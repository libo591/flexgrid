package com.common.platform.view
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.model.header.ColProp;
	import com.grid.model.header.RowProp;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.ui.ColHeaderFuncConfigUI;
	
	import morn.core.components.Box;
	import morn.core.components.CheckBox;
	import morn.core.components.Dialog;
	import morn.core.handlers.Handler;
	
	public class ColHeaderFuncConfig extends ColHeaderFuncConfigUI
	{
		private var _callBackFunc:Function;
		private var _colindex:int;
		private var _rowindex:int;
		private var _gridname:String;
		
		public function get callBackFunc():Function
		{
			return _callBackFunc;
		}

		public function set callBackFunc(value:Function):void
		{
			_callBackFunc = value;
		}

		public function get colindex():int
		{
			return _colindex;
		}

		public function set colindex(value:int):void
		{
			_colindex = value;
		}


		public function ColHeaderFuncConfig()
		{
			this.confirmButton.addEventListener(MouseEvent.CLICK,confirm);
			dataList.mouseHandler = new Handler(onCheckListMouse);
			this.addEventListener(Event.ADDED_TO_STAGE,add2Stage);
		}
		
		/**处理选择框选中效果*/
		private function onCheckListMouse(e:MouseEvent, index:int):void {
			if (e.type == MouseEvent.CLICK) {
				var cell:Box = dataList.getCell(index);
				var checkBox:CheckBox = cell.getChildByName("check") as CheckBox;
				cell.dataSource["check"] = checkBox.selected;
			}
		}
		
		protected function add2Stage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,add2Stage);
			var arr:Array = [];
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var cp:ColProp = grid.getColProp(this.colindex);
			var rowcount:int = grid.rowcount;
			var notdispvalues:Array = cp.headerFunc.filterValues[grid.getCellInPosition(this.rowindex,this.colindex).extendProp.text];
			for(var i:int=0;i<rowcount;i++){
				var rp:RowProp = grid.getRowProp(i);
				if(rp.type==RowProp.ROWTYPE_TABLEHEADER){
					continue;
				}
				var cell:ICell = grid.getCellInPosition(i,this.colindex);
				var text:String = cell.extendProp.text;
				
				var notselected:Boolean = false;
				if(cell.extendProp.text==""){
					text = "null";		
				}
				if(notdispvalues!=null&&notdispvalues.indexOf(cell.extendProp.value)!=-1){
					notselected = true;
				}
				var item:Object = {label:text,
					tag:cell.extendProp.value,
						check:!notselected};
				arr.push(item);
			}
			dataList.array = arr;
		}		
		
		protected function confirm(event:MouseEvent):void
		{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var cp:ColProp = grid.getColProp(this.colindex);
			var notdispvalues:Array = [];
			var count:int = this.dataList.array.length;
			for(var i:int=0;i<count;i++){
				var obj:Object = dataList.getItem(i);
				if(obj.check==false){
					if(notdispvalues.indexOf(obj.tag)==-1){
						notdispvalues.push(obj.tag);
					}
				}
			}
			cp.headerFunc.filterValues[grid.getCellInPosition(this.rowindex,this.colindex).extendProp.text] = notdispvalues;
			GridController.getInstance().filterCol(this.colindex,this.rowindex,this.gridname);
			App.dialog.close(this.parent.parent as Dialog);
		}
		
		public function get gridname():String
		{
			return _gridname;
		}

		public function set gridname(value:String):void
		{
			_gridname = value;
		}

		public function get rowindex():int
		{
			return _rowindex;
		}

		public function set rowindex(value:int):void
		{
			_rowindex = value;
		}
		
	}
}