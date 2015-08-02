package com.grid.components.logic
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.model.GridView;
	import com.grid.model.PageBuilder;
	
	import flash.events.Event;
	
	import morn.core.components.Panel;
	import morn.core.components.ScrollBar;
	
	
	
	
	public class GridViewWithScroll extends Panel
	{
		private var _gridView:GridView;
		
		public function GridViewWithScroll()
		{
			this.vScrollBar.addEventListener(Event.CHANGE,scrollVerticalMove);
			this.hScrollBar.addEventListener(Event.CHANGE,scrollHorizontalMove);
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			this.hScrollBarSkin = "png.comp.hscroll";
			this.vScrollBarSkin = "png.comp.vscroll";
		}
		override protected function createChildren():void
		{
			super.createChildren();
			addChild(_gridView = new GridView());
		}
		private function scrollHorizontalMove(e:Event):void{
			this.hScrollBar.removeEventListener(Event.CHANGE,scrollHorizontalMove);
			this.gridView.headerMove(ScrollBar.HORIZONTAL,this.hScrollBar.value);	
			this.hScrollBar.addEventListener(Event.CHANGE,scrollHorizontalMove);
		}
		private function scrollVerticalMove(e:Event):void{
			this.vScrollBar.removeEventListener(Event.CHANGE,scrollVerticalMove);
			if(this.vScrollBar.value==this.vScrollBar.max){
				var pb:PageBuilder = GridController.getInstance().getPageBuilder(this.gridView.gridname);
				if(pb.hasNextPage()){
					this.vScrollBar.value = this.vScrollBar.max/2;
					this.gridView.drawPages(this.gridView.gridname,"toBottom");
				}
			}else if(this.vScrollBar.value==0){
				var pb:PageBuilder = GridController.getInstance().getPageBuilder(this.gridView.gridname);
				if(pb.hasPrePage()){
					this.vScrollBar.value = this.vScrollBar.max/2;
					this.gridView.drawPages(this.gridView.gridname,"toTop");
				}
			}
			this.gridView.headerMove(ScrollBar.VERTICAL,this.vScrollBar.value);
			this.vScrollBar.addEventListener(Event.CHANGE,scrollVerticalMove);
		}
		
		private function setVerticalScrollMaxValueByData(e:GridEvent):void{
			this.vScrollBar.value = 0;
			var grid:IGrid = GridController.getInstance().getGrid(this.gridView.gridname);
			var sh:Number = this.gridView.colHeaderHeight();
			var rowcount:int = grid.rowcount;
			for(var i:int=0;i<rowcount;i++){
				sh+=grid.getRowProp(i).height;
			}
			this.vScrollBar.max = sh-this.height;
		}
		
		public function get gridView():GridView
		{
			return _gridView;
		}

		public function set gridView(value:GridView):void
		{
			_gridView = value;
		}
	}
}