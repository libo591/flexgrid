package com.grid.model
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.IGrid;
	import com.grid.model.cell.CellView;
	import com.grid.model.header.ColHeaderCellView;
	import com.grid.model.header.ColProp;
	import com.grid.model.header.RowHeaderCellView;
	import com.grid.model.header.RowProp;
	import com.grid.styles.GridStyleController;
	import com.grid.styles.GridStyleDeclare;
	import com.grid.utils.CellUtil;
	import com.grid.utils.NormalStringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.components.Label;
	import morn.core.components.ScrollBar;
	import morn.core.events.UIEvent;
	
	import r1.deval.D;

	public class GridView extends Box
	{
		public static var MAXROWCOUNT_SHOW:int = 30;
		private var _controller:GridController;
		private var _gridname:String;
		private var _corner:Label;
		private var _colHeaderContainer:Box;
		private var _rowHeaderContainer:Box;
		private var _contentContainer:Box;
		private var _scrollWidth:Number;//通知gridView外围滚动条的限制宽度，gridView本身并不产生滚动条
		private var _scrollHeight:Number;//通知gridView外围滚动条的限制高度
		private var _cells:Array=[];//当前展现的cellView数组
		private var _selectionArea:MergeArea=new MergeArea();
		/**
		 * 创建子组件，为实例中的相关变量初始化
		 */
		public function GridView(name:String=null)
		{
			_controller = GridController.getInstance();
			this._corner = new Label();
			this._colHeaderContainer = new Box();
			this._rowHeaderContainer = new Box();
			this._contentContainer = new Box();
			this._gridname = name;
			if(this._gridname==null||this._gridname==""){
				this._gridname = gridViewDefaultNameGenerator();
			}
			
			//this._contentContainer.addEventListener(MouseEvent.MOUSE_MOVE,contentMouseMove);
			this.addEventListener(MouseEvent.CLICK,mouseClick);
		}
		
		private function gridViewDefaultNameGenerator():String{
			return "Sheet"+(++GridController.getInstance().gridIndex);
		}
		
		public function get contentContainer():Box
		{
			return _contentContainer;
		}

		public function set contentContainer(value:Box):void
		{
			_contentContainer = value;
		}

		public function get colHeaderContainer():Box
		{
			return _colHeaderContainer;
		}

		public function set colHeaderContainer(value:Box):void
		{
			_colHeaderContainer = value;
		}

		/**
		 * 销毁init中创建的资源
		 */
		public function destroy():void{
			this.graphics.clear();
		}
		
		private function mouseClick(e:MouseEvent):void{
			GridViewMouseEventManager.getInst(this._gridname).doMouseClick(e);
		}
		
		/*protected function contentMouseMove(event:MouseEvent):void
		{
			CursorManager.setCursor(MouseStyleOfNormalCell);
		}*/
		private function disposePage(page:Page):void{
			var sr:int = page.startRow;
			var er:int = page.endRow;
			this.disposeRows(sr,er);
		}
		private function drawPage(page:Page):void{
			var sr:int = page.startRow;
			var er:int = page.endRow;
			this.drawRows(sr,er);
		}
		public function drawPages(gn:String,scrollDirec:String=null):void{
			if(gn ==this.gridname){
				this._contentContainer.graphics.clear();
				this._contentContainer.width = 0;
				var pageBuilder:PageBuilder = GridController.getInstance().getPageBuilder(this.gridname);
				var pageDrawArray:Array = null;
				var pageDispose:Page = null;
				if(scrollDirec=="toTop"){
					var delindex:int = pageBuilder.currPage+(PageBuilder.showStep-1);
					pageDispose = pageBuilder.getPage(delindex);
					pageDrawArray = pageBuilder.toPrePage();
					if(delindex==pageBuilder.currPage+(PageBuilder.showStep-1)){
						pageDispose = null;
					}
				}else if(scrollDirec=="toBottom"){
					var delindex:int = pageBuilder.currPage;
					pageDispose = pageBuilder.getPage(delindex);
					pageDrawArray = pageBuilder.toNextPage();
					if(delindex==pageBuilder.currPage){
						pageDispose = null;
					}
				}else{
					pageDrawArray = pageBuilder.getCurrShow();
				}
				if(pageDispose!=null){
					this.disposePage(pageDispose);
				}
				var rowindexs:Array = this.getCurrRowIndexs();
				calcHeaderPosition(rowindexs[0],rowindexs[1]);
				if(gridModel().type==GridConst.GRIDTYPE_NORMAL){
					this.drawEditHeader(rowindexs[0],rowindexs[1]);
				}
				var pagecount:int = pageDrawArray.length;
				for(var i:int=0;i<pagecount;i++){
					this.drawPage(pageDrawArray[i] as Page);
				}
				this.resizeChildContainer();
				headerMove(ScrollBar.VERTICAL,0);
				
				this.removeStyle();
				this.constructStyle();
				MonsterDebugger.trace(this,"内容区域宽高"+[this.width,this.height].join("="));
				MonsterDebugger.trace(this,"可视区域宽高"+[this.scrollWidth,this.scrollHeight].join("="));
			}
		}
		
		public function getMergeArea(r:int,c:int):MergeArea{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var mcount:int = grid.mergeAreas.length;
			for(var i:int=0;i<mcount;i++){
				var ma:MergeArea = grid.mergeAreas[i] as MergeArea;
				if(r>=ma.sr&&r<=ma.er
					&&c>=ma.sc&&c<=ma.ec){
					return ma;
				}
			}
			return null;
		}
		private function disposeRows(startRow:int,endRow:int):void{
			if(startRow==-1||endRow==-1){
				return;
			}
			for(var i:int=startRow;i<=endRow;i++){
				var rp:RowProp = gridModel().getRowProp(i);
				if(rp.type==RowProp.ROWTYPE_NORMAL){
					if(rp.visiable){
						disposeOneRow(i);
					}
				}
			}
		}
		private function drawRows(startRow:int,endRow:int):void{
			for(var i:int=startRow;i<=endRow;i++){
				var rp:RowProp = gridModel().getRowProp(i);
				if(rp.visiable){
					drawOneRow(i);
				}else{
					disposeOneRow(i);
				}
			}
		}
		private function resizeChildContainer():void{
			if(gridModel().type == GridConst.GRIDTYPE_NORMAL){
				this._corner.x = 0;
				this._corner.y = 0;
				this._corner.width = rowHeaderWidth();
				this._corner.height = colHeaderHeight();
				this.addChild(this._corner);
				
				this._colHeaderContainer.x = this._corner.width;
				this._colHeaderContainer.y = 0;
				this.addChild(this._colHeaderContainer);
				
				this._rowHeaderContainer.x = 0;
				this._rowHeaderContainer.y = this._corner.height;
				this._rowHeaderContainer.height = this.scrollHeight*PageBuilder.showStep;
				this.addChild(this._rowHeaderContainer);
				
				this._contentContainer.x = this._corner.width;
				this._contentContainer.y = this._corner.height;
				this._contentContainer.width = this.colHeaderContainer.width;
				this._contentContainer.height = this.scrollHeight*PageBuilder.showStep;
				this.addChild(this._contentContainer);
				this.width = this._corner.width+this._contentContainer.width;
				this.height = this._corner.height+this._contentContainer.height;
			}else{
				if(this._corner){
					this._corner.visible = false;
					this._corner.width = 0;
					this._corner.height = 0;
				}
				if(this._colHeaderContainer){
					this._colHeaderContainer.visible = false;
					this._colHeaderContainer.width = 0;
					this._colHeaderContainer.height = 0;
				}
				if(this._colHeaderContainer){
					this._rowHeaderContainer.visible = false;
					this._rowHeaderContainer.width = 0;
					this._rowHeaderContainer.height = 0;
				}
				
				this._contentContainer.x = 0;
				this._contentContainer.y = 0;
				var collen:int = gridModel().colcount;
				for(var colIndex:int=0;colIndex<collen;colIndex++){
					this._contentContainer.width +=colWidth(colIndex);
				}
				this._contentContainer.height = this.scrollHeight*PageBuilder.showStep;
				this.addChild(this._contentContainer);
				this.width = this._contentContainer.width;
				this.height = this._contentContainer.height;
			}
		}
		private function calcHeaderPosition(startRow:int,endRow):void{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var colcount:int = grid.colcount;
			var headerHeight:Number = colHeaderHeight();
			for(var colindex:int=0;colindex<colcount;colindex++){
				var cp:ColProp = grid.getColProp(colindex);
				if(colindex==0){
					cp.x = 0;
				}else{
					var lastcp:ColProp = grid.getColProp(colindex-1);
					if(lastcp.visiable){
						cp.x = lastcp.x+lastcp.width;
					}else{
						cp.x = lastcp.x;
					}
				}
			}
			for(var ri:int=startRow;ri<=endRow;ri++){
				var rp:RowProp = grid.getRowProp(ri);
				if(ri==startRow){
					rp.y = 0;
				}else{
					var lastrp:RowProp = grid.getRowProp(ri-1);
					if(lastrp.visiable){
						rp.y = lastrp.y+lastrp.height;
					}else{
						rp.y = lastrp.y;
					}
				}
			}
		}
		private function drawEditHeader(startRow:int,endRow:int):void{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var colcount:int = grid.colcount;
			var headerHeight:Number = colHeaderHeight();
			var headerWidth:Number = 0;
			for(var colindex:int=0;colindex<colcount;colindex++){
				headerWidth += colWidth(colindex);
				var childNum:int = this._colHeaderContainer.numChildren;
				var cellEle:DisplayObject = null;
				if(childNum>=colindex+1){
					cellEle = this._colHeaderContainer.getChildAt(colindex);
				}
				var cellHeader:ColHeaderCellView=null;
				if(cellEle==null){
					cellHeader = new ColHeaderCellView();
					cellHeader.colindex = colindex;
					cellHeader.gridname = this._gridname;
				}else{
					cellHeader = ColHeaderCellView(cellEle);
				}
				cellHeader.x = colX(colindex);
				cellHeader.y = colHeaderY();
				cellHeader.width = colWidth(colindex);
				cellHeader.height = colHeaderHeight();
				cellHeader.text = CellUtil.getColNameByIndex(colindex);
				if(cellEle==null){
					this._colHeaderContainer.addChild(cellHeader);
				}else{
					this._colHeaderContainer.addChildAt(cellHeader,colindex);
				}
			}
			this._colHeaderContainer.height = headerHeight;
			this._colHeaderContainer.width  = headerWidth;
			
			
			var rhw:Number = rowHeaderWidth();
			
			for(var ri:int=startRow;ri<=endRow;ri++){
				var rowChildNum:int = this._rowHeaderContainer.numChildren;
				var rowcellEle:DisplayObject = null;
				if(rowChildNum>=ri+1){
					rowcellEle = this._rowHeaderContainer.getChildAt(ri);
				}
				var rowcellHeader:RowHeaderCellView=null;
				if(rowcellEle==null){
					rowcellHeader = new RowHeaderCellView();
					rowcellHeader.rowindex = ri;
					rowcellHeader.gridname = this._gridname;
				}else{
					rowcellHeader = RowHeaderCellView(rowcellEle);
				}
				rowcellHeader.x = rowHeaderX();
				rowcellHeader.y = rowY(ri);
				rowcellHeader.width = rowHeaderWidth();
				rowcellHeader.height = rowHeight(ri);
				rowcellHeader.text = ""+(ri+1);
				if(rowcellEle==null){
					this._rowHeaderContainer.addChild(rowcellHeader);
				}else{
					this._rowHeaderContainer.addChildAt(rowcellHeader,ri);
				}
			}
			this._rowHeaderContainer.width  = rhw;
		}
		
		private function isOnRowTableHeader(ri:int):Boolean{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				var rp:RowProp = grid.getRowProp(ri);
				if(rp.type == RowProp.ROWTYPE_TABLEHEADER){
					return true;
				}
			}
			return false;
		}
		private function isOnColTableLeftHeader(ci:int):Boolean{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			if(grid.type==GridConst.GRIDTYPE_DISPLAY){
				var cp:ColProp = grid.getColProp(ci);
				if(cp.type == ColProp.COLTYPE_LEFTHEADER){
					return true;
				}
			}
			return false;
		}
		private function disposeOneCell(rowindex:int,colindex:int):void{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var cell:ICell = grid.getCellInPosition(rowindex,colindex);
			var cellIndexInView:int = rowindex*grid.colcount+colindex; 
			
			var childNum:int = this._cells.length;
			var cellEle:DisplayObject = null;
			if(childNum>=cellIndexInView+1){
				cellEle = this._cells[cellIndexInView] as DisplayObject;
			}
			var cellView:CommonCellView=null;
			if(cellEle!=null){
				cellView = CommonCellView(cellEle);
				removeCellView(cellView,cellIndexInView);
			}
		}
		
		private function drawOneCell(rowindex:int,colindex:int):void{
			var ma:MergeArea = getMergeArea(rowindex,colindex);
			if(ma!=null){
				if(!(ma.sr==rowindex&&ma.sc==colindex)){
					return;
				}
			}
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var cell:ICell = grid.getCellInPosition(rowindex,colindex);
			
			var lws:Array = cell.border.lineWeights;
			var lcs:Array = cell.border.lineColors;
			var las:Array = cell.border.lineAlphas;
			
			var cellIndexInView:int = rowindex*grid.colcount+colindex; 
			var childNum:int = this._cells.length;
			var cellEle:DisplayObject = null;
			if(childNum>=cellIndexInView+1){
				cellEle = this._cells[cellIndexInView] as DisplayObject;
			}
			var cellView:CommonCellView=null;
			if(cellEle==null){
				if(isOnRowTableHeader(rowindex)){
					cellView = new ColHeaderCellView();
				}else{
					if(isOnColTableLeftHeader(colindex)){
						cellView = new RowHeaderCellView();
					}else{
						if(cell.type!=CellConst.CELLTYPE_NONE){
							cellView = new CellView();
						}
					}
				}
				if(cellView!=null){
					cellView.colindex = colindex;
					cellView.rowindex = rowindex;
					cellView.gridname = this.gridname;
				}
			}else{
				if(isOnRowTableHeader(rowindex)){
					cellView = ColHeaderCellView(cellEle);
				}else{
					if(isOnColTableLeftHeader(colindex)){
						cellView = RowHeaderCellView(cellEle);
					}else{
						cellView = CellView(cellEle);
					}
				}
			}
			
			var drawWidth:Number=colWidth(colindex);
			var drawHeight:Number=rowHeight(rowindex);
			var needDrawBorder:Boolean = true;
			if(ma!=null){
				if(rowindex==ma.sr&&colindex==ma.sc){
					drawHeight = 0;
					for(var i:int=ma.sr;i<=ma.er;i++){
						drawHeight +=grid.getRowProp(i).height;
					}
					drawWidth = 0;
					for(var i:int=ma.sc;i<=ma.ec;i++){
						drawWidth +=grid.getColProp(i).width;
					}
				}else{
					needDrawBorder = false;
				}
			}
			if(needDrawBorder){
				//边框
				this.drawRectWithBorder(colX(colindex),
					rowY(rowindex),
					drawWidth,drawHeight,
					lws,lcs,las,cell.style.backgroundColor);
			}
			//中间数据
			if(needDrawBorder&&cellViewNeedDrawContent(rowindex,colindex)){
				cellView.x = colX(colindex)+lws[3]/2;
				cellView.y = rowY(rowindex)+lws[0]/2;
				var cellWidth:Number = drawWidth-lws[1]/2-lws[3]/2;
				var cellHeight:Number = drawHeight-lws[0]/2-lws[2]/2; 
				cellView.setSize(cellWidth,cellHeight);
				this._contentContainer.addChild(cellView);
				this._cells[cellIndexInView] = cellView;
			}else{
				removeCellView(cellView,cellIndexInView);
			}
		}
		
		private function cellViewNeedDrawContent(ri:int,ci:int):Boolean{
			var result:Boolean = true;
			if(isOnRowTableHeader(ri)){
				result = true;
			}else{
				if(isOnColTableLeftHeader(ci)){
					result = true;
				}else{
					var cell:ICell = gridModel().getCellInPosition(ri,ci);
					if(cell.type==CellConst.CELLTYPE_NONE){
						result = false;
					}else{
						result = true;
					}
				}
			}
			return result;
		}
		
		private function removeCellView(cellView:CommonCellView,index:int):void{
			if(cellView){
				cellView.clearAll();
			}
			this._cells[index] = null;
			try{
				this._contentContainer.removeElement(cellView);
			}catch(e:Error){
			}
		}
		
		private function disposeOneRow(rowIndex:int):void{
			var rowcount:int = gridModel().rowcount;
			var cells:Array = gridModel().cells;
			if(rowIndex<rowcount){
				var row:Object = cells[rowIndex];
				var cellsinrow:Array = row as Array;
				var cellsinrowcount:int = cellsinrow.length;
				for(var colIndex:int=0;colIndex<cellsinrowcount;colIndex++){
					disposeOneCell(rowIndex,colIndex);
				}
			}
		}
		private function drawOneRow(rowIndex:int):void{
			var cells:Array = gridModel().cells;
			var cellIndex:int = rowIndex;
			if(cellIndex<cells.length){
				var row:Object = cells[cellIndex];
				var cellsinrow:Array = row as Array;
				var cellsinrowcount:int = cellsinrow.length;
				for(var colIndex:int=0;colIndex<cellsinrowcount;colIndex++){
					drawOneCell(rowIndex,colIndex);
				}
			}
		}
		
		private function findElementInContentContainerByIndex(index:int):DisplayObject{
			var childNum:int = this._contentContainer.numChildren;
			var cellEle:DisplayObject=null;
			if(childNum>=index+1){
				cellEle = this._contentContainer.getChildAt(index);
			}
			return cellEle;
		}
		
		private function gridModel():IGrid{
			return this._controller.getGrid(this._gridname);
		}
		private function rowY(rowIndex:int):Number{
			return RowProp(gridModel().rowProps[rowIndex]).y;
		}
		private function colX(colIndex:int):Number{
			return ColProp(gridModel().colProps[colIndex]).x;
		}
		private function colHeaderY():Number{
			return 0;
		}
		private function rowHeaderX():Number{
			return 0;
		}
		private function rowHeight(rowIndex:int):Number{
			return RowProp(gridModel().rowProps[rowIndex]).height;
		}
		private function colWidth(colIndex:int):Number{
			return ColProp(gridModel().colProps[colIndex]).width;
		}
		public function colHeaderHeight():Number{
			return 20;
		}
		public function rowHeaderWidth():Number{
			return 36;
		}
		public function defaultRowheight():Number{
			return 20;
		}
		public function defaultColwidth():Number{
			return 60;
		}
		
		/**
		 * top right bottom left
		 */
		private function drawRectWithBorder(x:Number,y:Number,w:Number,h:Number,
											lws:Array,lineColors:Array,lineAlphas:Array,
											fillColor:uint):void{
			
			this._contentContainer.graphics.beginFill(fillColor);
			this._contentContainer.graphics.drawRect(x+lws[3]/2,y+lws[0]/2,w-lws[1]/2-lws[3]/2,h-lws[0]/2-lws[2]/2);
			this._contentContainer.graphics.endFill();
			
			this._contentContainer.graphics.moveTo(x,y);
			var xs:Array = [x+w,x+w,x,x];
			var ys:Array = [y,y+h,y+h,y];
			for(var i:int=0;i<lws.length;i++){
				this._contentContainer.graphics.lineStyle(lws[i],lineColors[i],lineAlphas[i]);
				this._contentContainer.graphics.lineTo(xs[i],ys[i]);
			}
		}
		
		public function get controller():GridController
		{
			return _controller;
		}

		public function set controller(value:GridController):void
		{
			_controller = value;
		}
		
		public function get gridname():String
		{
			return _gridname;
		}

		[Bindable]
		public function set gridname(value:String):void
		{
			_gridname = value;
		}
		public function getColIndexByStagePos(stageX:Number):int{
			var stageP:Point = new Point(stageX,0);
			var localP:Point = this.contentContainer.globalToLocal(stageP);
			return getColIndexByLocalPos(localP.x);
		}
		public function getRowIndexByStagePos(stageY:Number):int{
			var stageP:Point = new Point(0,stageY);
			var localP:Point = this.contentContainer.globalToLocal(stageP);
			return getRowIndexByLocalPos(localP.y);
		}
		public function getColIndexByLocalPos(localX:Number):int{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var count:int = grid.colcount;
			for(var i:int=0;i<count;i++){
				var colp:ColProp = grid.getColProp(i);
				if(localX>=colp.x
					&&localX<=colp.x+colp.width){
					return i; 
				}
			}
			return -1;
		}
		public function getRowIndexByLocalPos(localY:Number):int{
			var grid:IGrid = GridController.getInstance().getGrid(this.gridname);
			var count:int = grid.rowcount;
			for(var i:int=0;i<count;i++){
				var rowp:RowProp = grid.getRowProp(i);
				if(localY>=rowp.y
					&&localY<=rowp.y+rowp.height){
					return i; 
				}
			}
			return -1;
		}

		public function get scrollWidth():Number
		{
			return _scrollWidth;
		}

		public function set scrollWidth(value:Number):void
		{
			_scrollWidth = value;
		}

		public function get scrollHeight():Number
		{
			return _scrollHeight;
		}

		public function set scrollHeight(value:Number):void
		{
			_scrollHeight = value;
		}

		public function get rowHeaderContainer():Box
		{
			return _rowHeaderContainer;
		}

		public function set rowHeaderContainer(value:Box):void
		{
			_rowHeaderContainer = value;
		}

		public function get corner():Label
		{
			return _corner;
		}

		public function set corner(value:Label):void
		{
			_corner = value;
		}
		/**
		 * 获取当前展现的pages中的起始行和结束行
		 * 
		 */
		public function getCurrRowIndexs():Array{
			var pages:Array = GridController.getInstance().getPageBuilder(this.gridname).getCurrShow();
			var sr:int = 0;
			var er:int = 0;
			var pagecount:int = pages.length;
			MonsterDebugger.trace(this,"当前展现页数:"+pagecount);
			for(var i:int=0;i<pagecount;i++){
				var page:Page = pages[i] as Page;
				if(i==0){
					sr = page.startRow;
					er = page.endRow;
				}else{
					sr = Math.min(sr,page.startRow);
					er = Math.max(er,page.endRow);
				}
			}
			return [sr,er];
		}
		//function interface
		private var _spSelect:Sprite = new Sprite();
		public function drawSelectContent(startRow:int,endRow:int,startCol:int,endCol:int):void{
			var grid:IGrid = GridController.getInstance().getGrid(this._gridname);
			this.selectionArea.config([startRow,endRow,startCol,endCol]);
			
			var chDec:GridStyleDeclare = GridStyleController.getInst().getDeclare(GridStyleController.CSSDECLARE_GRIDCELL);
			var selectionColor1:uint = 0xAFD7FF;
			var selectionColor2:uint = 0xAFD7FF;
			var fisrtborderColor:uint = 0x000000;
			var fisrtborderStyle:String = "solid";
			var fisrtborderWeight:int = 3;
			if(chDec){
				var selectionColorStr:String = chDec.getStyle("selectionColor").value as String;
				if(selectionColorStr!=null){
					var scsa:Array = selectionColorStr.split(",");
					selectionColor1= parseInt(scsa[0]);
					selectionColor2= parseInt(scsa[1]);
				}
				var fisrtborderColorStr:String = chDec.getStyle("fisrtborderColor").value as String;
				if(fisrtborderColorStr!=null){fisrtborderColor = parseInt(fisrtborderColorStr);}
				var fisrtborderStyleStr:String = chDec.getStyle("fisrtborderStyle").value as String;
				if(fisrtborderStyleStr!=null){fisrtborderStyle = fisrtborderStyleStr;}
				var fisrtborderWeightStr:String = chDec.getStyle("fisrtborderWeight").value as String;
				if(fisrtborderWeightStr!=null){fisrtborderWeight = parseInt(fisrtborderWeightStr);}
			}
			
			var g:Graphics = this._spSelect.graphics; 
			g.clear();
			//content
			for(var cellr:int=startRow;cellr<=endRow;cellr++){
				var cellrp:RowProp = grid.getRowProp(cellr);
				for(var cellc:int=startCol;cellc<=endCol;cellc++){
					var cellcp:ColProp = grid.getColProp(cellc);
					var ma:MergeArea = getMergeArea(cellr,cellc);
					var drawCellWidth:Number = cellcp.width;
					var drawCellHeight:Number = cellrp.height;
					if(ma!=null){
						drawCellWidth = 0;
						drawCellHeight = 0;
						if(ma.sr==cellr&&ma.sc==cellc){
							for(var i:int=ma.sc;i<=ma.ec;i++){
								drawCellWidth += grid.getColProp(i).width;
							}
							for(var i:int=ma.sr;i<=ma.er;i++){
								drawCellHeight += grid.getRowProp(i).height;
							}
						}
					}
					if(cellr==startRow&&cellc==startCol){
						g.lineStyle(fisrtborderWeight,fisrtborderColor);
						g.moveTo(this.corner.width+cellcp.x,this.corner.height+cellrp.y);
						g.lineTo(this.corner.width+cellcp.x+drawCellWidth,this.corner.height+cellrp.y);
						g.lineTo(this.corner.width+cellcp.x+drawCellWidth,this.corner.height+cellrp.y+drawCellHeight);
						g.lineTo(this.corner.width+cellcp.x,this.corner.height+cellrp.y+drawCellHeight);
						g.lineTo(this.corner.width+cellcp.x,this.corner.height+cellrp.y);
						g.lineStyle(0);
					}else{
						if(selectionColor1==selectionColor2){
							g.beginFill(selectionColor1,0.8);
						}else{
							var matrix:Matrix = new Matrix();
							matrix.createGradientBox(drawCellWidth,drawCellHeight,0,this.corner.width+cellcp.x,this.corner.height+cellrp.y);
							g.beginGradientFill(GradientType.LINEAR,[selectionColor1,selectionColor2],
								[0.8,0.8],[0,255],matrix);
						}
						g.drawRect(this.corner.width+cellcp.x,this.corner.height+cellrp.y,
							drawCellWidth,drawCellHeight);
						g.endFill();
					}
				}
			}
			this._spSelect.visible = true;
			this.addChild(_spSelect);
			
			//header
			if(gridModel().type==GridConst.GRIDTYPE_NORMAL){
				var rowIndexs:Array = this.getCurrRowIndexs();
				
				for(var ri:int=rowIndexs[0];ri<=rowIndexs[1];ri++){
					var rowHeaderCell:RowHeaderCellView = RowHeaderCellView(this.rowHeaderContainer.getChildAt(ri));
					if(ri>=startRow&&ri<=endRow){
						rowHeaderCell.drawSelect();
					}else{
						rowHeaderCell.drawNormal();
					}
				}
				this.addChild(rowHeaderContainer);
				for(var ci:int=0;ci<grid.colcount;ci++){
					var colHeaderCell:ColHeaderCellView = ColHeaderCellView(this.colHeaderContainer.getChildAt(ci));
					if(ci>=startCol&&ci<=endCol){
						colHeaderCell.drawSelect();	
					}else{
						colHeaderCell.drawNormal();
					}
				}
				this.addChild(colHeaderContainer);
				this.addChild(corner);
			}
		}
		public function hideSelectContent():void{
			this._spSelect.visible = false;
			this.selectionArea.clear();
			if(gridModel().type==GridConst.GRIDTYPE_NORMAL){
				var grid:IGrid = GridController.getInstance().getGrid(this._gridname);
				var rowIndexs:Array = this.getCurrRowIndexs();
				for(var ri:int=rowIndexs[0];ri<=rowIndexs[1];ri++){
					var rowHeaderCell:RowHeaderCellView = RowHeaderCellView(this.rowHeaderContainer.getChildAt(ri));
					rowHeaderCell.drawNormal();
				}
				for(var ci:int=0;ci<grid.colcount;ci++){
					var colHeaderCell:ColHeaderCellView = ColHeaderCellView(this.colHeaderContainer.getChildAt(ci));
					colHeaderCell.drawNormal();
				}
			}
		}
		
		public function headerMove(dire:String,value:int):void{
			if(dire==ScrollBar.HORIZONTAL){
				if(gridModel().type==GridConst.GRIDTYPE_NORMAL){
					this.rowHeaderContainer.x = value;
					this.addChild(this.rowHeaderContainer);
					
					this.corner.x = value;
					this.addChild(this.corner);
				}else if(gridModel().type==GridConst.GRIDTYPE_DISPLAY){
					var grid:IGrid = gridModel();
					var colcount:int = grid.colcount;
					for(var i:int=0;i<colcount;i++){
						var cp:ColProp = grid.getColProp(i);
						if(cp.type==ColProp.COLTYPE_LEFTHEADER){
							var ris:Array = getCurrRowIndexs();
							for(var j:int=ris[0];j<=ris[1];j++){
								var currRowHeader:CommonCellView = getCellView(j,i,colcount);
								if(currRowHeader){
									if(i==0){
										currRowHeader.x = value;
									}else{
										var preRowch:CommonCellView = getCellViewInMerge(j,i-1,colcount);
										if(preRowch){
											currRowHeader.x = preRowch.x+preRowch.width;
										}
									}
									this.contentContainer.addChild(currRowHeader);
								}
							}
						}else{
							break;						
						}
					}
				}
			}else if(dire==ScrollBar.VERTICAL){
				if(gridModel().type==GridConst.GRIDTYPE_NORMAL){
					this.colHeaderContainer.y = value;
					this.addChild(this.colHeaderContainer);
					
					this.corner.y = value;
					this.addChild(this.corner);
				}else if(gridModel().type==GridConst.GRIDTYPE_DISPLAY){
					var grid:IGrid = gridModel();
					var rowcount:int = grid.rowcount;
					for(var i:int=0;i<rowcount;i++){
						var rp:RowProp = grid.getRowProp(i);
						if(rp.type==RowProp.ROWTYPE_TABLEHEADER){
							var colcount:int = grid.colcount;
							for(var j:int=0;j<colcount;j++){
								var currColHeader:CommonCellView = getCellView(i,j,colcount);
								if(currColHeader){
									if(i==0){
										currColHeader.y = value;
									}else{
										var preRowch:CommonCellView = getCellViewInMerge(i-1,j,colcount);
										if(preRowch){
											currColHeader.y = preRowch.y+preRowch.height;
										}
									}
									this.contentContainer.addChild(currColHeader);
								}
							}
						}else{
							break;						
						}
					}
				}
			}
		}

		/**
		 * 得到在内存中存放的展现单元格对象，如果在合并区域中，并且不是合并区域首格，则返回合并区域首格
		 */
		public function getCellViewInMerge(ri:int,ci:int,colcount:int):CommonCellView{
			var ma:MergeArea = getMergeArea(ri,ci);
			var result:CommonCellView = null;
			var arrIndex:int = 0;
			if(ma==null||(ri==ma.sr&&ci==ma.sc)){
				arrIndex = ri*colcount+ci;
			}else{
				arrIndex = ma.sr*colcount+ma.sc;
			}
			return this._cells[arrIndex];
		}
		/**
		 * 得到在内存中存放的展现单元格对象，如果在合并区域中，并且不是合并区域首格，则返回null
		 */
		public function getCellView(ri:int,ci:int,colcount:int):CommonCellView{
			var ma:MergeArea = getMergeArea(ri,ci);
			var result:CommonCellView = null;
			var arrIndex:int = 0;
			if(ma==null||(ri==ma.sr&&ci==ma.sc)){
				arrIndex = ri*colcount+ci;
			}else{
				return null;
			}
			return this._cells[arrIndex];
		}
		private function constructCornerStyle():void{
			var cornerDec:GridStyleDeclare = GridStyleController.getInst().getDeclare(GridStyleController.CSSDECLARE_GRIDCORNER);
			if(!cornerDec){return;}
			var cornerBC:String = cornerDec.getStyle("backgroundColor").value as String;
			var bcarr:Array = cornerBC.split(",");
			drawCornerStyle(parseInt(bcarr[0]),parseInt(bcarr[1]));
			var self:GridView = this;
			this.corner.addEventListener(MouseEvent.ROLL_OVER,function(e:MouseEvent):void{
				self.corner.graphics.clear();
				self.drawCornerStyle(parseInt(bcarr[2]),parseInt(bcarr[3]));		
			});
			this.corner.addEventListener(MouseEvent.ROLL_OUT,function(e:MouseEvent):void{
				self.corner.graphics.clear();
				self.drawCornerStyle(parseInt(bcarr[0]),parseInt(bcarr[1]));		
			});
		}
		private function removeCornerStyle():void{
			this.corner.graphics.clear();
		}
		private function drawCornerStyle(color1:uint,color2:uint):void{
			this.corner.graphics.beginFill(color1);
			this.corner.graphics.drawRect(0,0,this.corner.width,this.corner.height);
			this.corner.graphics.endFill();
			
			this.corner.graphics.beginFill(color2);
			this.corner.graphics.moveTo(this.corner.width-5,this.corner.height-15);
			this.corner.graphics.lineTo(this.corner.width-5,this.corner.height-5);
			this.corner.graphics.lineTo(this.corner.width-15,this.corner.height-5);
			this.corner.graphics.lineTo(this.corner.width-5,this.corner.height-15);
			this.corner.graphics.endFill();
		}	
		public function constructStyle():void{
			var cornerDec:GridStyleDeclare = GridStyleController.getInst().getDeclare(GridStyleController.CSSDECLARE_GRIDCORNER);
			if(!cornerDec){return;}
			constructCornerStyle();
			constructColHeaderStyle();
			constructRowHeaderStyle();
			constructSelectionCellStyle();
		}
		
		private function constructSelectionCellStyle():void
		{
			if(this.selectionArea.sr!=-1){
				this.drawSelectContent(this.selectionArea.sr,this.selectionArea.er,this.selectionArea.sc,this.selectionArea.ec);
			}
		}
		private function constructRowHeaderStyle():void
		{
			var colcount:int = gridModel().colcount;
			var rowcount:int = gridModel().rowcount;
			if(this.rowHeaderContainer.numChildren>0){
				var rsa:Array = this.getCurrRowIndexs();
				for(var i:int=rsa[0];i<=rsa[1];i++){
					(this.rowHeaderContainer.getChildAt(i) as RowHeaderCellView).drawNormal();
				}
			}else{
				for(var i:int=0;i<rowcount;i++){
					for(var j:int=0;j<colcount;j++){
						var cp:ColProp = gridModel().getColProp(j);
						if(cp.type == ColProp.COLTYPE_NORMAL){
							break;
						}
						for(var j:int=0;j<colcount;j++){
							var rowheaderView:RowHeaderCellView = getCellView(i,j,colcount) as RowHeaderCellView;
							if(rowheaderView){
								rowheaderView.drawNormal();
							}
						}
					}
				}
			}
		}
		private function constructColHeaderStyle():void
		{
			var colcount:int = gridModel().colcount;
			var rowcount:int = gridModel().rowcount;
			if(this.colHeaderContainer.numChildren>0){
				for(var i:int=0;i<colcount;i++){
					(this.colHeaderContainer.getChildAt(i) as ColHeaderCellView).drawNormal();
				}
			}else{
				for(var i:int=0;i<rowcount;i++){
					var rp:RowProp = gridModel().getRowProp(i);
					if(rp.type == RowProp.ROWTYPE_NORMAL){
						break;
					}
					for(var j:int=0;j<colcount;j++){
						var colheaderView:ColHeaderCellView = getCellView(i,j,colcount) as ColHeaderCellView;
						if(colheaderView){
							colheaderView.drawNormal();
						}
					}
				}
			}
		}
		public function removeStyle():void{
			removeCornerStyle();
		}

		public function get selectionArea():MergeArea
		{
			return _selectionArea;
		}

		public function set selectionArea(value:MergeArea):void
		{
			_selectionArea = value;
		}

		
	}
}