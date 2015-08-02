package com.grid.model.celltype
{
	import morn.core.components.Label;
	
	
	
	public class RichTextType extends NONEType
	{
		private var _label:Label;
		public function RichTextType()
		{
		}
		
		override public function display():void
		{
			if(_label==null){
				_label = new Label();
				p.addChild(_label);
			}
			_label.width = cw;
			_label.height = ch;
			_label.isHtml = true;
			_label.text= cell.extendProp.text;
		}
	}
}