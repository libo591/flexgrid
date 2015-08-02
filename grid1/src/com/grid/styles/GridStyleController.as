package com.grid.styles
{
	import com.grid.errors.GridErrorController;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class GridStyleController
	{
		private var _declares:Object={};
		private static var _inst:GridStyleController = new GridStyleController();
		/** CSS declare */
		public static const CSSDECLARE_GLOBAL:String="global";
		public static const CSSDECLARE_APPLICATION:String="Application";
		public static const CSSDECLARE_GRIDCORNER:String="grid_corner";
		public static const CSSDECLARE_GRIDCOLHEADER:String="grid_colheader";
		public static const CSSDECLARE_GRIDROWHEADER:String="grid_rowheader";
		public static const CSSDECLARE_GRIDCELL:String="grid_selectcell";
		
		public function GridStyleController()
		{
		}
		
		public static function getInst():GridStyleController{
			return _inst;
		}
		public function loadAndShowStyles(url:String):void{
			this._declares = {};
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onResult);
			loader.addEventListener(FaultEvent.FAULT,onFault);
			loader.load(new URLRequest(url));
		}
		
		protected function onFault(event:ResultEvent):void
		{
			GridErrorController.getInst().throwRuntimeError("加载样式文件失败");
		}
		
		protected function onResult(event:Event):void
		{
			var result:String = event.target.data as String;
			var css:Object = JSON.parse(result);
			constructGridStyle(css);
		}
		public function constructGridStyle(css:Object=null):void{
			if(css){
				for(var key:String in css){
					var styleDec:GridStyleDeclare = new GridStyleDeclare();
					styleDec.name = key;
					var declare:Object = css[key];
					var declareArr:Object = {};
					for(var name:String in declare){
						var style:GridStyle = new GridStyle();
						style.name = name;
						style.value = declare[name];
						declareArr[name] = style;
					}
					styleDec.values = declareArr;
					this._declares[key] = styleDec;
				}
			}
			constructGridGlobal();
			GridController.getInstance().styleChanged();
		}
		
		public function getDeclare(name:String):GridStyleDeclare{
			return this._declares[name] as GridStyleDeclare;
		} 
		private function constructGridGlobal():void
		{
			
		}

		private function getHeaderStyleDeclare(pos:int):GridStyleDeclare
		{
			var chDec:GridStyleDeclare = null;
			if(pos==1){
				chDec = GridStyleController.getInst().getDeclare(GridStyleController.CSSDECLARE_GRIDCOLHEADER);
			}else if(pos==0){
				chDec = GridStyleController.getInst().getDeclare(GridStyleController.CSSDECLARE_GRIDROWHEADER);
			}
			return chDec;
		}
		
		public function getHeaderCellBackColor(pos:int):Array{
			var chDec:GridStyleDeclare = getHeaderStyleDeclare(pos);
			var chSC:String = chDec.getStyle("backgroundColor").value as String;
			chSC==null?"0xF8F9FB,0xD7DFEB,0xFCF6E8,0xF3C66E":chSC;
			var chSCarr:Array = chSC.split(",");
			return chSCarr;
		}
		public function getHeaderCellOverBackColor(pos:int):Array{
			var chSCarr:Array = getHeaderCellBackColor(pos);
			return [parseInt(chSCarr[2]),parseInt(chSCarr[3])];
		}
		public function getHeaderCellOutBackColor(pos:int):Array{
			var chSCarr:Array = getHeaderCellBackColor(pos);
			return [parseInt(chSCarr[0]),parseInt(chSCarr[1])];
		}
		public function getHeaderCellSelectionColor(pos:int):Array{
			var chDec:GridStyleDeclare = getHeaderStyleDeclare(pos);
			var chSC:String = chDec.getStyle("selectionColor").value as String;
			chSC==null?"0xF8F9FB,0xD7DFEB,0xFCF6E8,0xF3C66E":chSC;
			var chSCarr:Array = chSC.split(",");
			return chSCarr;
		}
		public function getHeaderCellOverSelectionColor(pos:int):Array{
			var chSCarr:Array = getHeaderCellSelectionColor(pos);
			return [parseInt(chSCarr[2]),parseInt(chSCarr[3])];
		}
		public function getHeaderCellOutSelectionColor(pos:int):Array{
			var chSCarr:Array = getHeaderCellSelectionColor(pos);
			return [parseInt(chSCarr[0]),parseInt(chSCarr[1])];
		}
		public function getHeaderCellColor(pos:int):int{
			var chDec:GridStyleDeclare = getHeaderStyleDeclare(pos);
			var chC:String = chDec.getStyle("color").value as String;
			return parseInt(chC);
		}
		public function getHeaderCellBorderColor(pos:int):Array{
			var chDec:GridStyleDeclare = getHeaderStyleDeclare(pos);
			var chBRC:String = chDec.getStyle("borderColor").value as String;
			chBRC==null?"0x000000,0x000000":chBRC;
			var chBRCarr:Array = chBRC.split(",");
			return chBRCarr;
		}
		public function getHeaderCellSelectBorderColor(pos:int):int{
			return parseInt(getHeaderCellBorderColor(pos)[1]);
		}
		public function getHeaderCellNormalBorderColor(pos:int):int{
			return parseInt(getHeaderCellBorderColor(pos)[0]);
		}
	}
}