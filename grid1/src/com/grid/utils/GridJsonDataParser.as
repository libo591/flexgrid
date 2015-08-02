package com.grid.utils
{
	import com.adobe.utils.StringUtil;
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICell;
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridConst;
	import com.grid.model.GridController;
	import com.grid.model.MergeArea;
	import com.grid.model.NormalGrid;
	import com.grid.model.cell.NormalCell;
	import com.grid.model.cell.NormalCellProp;
	import com.grid.model.header.ColProp;
	import com.grid.model.header.NormalHeaderFuncProp;
	import com.grid.model.header.RowProp;

	public class GridJsonDataParser
	{
		public function GridJsonDataParser()
		{
		}
		
		public static function parse2Grid(json:String,gridname:String):IGrid{
			var igrid:IGrid = GridController.getInstance().getGrid(gridname);
			if(igrid==null){
				igrid = new NormalGrid();
			}
			var gridjson:Object = JSON.parse(json);
			var data:Array = gridjson["data"] as Array;
			if(!isNull(data)){
				parseData(igrid,data);
			}
			var meta:Object = gridjson["meta"];
			if(!isNull(meta)){
				parseGridMeta(igrid,meta);
				parseRowMeta(igrid,meta);
				parseColMeta(igrid,meta);
				parseCellMeta(igrid,meta);
				parseMergeMeta(igrid,meta);
				parseStyleMeta(igrid,meta);
			}
			return igrid;
		}
		/**
		 * 解析表格元数据
		 */
		private static function parseGridMeta(igrid:IGrid, meta:Object):void
		{
			igrid.type = GridConst.GRIDTYPE_DISPLAY;
			var gridmeta:Object = meta.gridmeta;
			if(!isNull(gridmeta)){
				igrid.type = gridmeta.type=="normal"?GridConst.GRIDTYPE_NORMAL:GridConst.GRIDTYPE_DISPLAY;
				if(igrid.type ==GridConst.GRIDTYPE_DISPLAY){
					igrid.dispType = gridmeta.disptype=="tree"?GridConst.GRIDTYPE_DISPLAY_TREEGRID:GridConst.GRIDTYPE_DISPLAY;
				}
			}
		}
		/**
		 * 解析样式
		 */
		private static function parseStyleMeta(igrid:IGrid, meta:Object):void
		{
			var style:Object = meta.style;
			if(!isNull(style)){
				igrid.style = style;
			}else{
				igrid.style = "themes/default.json";
			}
		}
		/**
		 * 解析合并属性
		 */
		private static function parseMergeMeta(igrid:IGrid, meta:Object):void
		{
			var mm:Object = meta.mergemeta;
			if(!isNull(mm)){
				igrid.mergeAreas = [];
				var mergeInfoArray:Array = (mm as String).split(";");
				var mc:int = mergeInfoArray.length;
				for(var i:int=0;i<mc;i++){
					var mergeInfo:String = mergeInfoArray[i];
					var marr:Array = mergeInfo.split(",");
					var ma:MergeArea = new MergeArea(marr[0],marr[2],marr[1],marr[3]);
					igrid.mergeAreas.push(ma);
				}
			}
		}
		/**
		 * 解析单元格属性
		 */
		private static function parseCellMeta(igrid:IGrid, meta:Object):void
		{
			var cellmeta:Object = meta.cellmeta;
			var rowcount:int = igrid.rowcount;
			var colcount:int = igrid.colcount;
			if(cellmeta){
				for(var key:String in cellmeta){
					if("all"==key){
						var arr:Array = [];
						for(var i:int=0;i<rowcount;i++){
							for(var j:int=0;j<colcount;j++){
								arr.push(i*colcount+j);
							}
						}
						setCellPropByObject(arr,cellmeta[key],igrid);
					}else if(StringUtil.beginsWith(key,"row_")){
						var arr:Array = [];
						var indexInfo:String = key.split("_")[1];
						if(indexInfo.indexOf("-")!=-1){
							var infoarr:Array = indexInfo.split("-");
							var begin:int = parseInt(infoarr[0]);
							var end:int = parseInt(infoarr[1]);
							for(var r:int=0;r<rowcount;r++){
								if(r>=begin&&r<=end){arr.push(r);}
							}
						}else{
							arr = indexInfo.split(",");
						}
						var arr2:Array=[];
						for(var i:int=0;i<arr.length;i++){
							for(var j:int=0;j<colcount;j++){
								arr2.push(arr[i]*colcount+j);
							}
						}
						setCellPropByObject(arr2,cellmeta[key],igrid);
					}else if(StringUtil.beginsWith(key,"col_")){
						var arr:Array = [];
						var indexInfo:String = key.split("_")[1];
						if(indexInfo.indexOf("-")!=-1){
							var infoarr:Array = indexInfo.split("-");
							var begin:int = parseInt(infoarr[0]);
							var end:int = parseInt(infoarr[1]);
							for(var r:int=0;r<colcount;r++){
								if(r>=begin&&r<=end){arr.push(r);}
							}
						}else{
							arr = indexInfo.split(",");
						}
						var arr2:Array=[];
						for(var i:int=0;i<arr.length;i++){
							for(var j:int=0;j<rowcount;j++){
								arr2.push(j*colcount+arr[i]);
							}
						}
						setCellPropByObject(arr2,cellmeta[key],igrid);
					}else if(StringUtil.beginsWith(key,"cell_")){
						var arr:Array = [];
						var keyArr:Array = key.split("_");
						arr.push(parseInt(keyArr[1])*colcount+parseInt(keyArr[2]));
						setCellPropByObject(arr,cellmeta[key],igrid);
					}
				}
			}
		}
		private static function setCellPropByObject(index:Array,obj:Object,igrid:IGrid):void{
			var count:int = index.length;
			var colcount:int = igrid.colcount;
			for(var i:int=0;i<count;i++){
				var row:int = index[i]/colcount;
				var col:int = index[i]%colcount;
				var cell:ICell = igrid.getCellInPosition(row,col);
				MonsterDebugger.trace(null,[row,col,obj.type].join("=="));
				cell.type = !isNull(obj.type)?parseCellType(obj.type):CellConst.CELLTYPE_NONE;
				cell.extendProp.dataVisiable = obj.datavisiable==false?false:true;
				cell.style.backgroundColor = !isNull(obj.backgroundColor)?obj.backgroundColor:(obj.backgroundColor==0x000000?0x000000:0xffffff);
				cell.style.bold = obj.bold==true?true:false;
				cell.style.fontsize = !isNull(obj.fontsize)?obj.fontsize:12;
				cell.style.forecolor = !isNull(obj.forecolor)?obj.forecolor:0x000000;
				cell.style.horizontalAligh= !isNull(obj.align)?obj.align:(obj.align==0?CellConst.HORIZONTALALIGH_LEFT:CellConst.HORIZONTALALIGH_CENTER);
				cell.style.indentation = !isNull(obj.indentation)?obj.indentation:0;
				cell.style.italic = obj.italic==true?true:false;
				cell.style.underline = obj.underline==true?true:false;
				cell.style.verticalAlign = !isNull(obj.valign)?obj.valign:CellConst.VERTICALALIGN_MIDDLE;
				cell.extendProp.value = !isNull(obj.value)?obj.value:null;
				if(!isNull(obj.border)){
					var a:Array = obj.border.split(" ");
					var aw:String = a[0];
					var ac:String = a[1];
					var awarr:Array = aw.split(",");
					if(awarr.length==1){
						var bw:Number = parseFloat(awarr[0]);
						cell.border.lineWeights = [bw,bw,bw,bw];
					}else{
						cell.border.lineWeights = [parseFloat(awarr[0]),parseFloat(awarr[1]),parseFloat(awarr[2]),parseFloat(awarr[3])];
					}
					var acarr:Array = ac.split(",");
					if(acarr.length==1){
						var bc:int = parseFloat(acarr[0]);
						cell.border.lineColors = [bc,bc,bc,bc];
					}else{
						cell.border.lineColors = [parseFloat(acarr[0]),parseFloat(acarr[1]),
							parseFloat(acarr[2]),parseFloat(acarr[3])];
					}
					cell.border.lineAlphas = [1,1,1,1];
				}
				cell.extendProp.imageData = !isNull(obj.imageData)?obj.imageData:null;
				cell.extendProp.typeData = !isNull(obj.typeData)?obj.typeData:null;
			}
		}
		private static function parseCellType(type:String):int{
			switch(type){
				case "none":
					return CellConst.CELLTYPE_NONE;
					case "text":
						return CellConst.CELLTYPE_TEXT;
					case "image":
						return CellConst.CELLTYPE_IMAGE;
					case "button":
						return CellConst.CELLTYPE_BUTTON;
					case "calculator":
						return CellConst.CELLTYPE_CALCULATOR;
					case "checkbox":
						return CellConst.CELLTYPE_CHECKBOX;
					case "color":
						return CellConst.CELLTYPE_COLORPICKER;
					case "combobox":
						return CellConst.CELLTYPE_COMBOBOX;
					case "date":
						return CellConst.CELLTYPE_DATE;
					case "link":
						return CellConst.CELLTYPE_LINK;
					case "numeric":
						return CellConst.CELLTYPE_NUMERIC;
					case "progress":
						return CellConst.CELLTYPE_PROCESSER;
					case "radio":
						return CellConst.CELLTYPE_RADIO;
					case "richtext":
						return CellConst.CELLTYPE_RICHTEXT;
					case "slider":
						return CellConst.CELLTYPE_SLIDER;
				default:
					return CellConst.CELLTYPE_TEXT; 
			}
		}
		/**
		 * 解析列属性
		 */
		private static function parseColMeta(igrid:IGrid, meta:Object):void
		{
			var colcount:int = igrid.cells[0].length;
			var colprop:Array = [];
			for(var h:int=0;h<colcount;h++){
				var cp:ColProp = new ColProp();
				cp.colindex = h;
				cp.visiable = true;
				cp.width = 100;
				cp.type = ColProp.COLTYPE_NORMAL;
				cp.isTreeNode = false;
				cp.colDataType = ColProp.COLDATATYPE_STRING;
				colprop.push(cp);
			}
			igrid.colProps = colprop;
			var colmeta:Object = meta.colmeta;
			if(colmeta){
				for(var key:String in colmeta){
					var index:Array = getIndexArray(key,colprop);
					setColPropByObject(index,colmeta[key],igrid);
				}
			}
		}
		private static function setColPropByObject(index:Array,obj:Object,igrid:IGrid):void{
			var count:int = index.length;
			for(var r:int=0;r<count;r++){
				var colindex:int = parseInt(index[r]);
				var cp:ColProp = igrid.getColProp(colindex);
				cp.visiable = obj.visiable==false?false:true;
				cp.width = isNull(obj.width)?100:obj.width;
				cp.type = obj.type=="th"?ColProp.COLTYPE_LEFTHEADER:ColProp.COLTYPE_NORMAL;
				cp.isTreeNode = obj.isTreeNode==true?true:false;
				if(obj.sort==true){
					cp.headerFunc = new NormalHeaderFuncProp();
					cp.headerFunc.isSort(true);
				}
				if(obj.filter==true){
					if(cp.headerFunc==null){cp.headerFunc = new NormalHeaderFuncProp();}
					cp.headerFunc.isFilter(true);
				}
				if(obj.colDataType=="date"){
					cp.colDataType = ColProp.COLDATATYPE_DATETIME;
				}else if(obj.colDataType=="number"){
					cp.colDataType = ColProp.COLDATATYPE_NUMBER;
				}else{
					cp.colDataType = ColProp.COLDATATYPE_STRING;
				}
			}
		}
		private static function setRowPropByObject(index:Array,obj:Object,igrid:IGrid):void{
			var count:int = index.length;
			for(var r:int=0;r<count;r++){
				var rindex:int = parseInt(index[r]);
				var rp:RowProp = igrid.getRowProp(rindex);
				rp.visiable = obj.visiable==false?false:true;
				rp.height = isNull(obj.height)?25:obj.height;
				rp.type = obj.type=="th"?RowProp.ROWTYPE_TABLEHEADER:RowProp.ROWTYPE_NORMAL;
				rp.treeLevel = obj.treeLevel?obj.treeLevel:1;
			}
		}
		/**
		 * 解析行属性
		 */
		private static function parseRowMeta(igrid:IGrid, meta:Object):void
		{
			var rowcount:int = igrid.cells.length;
			var rowprop:Array = [];
			for(var r:int=0;r<rowcount;r++){
				var rp:RowProp = new RowProp();
				rp.rowindex = r;
				rp.visiable = true;
				rp.height = 25;
				rp.type = RowProp.ROWTYPE_NORMAL;
				rp.treeLevel = 0;
				rowprop.push(rp);
			}
			igrid.rowProps = rowprop;
			var rowmeta:Object = meta.rowmeta;
			if(rowmeta){
				for(var key:String in rowmeta){
					var index:Array = getIndexArray(key,rowprop);
					setRowPropByObject(index,rowmeta[key],igrid);
				}
			}
		}
		private static function getIndexArray(key:String,array:Array):Array{
			var len:int = array.length;
			var indexarr:Array = [];
			if("all"==key){
				for(var r:int=0;r<len;r++){
					indexarr.push(r);
				}
			}else if(StringUtil.beginsWith(key,"row_")
				||StringUtil.beginsWith(key,"col_")){
				var indexInfo:String = key.split("_")[1];
				if(indexInfo.indexOf("-")!=-1){
					var arr:Array = indexInfo.split("-");
					var begin:int = parseInt(arr[0]);
					var end:int = parseInt(arr[1]);
					for(var r:int=0;r<len;r++){
						if(r>=begin&&r<=end){indexarr.push(r);}
					}
				}else{
					indexarr = indexInfo.split(",");
				}
			}
			return indexarr;
		}
		/**
		 * 解析数据
		 */
		private static function parseData(igrid:IGrid,data:Array):void{
			var cells:Array = [];
			var rowcount:int = data.length;
			for(var i:int=0;i<rowcount;i++){
				var rowitem:Array = data[i] as Array;
				var cellsInRow:Array = [];
				var colcount:int = rowitem.length;
				for(var j:int=0;j<colcount;j++){
					var cellitem:Object = rowitem[j];
					var cell:ICell = new NormalCell();
					if(cellitem==null){
						cell.type = CellConst.CELLTYPE_NONE;
					}else{
						cell.extendProp = new NormalCellProp();
						cell.extendProp.text = ""+cellitem;//
						cell.type = CellConst.CELLTYPE_TEXT;
					}
					cellsInRow.push(cell);
				}
				cells.push(cellsInRow);
			}
			igrid.cells = cells;
		}
		
		private static function isNull(obj:Object):Boolean{
			if(obj==undefined||obj==null
				||obj==""||obj=="null"
				||((obj is Number)&&isNaN(Number(obj)))){
				return true;
			}
			return false;
		}
	}
}