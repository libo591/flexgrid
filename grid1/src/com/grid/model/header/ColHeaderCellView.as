package com.grid.model.header
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.IGrid;
	import com.grid.model.CommonCellView;
	import com.grid.model.GridConst;
	import com.grid.model.GridController;
	import com.grid.model.GridView;
	import com.grid.model.MergeArea;
	import com.grid.styles.GridStyleController;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	import morn.core.components.Label;
	
	public class ColHeaderCellView extends CommonCellView
	{
		private var _label:Label;
		private var _uiSplit:ColHeaderSplit;
		private var _uiSplitLeft:ColHeaderSplit;
		private var _headerFunc:HeaderFuncComponent;
		
		public function ColHeaderCellView()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,add2Stage);
		}
		
		protected function add2Stage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,add2Stage);
			addColHeaderFunc();
			addColHeaderMove();
			addColHeaderSplitOnRight();
			callLater(this.drawContent);
		}	
		
		private function addColHeaderFunc():void
		{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var gv:GridView = GridController.getInstance().getGridView(this.gridname);
			if(hasHeaderFunc()){
				this._headerFunc = new HeaderFuncComponent();
				this._headerFunc.colindex = this.colindex;
				this._headerFunc.rowindex = this.rowindex;
				this._headerFunc.gridname = this.gridname;
				this.addChild(this._headerFunc);
			}
		}
		private function hasHeaderFunc():Boolean{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_NORMAL){
				return false;
			}
			var gv:GridView = GridController.getInstance().getGridView(this.gridname);
			var cp:ColProp = grid.getColProp(this.colindex);
			if(!cp.headerFunc.canSort()&&!cp.headerFunc.canFilter()){
				return false;
			}
			var ma:MergeArea = gv.getMergeArea(this.rowindex,this.colindex);
			if(ma!=null){
				if(ma.ec-ma.sc>1){
					return false;
				}
			}
			return true;
		}
		private function drawContent():void{
			if(this.colindex>0){
				addColHeaderSplitOnLeft();
			}
			if(this.rowindex!=-1){
				this.text = GridController.getInstance().getGrid(this.gridname).getCellInPosition(this.rowindex,this.colindex).extendProp.text;
			}
			var sw:Number = 5;
			var sw2:Number = 0;
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				var cp:ColProp = grid.getColProp(this.colindex);
				if(cp.headerFunc.canSort()){
					sw2+=16;
				}
				if(cp.headerFunc.canFilter()){
					sw2+=16;
				}
			}
			if(this._uiSplitLeft){
				drawLeftSplitContent(sw);
			}
			if(this._label){
				drawLabelContent(sw,sw2);
			}
			if(this._headerFunc){
				drawColHeaderFunc(sw,sw2);
			}
			if(this._uiSplit){
				drawRightSplitContent(sw);
			}
		}
		
		private function drawColHeaderFunc(sw:Number, sw2:Number):void
		{
			this._headerFunc.height = this.height;
			this._headerFunc.width = sw2;
			this._headerFunc.x = this.width-sw-sw2;
			this._headerFunc.y = 0;
		}
		private function addColHeaderMove():void{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				this._label = new ColHeaderMove();
				ColHeaderMove(this._label).colindex = this.colindex;
				ColHeaderMove(this._label).gridname = this.gridname;
			}else{
				this._label = new Label();
			}
			this._label.bold = "true";
			this._label.multiline = false;
			this.addChild(this._label);
		}
		private function addColHeaderSplitOnLeft():void{
			if(this._uiSplitLeft){
				this.removeChild(this._uiSplitLeft);
				this._uiSplitLeft = null;
			}
			this._uiSplitLeft = new ColHeaderSplit(ColHeaderSplit.LEFT);
			this._uiSplitLeft.gridname = this.gridname;
			this._uiSplitLeft.colIndex = this.colindex; 
			this.addChild(this._uiSplitLeft);
		}
		private function addColHeaderSplitOnRight():void{
			this._uiSplit = new ColHeaderSplit(ColHeaderSplit.RIGHT);
			this._uiSplit.gridname = this.gridname;
			this._uiSplit.colIndex = this.colindex; 
			this.addChild(this._uiSplit);
		}
		private function drawLabelContent(spWidth:Number,sw:Number):void{
			this._label.text = this.text;
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				this._label.toolTip = this.text;
			}
			this._label.x = this.width/2-this._label.width/2;
			this._label.align = TextFormatAlign.CENTER;
			this._label.textField.y = this.height/2-this._label.textField.height/2;
		}
		private function drawLeftSplitContent(spWidth:Number):void{
			this._uiSplitLeft.w = spWidth;
			this._uiSplitLeft.h = this.height;
			this._uiSplitLeft.drawx = 0;
			this._uiSplitLeft.drawy = 0;
			this._uiSplitLeft.drawContent();
		}
		private function drawRightSplitContent(spWidth:Number):void{
			this._uiSplit.w = spWidth;
			this._uiSplit.h = this.height;
			this._uiSplit.drawx = this.width - spWidth;
			this._uiSplit.drawy = 0;
			this._uiSplit.drawContent();
		}

		override public function set text(value:String):void
		{
			super.text = value;
			if(this._label){
				this._label.text = value;
			}
		}

		override public function setSize(w:Number,h:Number):void{
			super.setSize(w,h);
			callLater(this.drawContent);
		}
		
		
		private function drawStyle(c1:int,c2:int,c3:int,c4:int):void{
			if(this._label){
				this._label.color = c1;
			}
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
			var color:int = gsc.getHeaderCellColor(1);
			var bc1:Array = gsc.getHeaderCellOverBackColor(1);
			var brc:int = gsc.getHeaderCellNormalBorderColor(1);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		private function overDraw2(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OVER,overDraw2);
			this._label.addEventListener(MouseEvent.ROLL_OUT,outDraw2);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(1);
			var bc1:Array = gsc.getHeaderCellOverSelectionColor(1);
			var brc:int = gsc.getHeaderCellSelectBorderColor(1);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		private function outDraw1(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw1);
			this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw1);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(1);
			var bc1:Array = gsc.getHeaderCellOutBackColor(1);
			var brc:int = gsc.getHeaderCellNormalBorderColor(1);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		private function outDraw2(e:MouseEvent):void{
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw2);
			this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw2);
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(1);
			var bc1:Array = gsc.getHeaderCellOutSelectionColor(1);
			var brc:int = gsc.getHeaderCellSelectBorderColor(1);
			drawStyle(color,bc1[0],bc1[1],brc);
		}
		public function drawSelect():void{
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(1);
			var bc1:Array = gsc.getHeaderCellOutSelectionColor(1);
			var brc:int = gsc.getHeaderCellSelectBorderColor(1);
			drawStyle(color,bc1[0],bc1[1],brc);
			this._label.removeEventListener(MouseEvent.ROLL_OVER,overDraw1);
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw1);
			this._label.removeEventListener(MouseEvent.ROLL_OUT,outDraw2);
			this._label.addEventListener(MouseEvent.ROLL_OVER,overDraw2);
		}
		override public function drawNormal():void{
			var gsc:GridStyleController = GridStyleController.getInst();
			var color:int = gsc.getHeaderCellColor(1);
			var bc1:Array = gsc.getHeaderCellOutBackColor(1);
			var brc:int = gsc.getHeaderCellNormalBorderColor(1);
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