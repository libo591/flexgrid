package com.grid.model.celltype
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import morn.core.components.Image;
	
	
	public class ImageType extends NONEType
	{
		private var _image:Image;
		
		public function ImageType()
		{
		}
		
		override public function display():void
		{
			if(_image==null){
				_image = new Image();
				p.addChild(_image);
			}
			var imageData:Object = cell.extendProp.imageData;
			if(imageData is BitmapData){
				var bitmapdata:BitmapData = BitmapData(imageData);
				_image.bitmapData = bitmapdata;
				_image.x = cw/2-bitmapdata.width/2;
				_image.y = ch/2-bitmapdata.height/2;
				if(bitmapdata.width>cw){
					_image.width = cw;
					_image.x = 0;
				}
				if(bitmapdata.height>ch){
					_image.height = ch;
					_image.y = 0;
				}
			}else if(imageData is String){
				_image.url = String(imageData);
				_image.x = cw/2-_image.width/2;
				_image.y = ch/2-_image.height/2;
			}
		}
	}
}