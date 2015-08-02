package com.grid.model.header
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.IGrid;
	import com.grid.model.CommonCellView;
	import com.grid.model.GridConst;
	import com.grid.model.GridController;
	import com.grid.styles.GridStyleController;
	import com.grid.styles.GridStyleDeclare;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.text.engine.FontWeight;
	
	import morn.core.components.Label;
	
	
	public class RowHeaderCellView extends CommonCellView
	{
		private var _label:Label;
		private var _uiSplit:RowHeaderSplit;
		private var _uiSplitTop:RowHeaderSplit;
		public function RowHeaderCellView()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,add2Stage);
		}
		
		protected function add2Stage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,add2Stage);
			addRowHeaderMove();
			addRowHeaderSplitOnBottom();
			drawContent();
		}		
		
		private function drawContent():void{
			MonsterDebugger.trace(this,"=====["+[this.rowindex,this.colindex].join(",")+"]=====RowHeaderCellView.drawContent=====");
			if(this.rowindex>0){
				addRowHeaderSplitOnTop();
			}
			if(this.colindex!=-1){
				this.text = GridController.getInstance().getGrid(this.gridname).getCellInPosition(this.rowindex,this.colindex).extendProp.text;
			}
			var sh:Number = 5;
			if(this._uiSplitTop){
				drawTopSplitContent(sh);
			}
			if(this._label){
				drawLabelContent(sh);
			}
			if(this._uiSplit){
				drawBottomSplitContent(sh);
			}
		}
		private function addRowHeaderMove():void{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				this._label = new RowHeaderMove();
				RowHeaderMove(this._label).rowindex = this.rowindex;
				RowHeaderMove(this._label).gridname = this.gridname;
			}else{
				this._label = new Label();
			}
			this._label.bold = FontWeight.BOLD;
			this._label.multiline = false;
			this.addChild(this._label);
		}
		private function addRowHeaderSplitOnTop():void{
			if(this._uiSplitTop){
				this.removeChild(this._uiSplitTop);
				this._uiSplitTop = null;
			}
			this._uiSplitTop = new RowHeaderSplit(RowHeaderSplit.TOP);
			this._uiSplitTop.gridname = this.gridname;
			this._uiSplitTop.rowIndex = this.rowindex; 
			this.addChild(this._uiSplitTop);
		}
		private function addRowHeaderSplitOnBottom():void{
			this._uiSplit = new RowHeaderSplit(RowHeaderSplit.BOTTOM);
			this._uiSplit.gridname = this.gridname;
			this._uiSplit.rowIndex = this.rowindex; 
			this.addChild(this._uiSplit);
		}
		private function drawLabelContent(spHeight:Number):void{
			this._label.text = this.text;
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				this._label.toolTip = this.text;
			}
			this._label.align = TextFormatAlign.CENTER;
			this._label.textField.y = this.height/2-this._label.textField.height/2;
		}
		private function drawTopSplitContent(spHeight:Number):void{
			this._uiSplitTop.w = this.width;
			this._uiSplitTop.h = spHeight;
			this._uiSplitTop.drawx = 0;
			this._uiSplitTop.drawy = 0;
			this._uiSplitTop.drawContent();
		}
		private function drawBottomSplitContent(spHeight:Number):void{
			this._uiSplit.w = this.width;
			this._uiSplit.h = spHeight;
			this._uiSplit.drawx = 0;
			this._uiSplit.drawy = this.height-spHeight;
			this._uiSplit.drawContent();
		}
		override public function set text(value:String):void
		{
			super.text = value;
			if(this._label){
				this._label.text = value;
			}
		}
		override public function set height(value:Number):void{
			super.height = value;
			this.drawContent();
		}
		
		private function drawStyle(c1:int,c2:int,c3:int,c4:int):void{
			this._label.color = c1;
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle(1,c4);
			g.beginGradientFill(GradientType.LINEAR,[c2,c3],[1,1],[0,1]);
			g.drawRect(0,0,this.width,this.height);
			g.endFill();
		}
		private function overDraw1(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OVER,overDraw1);
			this._label.addEventListener(MouseEvent.ROLL_OUT,outDraw1);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(0);
			var bc1:Array = gsc.getHeaderCellOverBackColor(0);
			var brc:int = gsc.getHeaderCellNormalBorderColor(0);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		private function overDraw2(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OVER,overDraw2);
			this._label.addEventListener(MouseEvent.ROLL_OUT,outDraw2);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(0);
			var bc1:Array = gsc.getHeaderCellOverSelectionColor(0);
			var brc:int = gsc.getHeaderCellSelectBorderColor(0);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		private function outDraw1(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw1);
			this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw1);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(0);
			var bc1:Array = gsc.getHeaderCellOutBackColor(0);
			var brc:int = gsc.getHeaderCellNormalBorderColor(0);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		private function outDraw2(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw2);
			this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw2);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(0);
			var bc1:Array = gsc.getHeaderCellOutSelectionColor(0);
			var brc:int = gsc.getHeaderCellSelectBorderColor(0);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		public function drawSelect():void{
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(0);
			var bc1:Array = gsc.getHeaderCellOutSelectionColor(0);
			var brc:int = gsc.getHeaderCellSelectBorderColor(0);
			drawStyle(color,bc1[0],bc1[1],brc);
			this._label.removeEventListener(MouseEvent.ROLL_OVER,overDraw1);
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw1);
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw2);
			this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw2);
		}
		override public function drawNormal():void{
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(0);
			var bc1:Array = gsc.getHeaderCellOutBackColor(0);
			var brc:int = gsc.getHeaderCellNormalBorderColor(0);
			drawStyle(color,bc1[0],bc1[1],brc);
			if(this._label){
				this._label.removeEventListener(MouseEvent.ROLL_OVER,overDraw2);
				this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw2);
				this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw1);
				this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw1);
			}
		}
	}
}