package com.grid.model.celltype
{
	import morn.core.components.NumericStepper;
	
	
	public class NumericType extends NONEType
	{
		private var _numericStepper:NumericStepper;
		public function NumericType()
		{
		}
		
		override public function display():void
		{
			if(_numericStepper==null){
				_numericStepper = new NumericStepper();
				p.addChild(_numericStepper);
			}
			var json:Object = cell.extendProp.typeData;
			_numericStepper.direction = NumericStepper.RIGHT;
			_numericStepper.skin = "png.comp.NumericStepper";
			_numericStepper.dataSource = json;
			_numericStepper.width = cw;
			_numericStepper.height = ch;
		}
	}
}