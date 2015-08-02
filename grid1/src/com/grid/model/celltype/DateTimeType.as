package com.grid.model.celltype
{
	import morn.core.components.DateField;
	import morn.core.events.UIEvent;
	
	public class DateTimeType extends NONEType
	{
		private var _dateField:DateField;
		
		public function DateTimeType()
		{
		}
		
		override public function display():void
		{
			if(_dateField==null){
				_dateField = new DateField();
				_dateField.addEventListener("select",selectValue);
				p.addChild(_dateField);
			}
			_dateField.width = cw;
			_dateField.height = ch;
			if(this.cell.extendProp.value){
				_dateField.initValue = this.cell.extendProp.value.toString();
			}
		}
		
		protected function selectValue(event:UIEvent):void
		{
			this.cell.extendProp.text = event.data;
			this.cell.extendProp.value = event.data;
		}
	}
}