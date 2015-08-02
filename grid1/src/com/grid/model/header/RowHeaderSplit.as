package com.grid.model.header
{
	
	import com.basic.cursor.CursorManager;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class RowHeaderSplit extends Sprite
	{
		private var _w:Number;
		private var _h:Number;
		private var _drawx:Number;
		private var _drawy:Number;
		private var _rowIndex:int;
		private var _gridname:String;
		private var _pos:int;
		public static const TOP:int = 0;
		public static const BOTTOM:int = 1;
		
		public function RowHeaderSplit(t:int)
		{
			this._pos = t;
			initContent();
			initEvent();
		}
		
		private function initEvent():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER,mouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT,mouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN,uiSplitDown);
		}
		
		private var startPos:Number=0;
		private var endPos:Number =0;
		private function uiSplitDown(e:MouseEvent):void{
			startPos = e.stageY;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,stageDragMouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,stageDragMouseUp);
		}
		private var spmovename:String = "rowheadersplitmovesprite";
		protected function stageDragMouseUp(event:MouseEvent):void
		{
			endPos = event.stageY;
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,stageDragMouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,stageDragMouseUp);
			var dp:DisplayObject = this.stage.getChildByName(this.spmovename);
			if(dp!=null){
				this.stage.removeChild(dp);
			}
			var rowindex:int = this._pos==BOTTOM?this._rowIndex:this._rowIndex-1;
			GridController.getInstance().resizeRow(this._gridname,rowindex,endPos-startPos);
			
			startPos = 0;
			endPos = 0;
		}
		
		protected function stageDragMouseMove(event:MouseEvent):void
		{
			var nowPos:Number = event.stageY;
			if(this._pos==BOTTOM){
				var rp:RowProp = GridController.getInstance().getGrid(this._gridname).getRowProp(this.rowIndex);
				if(nowPos-startPos<-(rp.height)){
					return;
				}
			}else{
				var toprp:RowProp = GridController.getInstance().getGrid(this._gridname).getRowProp(this.rowIndex-1);
				if(nowPos-startPos<-(toprp.height)){
					return;
				}
			}
			//创建移动时的显示效果
			var dp:DisplayObject = this.stage.getChildByName(this.spmovename);
			var sp:Sprite = null;
			if(dp==null){
				sp = new Sprite();
				sp.name = this.spmovename;
				this.stage.addChild(sp);
			}else{
				sp = Sprite(dp);
			}
			sp.visible = true;
			sp.graphics.clear();
			sp.graphics.lineStyle(1,0x000000);
			sp.graphics.moveTo(0,event.stageY);
			sp.graphics.lineTo(this.stage.width,event.stageY);
		}
		[Embed(source="/assets/dragv.png")]
		[Bindable]
		private var dragv:Class;
		private function mouseOver(e:Event):void{
			CursorManager.setCursor(dragv,-5.5,-6.5);
		}
		private function mouseOut(e:Event):void{
			CursorManager.removeAllCursors();
		}
		private function initContent():void
		{
			
		}	
		
		public function drawContent():void{
			this.graphics.clear();
			this.graphics.beginFill(0x000000,0);
			
			this.graphics.drawRect(this.drawx,this.drawy,this.w,this.h);
			this.graphics.endFill();
		}
		
		public function get w():Number
		{
			return _w;
		}
		
		public function set w(value:Number):void
		{
			_w = value;
		}
		
		public function get h():Number
		{
			return _h;
		}
		
		public function set h(value:Number):void
		{
			_h = value;
		}
		
		public function get drawx():Number
		{
			return _drawx;
		}
		
		public function set drawx(value:Number):void
		{
			_drawx = value;
		}
		
		public function get drawy():Number
		{
			return _drawy;
		}
		
		public function set drawy(value:Number):void
		{
			_drawy = value;
		}
		
		public function get rowIndex():int
		{
			return _rowIndex;
		}
		
		public function set rowIndex(value:int):void
		{
			_rowIndex = value;
		}
		
		public function get gridname():String
		{
			return _gridname;
		}
		
		public function set gridname(value:String):void
		{
			_gridname = value;
		}
		
	}
}