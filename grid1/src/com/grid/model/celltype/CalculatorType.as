package com.grid.model.celltype
{
	import com.grid.utils.PopupUtil;
	
	import flash.events.MouseEvent;
	
	import morn.core.components.Label;
	
	
	public class CalculatorType extends NONEType
	{
		private var _label:Label;
		public function CalculatorType()
		{
		}
		override public function display():void
		{
			if(_label==null){
				_label = new Label();
				p.addChild(_label);
				_label.addEventListener(MouseEvent.CLICK,labelClick);
			}
			_label.width = cw;
			_label.height = ch;
			_label.text = cell.extendProp.text;
		}
		
		private function cbFunc(value:Object):void{
			_label.text = value.toString();
			cell.extendProp.text = _label.text;
			cell.extendProp.value = _label.text;
		}
		
		protected function labelClick(event:MouseEvent):void
		{
			PopupUtil.popupCalculator(cbFunc,Number(cell.extendProp.value));
		}
	}
}