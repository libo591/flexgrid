package com.grid.model.header
{
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.model.GridView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import morn.core.components.Label;
	
	
	public class ColHeaderMove extends Label
	{
		private var _gridname:String;
		private var _colindex:int;
		private var _canMove:Boolean;
		
		public function ColHeaderMove()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_DOWN,labelDown);
		}
		protected function labelDown(event:MouseEvent):void
		{
			startPos = event.stageX;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,stageColMoveMouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,stageColMoveMouseUp);
		}
		
		private var colmoveSpName:String = "headercolmovesprite";
		protected function stageColMoveMouseUp(event:MouseEvent):void
		{
			var colindex:int = getColMoveToIndex(event.stageX-30);
			GridController.getInstance().moveCol(this._colindex,colindex,this._gridname);
			
			startPos = 0;
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,stageColMoveMouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,stageColMoveMouseUp);
			var dp:DisplayObject = this.stage.getChildByName(this.colmoveSpName);
			if(dp!=null){
				this.stage.removeChild(dp);
			}
		}
		
		protected function stageColMoveMouseMove(event:MouseEvent):void
		{
			var nowPos:Number = event.stageX;
			//创建移动时的显示效果
			var dp:DisplayObject = this.stage.getChildByName(this.colmoveSpName);
			var sp:Sprite = null;
			if(dp==null){
				sp = new Sprite();
				sp.name = this.colmoveSpName;
				this.stage.addChild(sp);
			}else{
				sp = Sprite(dp);
			}
			var thisInStagePoint:Point = this.localToGlobal(new Point(this.x,this.y));
			sp.visible = true;
			sp.graphics.clear();
			sp.graphics.lineStyle(2,0x000000);
			sp.graphics.drawRect(nowPos-30,thisInStagePoint.y-30,this.width+30,100);
			
			var gridView:GridView = GridController.getInstance().getGridView(this._gridname);
			var grid:IGrid = GridController.getInstance().getGrid(this._gridname);
			var colindex:int = getColMoveToIndex(nowPos-30);
			
			var startColInGlobalPoint:Point;
			
			if(colindex!=-1){
				var colp:ColProp = grid.getColProp(colindex);
				startColInGlobalPoint = gridView.contentContainer.localToGlobal(new Point(colp.x,0));
				sp.graphics.lineStyle(5,0x0000ff);
				sp.graphics.moveTo(startColInGlobalPoint.x+colp.width,startColInGlobalPoint.y);
				sp.graphics.lineTo(startColInGlobalPoint.x+colp.width,startColInGlobalPoint.y+this.height);
			}else{
				startColInGlobalPoint = gridView.contentContainer.localToGlobal(new Point(0,0));
				sp.graphics.lineStyle(5,0x0000ff);
				sp.graphics.moveTo(startColInGlobalPoint.x,startColInGlobalPoint.y);
				sp.graphics.lineTo(startColInGlobalPoint.x,startColInGlobalPoint.y+this.height);
			}
			
		}		
		
		private function getColMoveToIndex(stageX:Number):int{
			var gridView:GridView = GridController.getInstance().getGridView(this._gridname);
			var grid:IGrid = GridController.getInstance().getGrid(this._gridname);
			var colindex:int = gridView.getColIndexByStagePos(stageX);
			if(colindex==-1){
				var gridViewInGlobalPoint:Point = gridView.contentContainer.localToGlobal(new Point(0,0));
				if(gridViewInGlobalPoint.x>(stageX)){
					colindex = -1;
				}else{
					colindex = grid.colcount-1; 
				}
			}
			return colindex;
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

		public function get colindex():int
		{
			return _colindex;
		}

		public function set colindex(value:int):void
		{
			_colindex = value;
		}

		public function get canMove():Boolean
		{
			return _canMove;
		}

		public function set canMove(value:Boolean):void
		{
			_canMove = value;
		}


	}
}