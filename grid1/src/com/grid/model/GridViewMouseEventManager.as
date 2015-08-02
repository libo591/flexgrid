package com.grid.model
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.IGrid;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class GridViewMouseEventManager
	{
		private var _gridName:String;
		private static var obj:Object = {};
		
		public function GridViewMouseEventManager()
		{
			
		}
		
		public static function getInst(gn:String):GridViewMouseEventManager{
			if(!obj[gn]){obj[gn] = new GridViewMouseEventManager();}
			GridViewMouseEventManager(obj[gn]).gridName = gn;
			return GridViewMouseEventManager(obj[gn]); 
		} 
		
		public function get gridName():String
		{
			return _gridName;
		}

		public function set gridName(value:String):void
		{
			_gridName = value;
		}
		
		/*private var _hitdownrow:int=-1;
		private var _hitdowncol:int=-1;
		private var _hitdownType:String;
		private var _hitmoverow:int=-1;
		private var _hitmovecol:int=-1;
		private var _hitmoveType:String;*/
		private var _hitrow:int=-1;
		private var _hitcol:int=-1;
		private var _hitType:String;
		private var _shifthitrow:int=-1;
		private var _shifthitcol:int=-1;
		private var _shifthitType:String;
		public static const HITTYPE_CELL:String="cell";
		public static const HITTYPE_ROWHEADER:String="rowheader";
		public static const HITTYPE_COLHEADER:String="colheader";
		public static const HITTYPE_CORNER:String="corner";
		public static const HITTYPE_BLANK:String="blank";
		public function doMouseClick(e:MouseEvent):void{
			if(GridController.getInstance().mouseState.onResize){
				return;
			}
			var gv:GridView = GridController.getInstance().getGridView(this._gridName);
			var g:IGrid = GridController.getInstance().getGrid(this._gridName);
			var nowhitrow:int = gv.getRowIndexByStagePos(e.stageY);
			var nowhitcol:int = gv.getColIndexByStagePos(e.stageX);
			var nowhitType:String = hitType(e.stageX,e.stageY);
			MonsterDebugger.trace(this,[nowhitrow,nowhitcol].join("="));
			if(e.shiftKey){
				this._shifthitrow = nowhitrow;
				this._shifthitcol = nowhitcol;
				this._shifthitType = nowhitType;
			}else{
				this._hitrow = nowhitrow;
				this._hitcol = nowhitcol;
				this._hitType = nowhitType;
				this._shifthitrow = this._hitrow;
				this._shifthitcol = this._hitcol;
				this._shifthitType = this._hitType;
			}
			drawByHit();
			//gv.addEventListener(MouseEvent.MOUSE_MOVE,gvMouseMove);
			//gv.addEventListener(MouseEvent.MOUSE_UP,gvMouseUp);
		}
		private function drawByHit():void{
			var gv:GridView = GridController.getInstance().getGridView(this._gridName);
			var g:IGrid = GridController.getInstance().getGrid(this._gridName);
			if(this._hitType==HITTYPE_CORNER){
				MonsterDebugger.trace(this,"click corner");
				//drawAll
				var ris:Array = gv.getCurrRowIndexs();
				gv.drawSelectContent(ris[0],ris[1],0,g.colcount-1);
			}else if(this._hitType==HITTYPE_COLHEADER){
				MonsterDebugger.trace(this,"click colheader");
				//drawCol
				if(this._hitType==-1||this._shifthitcol==-1){return;}
				var a:int = Math.min(this._hitcol,this._shifthitcol);
				var b:int = Math.max(this._hitcol,this._shifthitcol);
				var ris:Array = gv.getCurrRowIndexs();
				MonsterDebugger.trace(this,ris.join("="));
				gv.drawSelectContent(ris[0],ris[1],a,b);
			}else if(this._hitType==HITTYPE_ROWHEADER){
				MonsterDebugger.trace(this,"click rowheader");
				if(this._hitrow==-1||this._shifthitrow==-1){return;}
				var a:int = Math.min(this._hitrow,this._shifthitrow);
				var b:int = Math.max(this._hitrow,this._shifthitrow);
				gv.drawSelectContent(a,b,0,g.colcount-1);
			}else if(this._hitType==HITTYPE_CELL){
				MonsterDebugger.trace(this,"click cell");
				if(this._hitrow==-1||this._shifthitrow==-1||this._hitcol==-1||this._shifthitcol==-1){return;}
				var c:int = Math.min(this._hitrow,this._shifthitrow);
				var d:int = Math.max(this._hitrow,this._shifthitrow);
				var a:int = Math.min(this._hitcol,this._shifthitcol);
				var b:int = Math.max(this._hitcol,this._shifthitcol);
				for(var i:int=c;i<=d;i++){
					for(var j:int=a;j<=b;j++){
						var ma:MergeArea = gv.getMergeArea(i,j);
						if(ma!=null){
							a = Math.min(ma.sc,a);
							b = Math.max(ma.ec,b);
							c = Math.min(ma.sr,c);
							d = Math.max(ma.er,d);
						}
					}
				}
				gv.drawSelectContent(c,d,a,b);
			}else{
				gv.hideSelectContent();
			}
		}
		
		/*private function gvMouseMove(e:MouseEvent):void{
			if(e.buttonDown){
				var gv:GridView = GridController.getInstance().getGridView(this._gridName);
				var g:IGrid = GridController.getInstance().getGrid(this._gridName);
				this._hitmoverow = gv.getRowIndexByStagePos(e.stageY);
				this._hitmovecol = gv.getColIndexByStagePos(e.stageX);
				this._hitmoveType = hitType(e.stageX,e.stageY);
				
			}
		}*/
		/*private function gvMouseUp(e:MouseEvent):void{
			//drawByHit();
			this._hitdownrow = -1;
			this._hitdowncol = -1;
			this._hitmoverow = -1;
			this._hitmovecol = -1;
			
			var gv:GridView = GridController.getInstance().getGridView(this._gridName);
			//gv.removeEventListener(MouseEvent.MOUSE_MOVE,gvMouseMove);
			gv.removeEventListener(MouseEvent.MOUSE_UP,gvMouseUp);
		}*/
		
		private function hitType(stageX:Number,stageY:Number):String{
			var gv:GridView = GridController.getInstance().getGridView(this._gridName);
			var p0:Point = gv.localToGlobal(new Point(gv.corner.x,gv.corner.y));
			var p1:Point = new Point(p0.x+gv.corner.width,p0.y+gv.corner.height);
			var p2:Point = new Point(p0.x+gv.scrollWidth,p0.y+gv.scrollHeight);
			var hittype:String = "";
			if(stageX>=p0.x&&stageX<=p1.x
				&&stageY>=p0.y&&stageY<=p1.y){
				hittype = HITTYPE_CORNER;
			}else if(stageX>=p1.x&&stageX<=p2.x
				&&stageY>=p0.y&&stageY<=p1.y){
				hittype = HITTYPE_COLHEADER;
			}else if(stageX>=p0.x&&stageX<=p1.x
				&&stageY>=p1.y&&stageY<=p2.y){
				hittype = HITTYPE_ROWHEADER;
			}else if(stageX>=p1.x&&stageX<=p2.x
				&&stageY>=p1.y&&stageY<=p2.y){
				hittype = HITTYPE_CELL;
			}else{
				hittype = HITTYPE_BLANK;
			} 
			return hittype;
		}
		
	}
}