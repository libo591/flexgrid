package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.components.logic.GridViewWithScroll;
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridController;
	import com.grid.styles.GridStyleController;
	import com.grid.utils.GridJsonDataParser;
	
	import morn.core.components.View;
	
	public class TableJsonMain extends View
	{
		private var _json:String;
		public var grid:IGrid;
		public var gs:GridViewWithScroll;
		public function TableJsonMain()
		{
		}
		override protected function createChildren():void
		{
			super.createChildren();
			gs = new GridViewWithScroll();
			this.addChild(gs);
		}

		public function get json():String
		{
			return _json;
		}

		public function set json(value:String):void
		{
			_json = value;
			grid = GridJsonDataParser.parse2Grid(value,gs.gridView.gridname);
			GridController.getInstance().regist(gs.gridView.gridname,grid,gs.gridView);
			gs.gridView.scrollWidth = this.width;
			gs.gridView.scrollHeight = this.width;
			GridController.getInstance().showGrid(gs.gridView.gridname);
			gs.width = this.width;
			gs.height = this.height;
			if(grid.style is String){
				GridStyleController.getInst().loadAndShowStyles(grid.style as String);
			}else{
				GridStyleController.getInst().constructGridStyle(grid.style);
			}
		}

	}
}