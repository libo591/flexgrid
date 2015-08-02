package com.grid.model
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.interfaces.IGrid;
	import com.grid.model.header.RowProp;

	public class PageBuilder
	{
		private var _currPage:int=0;
		public static var showStep:int = 2;
		private var pagesStore:Array=[];
		private var _g:IGrid;
		public function PageBuilder(grid:IGrid,scrollWidth:Number,scrollHeight:Number)
		{
			this._g = grid;
			MonsterDebugger.trace(this,"可视宽高"+[scrollWidth,scrollHeight].join("="));
			var rps:Array = grid.rowProps;
			var smHeight:Number = 0;
			for(var i:int=0;i<rps.length;i++){
				var rp:RowProp = rps[i] as RowProp;
				if(grid.type==GridConst.GRIDTYPE_DISPLAY
					&&!rp.visiable){
					continue;
				}
				smHeight+=rp.height;
				if(smHeight>=scrollHeight){
					if(smHeight==scrollHeight){
						smHeight = 0;
					}else{
						smHeight = rp.height;
					}
					var page:Page = new Page();
					if(pagesStore.length==0){
						page.startRow = 0;
					}else{
						var lastPage:Page = pagesStore[pagesStore.length-1];
						page.startRow = lastPage.endRow+1;
					}
					if(smHeight==scrollHeight){
						page.endRow=i;
					}else{
						page.endRow=i-1;
					}
					page.startCol = 0;
					page.endCol = grid.colcount-1;
					pagesStore.push(page);
				}
			}
			if(smHeight>0){
				var page:Page = new Page();
				if(pagesStore.length==0){
					page.startRow = 0;
				}else{
					var lastPage:Page = pagesStore[pagesStore.length-1];
					page.startRow = lastPage.endRow+1;
				}
				page.endRow=grid.rowcount-1;
				page.startCol = 0;
				page.endCol = grid.colcount-1;
				pagesStore.push(page);
			}
		}
		public function getPageCount():int{
			return pagesStore.length;
		}
		public function getCurrShow():Array{
			var result:Array = [];
			for(var i:int=0;i<getPageCount()&&i<showStep;i++){
				var page:Page = this.getPage(this.currPage+i);
				result.push(page);
			}
			return result;
		}
		public function hasPrePage():Boolean{
			if(this.currPage<=0){
				return false;
			}
			return true;
		}
		public function hasNextPage():Boolean{
			if((this.currPage+showStep-1)>=(this.getPageCount()-1)){
				return false;
			}
			return true;
		}
		public function toNextPage():Array{
			this.currPage++;
			if((this.currPage+showStep-1)>=(this.getPageCount()-1)){
				this.currPage = this.getPageCount()-showStep;
			}
			return getCurrShow();
		}
		public function toPrePage():Array{
			this.currPage--;
			if(this.currPage<0){
				this.currPage = 0;
			}
			return getCurrShow();
		}
		public function getPage(index:int):Page{
			if(index<0||index>=this.getPageCount()){
				return null;
			}
			return this.pagesStore[index] as Page;
		}
		public function toString():String{
			var count:int = getPageCount();
			var result:String = "";
			for(var i:int=0;i<count;i++){
				result += (this.pagesStore[i] as Page).toString();
				result += ",";
			}
			return result;
		}

		public function get currPage():int
		{
			return _currPage;
		}

		public function set currPage(value:int):void
		{
			_currPage = value;
		}

		public function get g():IGrid
		{
			return _g;
		}

		public function set g(value:IGrid):void
		{
			_g = value;
		}


	}
}