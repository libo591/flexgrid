package com.grid.model.cell
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.ICellType;
	import com.grid.interfaces.IGrid;
	import com.grid.model.CommonCellView;
	import com.grid.model.GridConst;
	import com.grid.model.GridController;
	import com.grid.model.celltype.CellTypeFactory;
	import com.grid.model.header.ColProp;
	
	
	
	public class CellView extends CommonCellView
	{
		private var _icellType:ICellType;
		public function CellView()
		{
			super();
		}
		
		override public function clearAll():void{
			this.graphics.clear();
			this.removeAllChild();
		}
		public function drawContent():void{
			if(this.width<=0||this.height<=0){
				clearAll();
				return;
			}
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var cell:ICell = grid.getCellInPosition(this.rowindex,this.colindex);
			var cp:ColProp = grid.getColProp(this.colindex);
			if(_icellType==null){
				var type:int = cell.type;
				if(grid.dispType==GridConst.GRIDTYPE_DISPLAY_TREEGRID
					&&cp.isTreeNode){
					type = CellConst.CELLTYPE_GROUPNODE;
				}
				_icellType = CellTypeFactory.getInst().getCellTypeData(type);
			}
			_icellType.colindex = this.colindex;
			_icellType.rowindex = this.rowindex;
			_icellType.ch = this.height;
			_icellType.cw = this.width;
			_icellType.gridname = this.gridname;
			_icellType.p = this;
			_icellType.display();
		}
		
		override public function setSize(width:Number, height:Number):void{
			super.setSize(width,height);
			callLater(drawContent);
		}
	}
}