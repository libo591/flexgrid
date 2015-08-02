package com.grid.interfaces
{

	public interface ICellProp
	{
		/** 设置真实值 */
		function set value(value:Object):void;
		/** 设置显示值 */
		function set text(value:String):void;
		/** 设置数据为显示*/
		function set dataVisiable(value:Boolean):void;
		/** 设置超链接窗口*/
		function set hrefTarget(value:String):void;
		/** 设置超链接地址*/
		function set href(value:String):void;
		/** 设置单元格图片数据*/
		function set imageData(value:Object):void;
		/** 设置单元格类型json数据 */
		function set typeData(value:Object):void;
		
		
		/** 获取真实值 */
		function get value():Object;
		/** 获取显示值 */
		function get text():String;
		/** 获取数据是否显示*/
		function get dataVisiable():Boolean;
		/** 获取超链接窗口*/
		function get hrefTarget():String;
		/** 获取超链接地址*/
		function get href():String;
		/** 获取单元格图片数据*/
		function get imageData():Object;
		/** 获取单元格类型json数据 */
		function get typeData():Object;
		
	}
}