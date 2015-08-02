package com.grid.model.celltype
{
	import morn.core.components.RadioGroup;
	import morn.core.handlers.Handler;
	
	public class RadioType extends NONEType
	{
		private var _radioGroup:RadioGroup;
		public function RadioType()
		{
		}
		
		override public function display():void
		{
			if(_radioGroup==null){
				_radioGroup = new RadioGroup("","png.comp.radiogroup");
				_radioGroup.selectHandler = new Handler(rgselect);
				p.addChild(_radioGroup);
			}
			var jsonObj:Object = cell.extendProp.typeData;
			var json:Array = jsonObj.data;
			var direction:String = jsonObj.direction;
			var count:int = json.length;
			var selIndex:int = 0;
			var labels:String="";
			var seq:String = "";
			for(var i:int=0;i<count;i++){
				if(cell.extendProp.value==json[i]["value"]){
					selIndex = i;
				}
				labels+=seq+json[i]["label"];
				seq = ",";
			}
			_radioGroup.labels = labels;
			_radioGroup.selectedIndex = selIndex;
			if(direction=="h"){
				_radioGroup.direction = RadioGroup.HORIZENTAL;
			}else{
				_radioGroup.direction = RadioGroup.VERTICAL;
			}
			_radioGroup.width = cw;
			_radioGroup.height = ch;
		}
		
		private function rgselect(index:int):void
		{
			var json:Array = cell.extendProp.typeData.data as Array;
			this.cell.extendProp.text = json[index]["label"]+"";
			this.cell.extendProp.value = json[index]["value"];
		}
	}
}