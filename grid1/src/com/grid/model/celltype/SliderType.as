package com.grid.model.celltype
{
	import morn.core.components.HSlider;
	import morn.core.handlers.Handler;
	
	public class SliderType extends NONEType
	{
		private var _slider:HSlider;
		
		public function SliderType()
		{
		}
		
		/**
		 * {tick:,min,max,value}
		 */
		override public function display():void
		{
			if(_slider==null){
				_slider = new HSlider("png.comp.hslider");
				_slider.changeHandler = new Handler(sliderChange);
				p.addChild(_slider);
			}
			var json:Object = cell.extendProp.typeData;
			_slider.dataSource = json;
			_slider.width = cw;
			_slider.y = ch/2-_slider.height/2;
			_slider.showLabel = true;
		}
		
		private function sliderChange(value:int):void
		{
			this.cell.extendProp.text = value+"";
			this.cell.extendProp.value = value;
		}
		
	}
}