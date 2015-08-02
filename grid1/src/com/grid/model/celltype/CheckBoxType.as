package com.grid.model.celltype
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.Event;
	
	import morn.core.components.Box;
	import morn.core.components.CheckBox;

	public class CheckBoxType extends NONEType
	{
		private var _box:Box;
		public function CheckBoxType()
		{
		}
		
		/**
		 * [{label:"",selected:""},{}]
		 */
		override public function display():void
		{
			if(_box==null){
				_box = new Box();
				_box.addEventListener(Event.SELECT,selectLis);
				p.addChild(_box);
			}else{
				_box.removeAllChild();
			}
			var json:Object = cell.extendProp.typeData;
			var jsonData:Array = json.data;
			var deriction:String = json.deriction;
			var itemlen:Number = 0;
			for(var i:int=0;i<jsonData.length;i++){
				var ck:CheckBox = new CheckBox("png.comp.checkbox");
				ck.dataSource = jsonData[i];
				if(deriction=="v"){//每个子项纵向排列
					ck.y = ck.height*i;
					ck.x = cw/2-ck.width/2;
					itemlen = ck.height;
				}else{
					ck.y = ch/2-ck.height/2;
					ck.x = ck.width*i;
					itemlen = ck.width;
				}
				_box.addChild(ck);
			}
			if(deriction=="v"){//每个子项纵向排列
				_box.width = cw;
				_box.height = itemlen*jsonData.length;
				_box.y = (ch/2-_box.height/2)<0?0:(ch/2-_box.height/2);
			}else{
				_box.width = itemlen*jsonData.length;
				_box.height = ch;
				_box.x = (cw/2-_box.width/2)<0?0:(cw/2-_box.width/2);
			}
		}
		
		protected function selectLis(event:Event):void
		{
			var checkbox:CheckBox = event.target as CheckBox;
			if(checkbox){
				var len:int = _box.numChildren;
				var str:String = "";
				for(var i:int=0;i<len;i++){
					var ck:CheckBox = _box.getChildAt(i) as CheckBox;
					if(ck.selected){
						str+=ck.tag+",";
					}
				}
				if(StringUtil.endsWith(str,",")){
					str = str.substring(0,str.length-1);
				}
				cell.extendProp.text = str;
				cell.extendProp.value = str;
			}
		}		
		
	}
}