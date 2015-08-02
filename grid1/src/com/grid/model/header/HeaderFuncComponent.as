package com.grid.model.header
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.utils.PopupUtil;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import morn.core.components.Box;
	import morn.core.components.Image;
	
	
	
	
	public class HeaderFuncComponent extends Box
	{
		public static const ITEM_WIDTH:Number=10;
		private var _rowindex:int=-1;
		private var _colindex:int;
		private var _gridname:String;
		[Embed(source="/assets/sort_asc.png")]
		private var sort_asc:Class;
		[Embed(source="/assets/sort_desc.png")]
		private var sort_desc:Class;
		[Embed(source="/assets/filter.png")]
		private var filter:Class;
		private var sortasc:Image = new Image();
		private var sortdesc:Image = new Image();
		private var _filter:Image = new Image();

		public function HeaderFuncComponent()
		{
			super();
			this.initEvent();
		}
		
		override protected function createChildren():void{
			super.createChildren();
			addChild(sortasc);
			addChild(sortdesc);
			addChild(_filter);
		}
		override protected function initialize():void{
			super.initialize();
			sortasc.bitmapData = Bitmap(new sort_asc()).bitmapData;
			sortdesc.bitmapData = Bitmap(new sort_desc()).bitmapData;
			_filter.bitmapData = Bitmap(new filter()).bitmapData;
		}
		
		override protected function changeSize():void{
			super.changeSize();
			var cp:ColProp = GridController.getInstance().getGrid(_gridname).getColProp(_colindex);
			MonsterDebugger.trace(this,"readSort:"+cp.headerFunc.currSort);
			if(cp.headerFunc.currSort==NormalHeaderFuncProp.SORT_NOSORT){
				sortasc.visible = true;
				sortdesc.visible = false;
			}else if(cp.headerFunc.currSort==NormalHeaderFuncProp.SORT_ASC){
				sortasc.visible = true;
				sortdesc.visible = false;
			}else{
				sortdesc.visible = true;
				sortasc.visible = false;
			}
			sortasc.x = 0;
			sortasc.y = this.height/2-sortasc.height/2;
			sortdesc.x = 0;
			sortdesc.y = this.height/2-sortdesc.height/2;
			_filter.x = this.width/2;
			_filter.y = this.height/2-_filter.height/2;
		}
		private function popConfigWindow(e:MouseEvent=null):void{
			var image:Image = e.target as Image;
			var isSort:Boolean = true;
			if(image==_filter){
				isSort = false;
				PopupUtil.popupColFuncConfig(popupCallBack,
					this.colindex,this.rowindex,this.gridname);
			}
			if(isSort){
				GridController.getInstance().sortCol(this.colindex,this.gridname);
			}
		}
		private function popupCallBack(str:String):void{
		
		}
		private function initEvent():void
		{
			this.addEventListener(MouseEvent.CLICK,popConfigWindow);
		}
		
		public function get rowindex():int
		{
			return _rowindex;
		}

		public function set rowindex(value:int):void
		{
			_rowindex = value;
		}

		public function get colindex():int
		{
			return _colindex;
		}

		public function set colindex(value:int):void
		{
			_colindex = value;
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