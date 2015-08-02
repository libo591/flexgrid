package com.grid.model.celltype
{
	
	import morn.core.components.ColorField;
	import morn.core.events.UIEvent;
	
	
	public class ColorPickerType extends NONEType
	{
		private var _colorField:ColorField;
		public function ColorPickerType()
		{
		}
		
		override public function display():void
		{
			if(_colorField==null){
				_colorField = new ColorField();
				_colorField.addEventListener("select",selectValue);
				p.addChild(_colorField);
			}
			_colorField.width = cw;
			_colorField.height = ch;
			_colorField.initValue = uint(this.cell.extendProp.value);
		}
		
		protected function selectValue(event:UIEvent):void
		{
			this.cell.extendProp.text = event.data;
			this.cell.extendProp.value = event.data;
		}
	}
}