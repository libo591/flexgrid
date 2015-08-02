package
{
	import com.grid.components.logic.GridViewWithScroll;
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridConst;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.model.GridEventDispatcher;
	import com.grid.model.MergeArea;
	import com.grid.model.NormalGrid;
	import com.grid.model.cell.NormalBorder;
	import com.grid.model.cell.NormalCell;
	import com.grid.model.cell.NormalCellProp;
	import com.grid.model.cell.NormalStyle;
	import com.grid.model.header.ColHeaderCell;
	import com.grid.model.header.ColProp;
	import com.grid.model.header.GroupRowConst;
	import com.grid.model.header.NormalHeaderFuncProp;
	import com.grid.model.header.RowHeaderCell;
	import com.grid.model.header.RowInGroup;
	import com.grid.model.header.RowProp;
	import com.grid.styles.GridStyleController;
	import com.grid.utils.PopupUtil;
	
	import game.ui.MainUI;
	
	import morn.core.handlers.Handler;
	
	public class Main extends MainUI
	{
		
		//[Bindable]
		//[Embed(source="a.jpg")]
		//private var _img:Class;
		
		public var grid:IGrid = new NormalGrid();
		public var gs:GridViewWithScroll = new GridViewWithScroll();
		public function Main()
		{
			super();
			btn2.clickHandler = new Handler(button2_clickHandler);
			btn3.clickHandler = new Handler(button3_clickHandler);
			btn4.clickHandler = new Handler(button4_clickHandler);
			styles.labels = "default.json,cobalt.json,desert.json,graphite.json,sage.json";
			styles.selectHandler = new Handler(styleSelect);
			appInit();
		}
		
		private function styleSelect(selectIndex:int):void
		{
			GridStyleController.getInst().loadAndShowStyles("themes/"+styles.selectedLabel);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			gs.width = box.width;
			gs.height = box.height;
			gs.gridView.scrollWidth = this.width;
			gs.gridView.scrollHeight = this.height;
			box.addChild(gs);
		}
		
		protected function button4_clickHandler():void
		{
			PopupUtil.popupFunctionTip(funcName.text);
		}
		
		protected function button3_clickHandler():void
		{
			PopupUtil.popupDataSetCreator(this.width-100,this.height-50);
		}
		
		protected function button2_clickHandler():void
		{
			//ICell(grid.cells[0][0]).extendProp.text = "改变得值";
			for(var i:int=0;i<grid.colcount;i++){
				ICell(grid.cells[0][i]).style.backgroundColor = 0x0000ff;
			}
			GridController.getInstance().regist(gs.gridView.gridname,grid,gs.gridView);
			GridController.getInstance().showGrid(gs.gridView.gridname);
		}
		
		protected function appInit():void
		{
			var colcount:int = 6;
			var rowcount:int = 5;
			var headerCells:Array = [];
			var rowheaderCells:Array = [];
			var colprop:Array = [];
			var rowprop:Array = [];
			for(var h:int=0;h<colcount;h++){
				var cp:ColProp = new ColProp();
				cp.visiable = true;
				cp.width = 120;
				cp.colindex = h;
				/*if(h==0){
					cp.type = ColProp.COLTYPE_LEFTHEADER;
				}*/
				if(h==0){
					cp.isTreeNode = true;
				}
				cp.headerFunc = new NormalHeaderFuncProp();
				cp.headerFunc.isFilter(true);
				cp.headerFunc.isSort(true);
				cp.colDataType = ColProp.COLDATATYPE_STRING;
				colprop.push(cp);
			}
			
			for(var r:int=0;r<rowcount;r++){
				var rp:RowProp = new RowProp();
				rp.visiable = true;
				rp.height = 25;
				rp.rowindex = r;
				if(r==0||r==1){
					rp.type = RowProp.ROWTYPE_TABLEHEADER;
				}
				if(r==2||r==3||r==4){
					if(r==2){
						rp.treeLevel = 1;
					}else if(r==3){
						rp.treeLevel = 2;
					}else{
						rp.treeLevel = 3;
					}
				}
				rowprop.push(rp);
			}
			
			var cells:Array = [];
			for(var i:int=0;i<rowcount;i++){
				var cellsInRow:Array = [];
				for(var j:int=0;j<colcount;j++){
					var cell:ICell = new NormalCell();
					cell.style = new NormalStyle();
					cell.border = new NormalBorder();
					cell.border.lineColors = [0xD3D3D3,0xD3D3D3,0xD3D3D3,0xD3D3D3];
					cell.border.lineWeights = [1,1,1,1];
					cell.extendProp = new NormalCellProp();
					cell.extendProp.text = "测试_"+i+"_"+j;//
					cell.extendProp.value = "测试_"+i+"_"+j;
					cell.type = CellConst.CELLTYPE_TEXT;
					/*if(i%2==0){
						//cell.style.backgroundColor = 0xffff00;
						//cell.extendProp.dataVisiable = false;
						cell.style.forecolor = 0xFF0000;
						cell.style.indentation = 0;
						cell.style.horizontalAligh = CellConst.HORIZONTALALIGH_LEFT;
						cell.style.verticalAlign = CellConst.VERTICALALIGN_MIDDLE;
						cell.style.fontsize = 12;
						cell.style.italic = true;
						cell.style.bold = true;
						cell.extendProp.href = "http://www.baidu.com";
						cell.type = CellConst.CELLTYPE_TEXT;
					}else{
						//cell.style.backgroundColor = 0x00ffff;
						cell.style.horizontalAligh = CellConst.HORIZONTALALIGH_CENTER;
						cell.style.verticalAlign = CellConst.VERTICALALIGN_BOTTOM;
						cell.style.bold = true;
						cell.style.underline = true;
					}*/
					
					/*if(i*colcount+j>100){
						cell.type = CellConst.CELLTYPE_NONE;
					}
					if(j==1){
						cell.type = CellConst.CELLTYPE_TEXT;
						cell.extendProp.value = "col_"+i;
						cell.extendProp.text = "col_"+i;
					}
					if(i==1&&j==0){
						cell.type = CellConst.CELLTYPE_IMAGE;
						cell.extendProp.imageData = "a.jpg";
					}
					if(i==1&&j==1){
						
						cell.type = CellConst.CELLTYPE_BUTTON;
					}
					if(i==1&&j==1){
						cell.extendProp.text = "3";
						cell.extendProp.value = 3;
						cell.type = CellConst.CELLTYPE_CALCULATOR;
					}
					if(i==4&&j==0){
						cell.type = CellConst.CELLTYPE_NUMERIC;
					}
					if(i==1&&j==1){
						cell.extendProp.value = "2013-12-1";
						cell.type = CellConst.CELLTYPE_DATETIME;
					}
					if(i==1&&j==1){
						cell.extendProp.text = "1,2";
						cell.extendProp.value = "1,2";
						cell.type = CellConst.CELLTYPE_CHECKBOX;
						var arr:Object = {deriction:"v",data:[{label:"足球",selected:true,tag:1},
							{label:"篮球",selected:true,tag:2}]};//deriction:"v"
						cell.extendProp.typeData = JSON.stringify(arr);
					}
					if(i==1&&j==1){
						cell.type = CellConst.CELLTYPE_COMBOBOX;
						cell.extendProp.value = "2";
						var arr:Array = [{label:"上",value:"1"},{label:"上右",value:"2"}];
						cell.extendProp.typeData = JSON.stringify(arr);
					}
					if(i==1&&j==1){
						cell.type = CellConst.CELLTYPE_LINK;
						var obj:Object = {href:"http://www.baidu.com/"};
						cell.extendProp.typeData = JSON.stringify(obj);
					}
					if(i==1&&j==1){
						cell.extendProp.value = "2";
						cell.type = CellConst.CELLTYPE_RADIO;
						var arr:Object = {direction:"v",data:[{label:"男",value:"1"},
							{label:"女",value:"2"}]};
						cell.extendProp.typeData = JSON.stringify(arr);
					}
					if(i==1&&j==1){
						cell.extendProp.text = "0xff00ff";
						cell.extendProp.value = 0xff00ff;
						cell.type = CellConst.CELLTYPE_COLORPICKER;
					}
					if(i==1&&j==1){
						cell.type = CellConst.CELLTYPE_RICHTEXT;
						cell.extendProp.value = "<a href='javascript:void(0);'>1111</a>";
						cell.extendProp.text = "<a href='javascript:void(0);'>1111</a>";
					}
					if(i==0&&j==0){
						cell.extendProp.value = "=SUM(1,2,3)";
					}
					if(i==8){
						cell.extendProp.value = j+"";
						cell.extendProp.text = j+"";
					}
					if(i==9&&j==1){
						cell.extendProp.value = "=SUM($A9,$B9,$C9)";
					}
					if(i==11){
						cell.type = CellConst.CELLTYPE_TEXT;
					}
					if(j==3){
						cell.extendProp.text = i+"";
						cell.extendProp.value = i+"";
						cell.type = CellConst.CELLTYPE_TEXT;
						
					}
					if(i==1&&j==1){
						cell.extendProp.text = "5";
						cell.extendProp.value = 5;
						cell.extendProp.typeData = JSON.stringify({value:5,tick:1,min:0,max:10});
						cell.type = CellConst.CELLTYPE_SLIDER;
					}
					if(i==1&&j==1){
						cell.type = CellConst.CELLTYPE_PROCESSER;
					}
					if(i==1&&j==0){
						cell.extendProp.text = "30";
						cell.extendProp.value = 30;
						cell.extendProp.typeData = JSON.stringify(
							{min:1,max:100,value:30,step:1});
						cell.type = CellConst.CELLTYPE_NUMERIC;
					}
					if(i==1&&j==0){
						cell.type = CellConst.CELLTYPE_COLORPICKER;
					}*/
					cellsInRow.push(cell);
				}
				cells.push(cellsInRow);
			}
			grid.cells = cells;
			grid.colProps = colprop;
			grid.rowProps = rowprop;
			
			var mas:Array = [];
			var ma1:MergeArea = new MergeArea();
			ma1.sr = 0;ma1.er = 0;ma1.sc=0;ma1.ec=2;
			mas.push(ma1);
			
			var ma2:MergeArea = new MergeArea();
			ma2.sr = 0;ma2.er = 1;ma2.sc=3;ma2.ec=3;
			mas.push(ma2);
			var ma3:MergeArea = new MergeArea();
			ma3.sr = 0;ma3.er = 1;ma3.sc=4;ma3.ec=4;
			mas.push(ma3);
			var ma4:MergeArea = new MergeArea();
			ma4.sr = 0;ma4.er = 1;ma4.sc=5;ma4.ec=5;
			mas.push(ma4);
			
			grid.mergeAreas = mas;
			//grid.type = GridConst.GRIDTYPE_NORMAL;
			//grid.type = GridConst.GRIDTYPE_DISPLAY;
			grid.type = GridConst.GRIDTYPE_DISPLAY_TREEGRID;
			GridController.getInstance().regist(gs.gridView.gridname,grid,gs.gridView);
			GridController.getInstance().showGrid(gs.gridView.gridname);
			
			GridStyleController.getInst().loadAndShowStyles("themes/default.json");
		}
	}
}