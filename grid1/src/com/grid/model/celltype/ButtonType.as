package com.grid.model.celltype
{
	import morn.core.components.Button;
	
	public class ButtonType extends NONEType
	{
		private var _button:Button;
		public function ButtonType()
		{
		}
		
		override public function display():void
		{
			if(_button==null){
				_button = new Button("png.comp.button");
				p.addChild(_button);
			}
			_button.width = cw;
			_button.height = ch;
			_button.label = cell.extendProp.text;
		}
	}
}