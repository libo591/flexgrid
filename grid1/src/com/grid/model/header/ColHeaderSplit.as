package com.grid.model.header
{
	
	import com.basic.cursor.CursorManager;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ColHeaderSplit extends Sprite
	{
		private var _w:Number;
		private var _h:Number;
		private var _drawx:Number;
		private var _drawy:Number;
		private var _colIndex:int;
		private var _gridname:String;
		private var _pos:int;
		public static const RIGHT:int = 0;
		public static const LEFT:int = 1;
		
		public function ColHeaderSplit(t:int)
		{
			this._pos = t;
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
			startPos = e.stageX;
			GridController.getInstance().mouseState.onResize = true;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,stageDragMouseMove);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,stageDragMouseUp);
		}
		
		private var spmovename:String = "headersplitmovesprite";
		protected function stageDragMouseUp(event:MouseEvent):void
		{
			endPos = event.stageX;
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,stageDragMouseMove);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,stageDragMouseUp);
			var dp:DisplayObject = this.stage.getChildByName(this.spmovename);
			if(dp!=null){
				this.stage.removeChild(dp);
			}
			var colindex:int = this._pos==RIGHT?this._colIndex:this._colIndex-1;
			GridController.getInstance().resizeCol(this._gridname,colindex,endPos-startPos);
			
			startPos = 0;
			endPos = 0;
			GridController.getInstance().mouseState.onResize = false;
		}
		
		protected function stageDragMouseMove(event:MouseEvent):void
		{
			var nowPos:Number = event.stageX;
			if(this._pos==RIGHT){
				var cp:ColProp = GridController.getInstance().getGrid(this._gridname).getColProp(this._colIndex);
				if(nowPos-startPos<-(cp.width)){
					return;
				}
			}else if(this._pos==LEFT){
				var cpLeft:ColProp = GridController.getInstance().getGrid(this._gridname).getColProp(this._colIndex-1);
				if(nowPos-startPos<-(cpLeft.width)){
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
			sp.graphics.moveTo(event.stageX,0);
			sp.graphics.lineTo(event.stageX,this.stage.height);
		}
		[Embed(source="/assets/dragh.png")]
		[Bindable]
		private var dragh:Class;
		
		private function mouseOver(e:Event):void{
			CursorManager.setCursor(dragh,-6.5,-5);
		}
		private function mouseOut(e:Event):void{
			CursorManager.removeAllCursors();
		}
		
		public function drawContent():void{
			this.graphics.clear();
			this.graphics.beginFill(0xFF0000,0);
			this.graphics.drawRect(this._drawx,this._drawy,this._w,this._h);
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

		public function get colIndex():int
		{
			return _colIndex;
		}

		public function set colIndex(value:int):void
		{
			_colIndex = value;
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