package com.grid.model.celltype
{
	import morn.core.components.ComboBox;
	import morn.core.handlers.Handler;
	
	
	public class ComboBoxType extends NONEType
	{
		private var _comboBox:ComboBox;
		public function ComboBoxType()
		{
		}
		
		/**
		 * [{icon:"",label:"",value:""},{}]
		 */
		override public function display():void
		{
			if(_comboBox==null){
				_comboBox = new ComboBox();
				_comboBox.selectHandler = new Handler(cbSelect);
				p.addChild(_comboBox);
			}
			_comboBox.width = cw;
			_comboBox.height = ch;
			var arr:Array = cell.extendProp.typeData as Array;
			var labels:String = "";
			var seq:String="";
			var selIndex:int = 0;
			for(var i:int=0;i<arr.length;i++){
				labels+=seq+arr[i].label;
				seq = ",";
				if(cell.extendProp.value==arr[i]["value"]){
					selIndex = i;
				}
			}
			_comboBox.labels = labels;
			_comboBox.skin = "png.comp.combobox";
			_comboBox.scrollBarSkin="png.comp.vscroll";
			_comboBox.selectedIndex = selIndex;
		}
		
		protected function cbSelect(index:int):void
		{
			try{
				var arr:Array = cell.extendProp.typeData as Array;
				var obj:Object = arr[index];
				cell.extendProp.text = obj["value"];
				cell.extendProp.value = obj["value"];
			}catch(e:Error){}
		}
	}
}