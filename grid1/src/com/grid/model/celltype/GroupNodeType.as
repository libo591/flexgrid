package com.grid.model.celltype
{
	import com.grid.interfaces.IGrid;
	import com.grid.model.GridController;
	import com.grid.model.header.RowProp;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import morn.core.components.Image;
	import morn.core.components.Label;
	
	public class GroupNodeType extends NONEType
	{
		[Embed(source='/assets/arrow_right.png')]
		[Bindable]
		private var ARROW_RIGHT:Class;
		
		[Embed(source='/assets/arrow_bottom.png')]
		[Bindable]
		private var ARROW_BOTTOM:Class;
		
		private var rightBit:Bitmap = new ARROW_RIGHT();
		private var bottomBit:Bitmap = new ARROW_BOTTOM();
		private var _image:Image;
		private var _label:Label;
		
		public function GroupNodeType()
		{
		}
		
		override public function display():void
		{
			if(_image==null){
				_image = new Image();
				p.addChild(_image);
				_image.addEventListener(MouseEvent.CLICK,nodeClick);
			}
			if(_label==null){
				_label = new Label();
				p.addChild(_label);
			}
			var grid:IGrid = GridController.getInstance().getGrid(gridname);
			var crp:RowProp = grid.getRowProp(rowindex);
			var offsetx:Number = (crp.treeLevel-1)*10;
			if(crp.treeExpand){
				_image.bitmapData = bottomBit.bitmapData;
			}else{
				_image.bitmapData = rightBit.bitmapData;
			}
			_image.x = offsetx;
			_image.y = ch/2-_image.height/2;
			
			_label.text = cell.extendProp.text;
			_label.x = _image.x+_image.width;
			_label.y = ch/2-_label.height/2;
			if(isLeaf()){
				_image.visible = false;
			}
		}
		private function isLeaf():Boolean{
			var isLeaf:Boolean = false;
			var grid:IGrid = GridController.getInstance().getGrid(gridname);
			var crp:RowProp = grid.getRowProp(rowindex);
			if(rowindex==grid.rowcount-1){
				isLeaf = true;
			}
			if(!isLeaf){
				var nrp:RowProp = grid.getRowProp(rowindex+1);
				if(nrp.treeLevel<=crp.treeLevel){
					isLeaf = true;
				}
			}
			return isLeaf;
		}
		protected function nodeClick(event:MouseEvent):void
		{
			if(isLeaf()){
				return;
			}
			var grid:IGrid = GridController.getInstance().getGrid(gridname);
			var crp:RowProp = grid.getRowProp(rowindex);
			var ep:Boolean = crp.treeExpand;
			if(_image){
				if(ep){
					crp.treeExpand = false;
					_image.bitmapData = rightBit.bitmapData;
				}else{
					crp.treeExpand = true;
					_image.bitmapData = bottomBit.bitmapData;
				}
			}
			var rowcount:int = grid.rowcount;
			for(var i:int=rowindex+1;i<rowcount;i++){
				var rp:RowProp = grid.getRowProp(i);
				if(rp.treeLevel<=crp.treeLevel){
					break;
				}else{
					if(ep){
						rp.visiable = true;
					}else{
						rp.visiable = false;
					}
				}
			}
			GridController.getInstance().showGrid(gridname);
		}
	}
}