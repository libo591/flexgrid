package com.grid.model.header
{
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.model.GridView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import morn.core.components.Label;
	
	
	public class RowHeaderMove extends Label
	{
		private var _gridname:String;
		private var _rowindex:int;
		public function RowHeaderMove()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_DOWN,labelDown);
		}
		protected function labelDown(event:MouseEvent):void
		{
			startPos = event.stageY;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,stageRowMoveMouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,stageRowMoveMouseUp);
		}
		
		private var rowmoveSpName:String = "headerrowmovesprite";
		protected function stageRowMoveMouseUp(event:MouseEvent):void
		{
			var rowindex:int = getRowMoveToIndex(event.stageY-10);
			GridController.getInstance().moveRow(this._rowindex,rowindex,this._gridname);
			
			startPos = 0;
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,stageRowMoveMouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,stageRowMoveMouseUp);
			var dp:DisplayObject = this.stage.getChildByName(this.rowmoveSpName);
			if(dp!=null){
				this.stage.removeChild(dp);
			}
		}
		
		protected function stageRowMoveMouseMove(event:MouseEvent):void
		{
			var nowPos:Number = event.stageY;
			//创建移动时的显示效果
			var dp:DisplayObject = this.stage.getChildByName(this.rowmoveSpName);
			var sp:Sprite = null;
			if(dp==null){
				sp = new Sprite();
				sp.name = this.rowmoveSpName;
				this.stage.addChild(sp);
			}else{
				sp = Sprite(dp);
			}
			var thisInStagePoint:Point = this.localToGlobal(new Point(this.x,this.y));
			sp.visible = true;
			sp.graphics.clear();
			sp.graphics.lineStyle(2,0x000000);
			sp.graphics.drawRect(thisInStagePoint.x-10,nowPos-10,100,this.height+10);
			
			
			var gridView:GridView = GridController.getInstance().getGridView(this._gridname);
			var grid:IGrid = GridController.getInstance().getGrid(this._gridname);
			var rowindex:int = getRowMoveToIndex(nowPos-10);
			
			var startColInGlobalPoint:Point;
			
			if(rowindex!=-1){
				var rowp:RowProp = grid.getRowProp(rowindex);
				startColInGlobalPoint = gridView.contentContainer.localToGlobal(new Point(0,rowp.y));
				sp.graphics.lineStyle(5,0x0000ff);
				sp.graphics.moveTo(startColInGlobalPoint.x,startColInGlobalPoint.y+rowp.height);
				sp.graphics.lineTo(startColInGlobalPoint.x+this.width,startColInGlobalPoint.y+rowp.height);
			}else{
				startColInGlobalPoint = gridView.contentContainer.localToGlobal(new Point(0,0));
				sp.graphics.lineStyle(5,0x0000ff);
				sp.graphics.moveTo(startColInGlobalPoint.x,startColInGlobalPoint.y);
				sp.graphics.lineTo(startColInGlobalPoint.x+this.width,startColInGlobalPoint.y);
			}
			
		}		
		private function getRowMoveToIndex(stageY:Number):int{
			var gridView:GridView = GridController.getInstance().getGridView(this._gridname);
			var grid:IGrid = GridController.getInstance().getGrid(this._gridname);
			var rowindex:int = gridView.getRowIndexByStagePos(stageY);
			if(rowindex==-1){
				var gridViewInGlobalPoint:Point = gridView.contentContainer.localToGlobal(new Point(0,0));
				if(gridViewInGlobalPoint.y>(stageY)){
					rowindex = -1;
				}else{
					rowindex = grid.rowcount-1; 
				}
			}
			return rowindex;
		}
		
		private var startPos:Number=0;
		private var endPos:Number =0;

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