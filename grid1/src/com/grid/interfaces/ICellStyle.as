package com.grid.interfaces
{
	import flash.display.Bitmap;

	public interface ICellStyle
	{
		/** 背景色 */
		function set backgroundColor(color:uint):void;
		/** 显示值的显示格式 */
		function set textFormat(value:String):void;
		/** 前景色 */
		function set forecolor(value:uint):void;
		/** 尺寸调整方式 */
		function set textResize(value:int):void;
		/** 自动换行 */
		function set textWrap(value:Boolean):void;
		/** 缩进 */
		function set indentation(value:uint):void;
		/** 水平对齐 */
		function set horizontalAligh(value:int):void;
		/** 纵向对齐 */
		function set verticalAlign(value:int):void;
		/** 字体 */
		function set typeface(value:String):void;
		/** 字号 */
		function set fontsize(value:uint):void;
		/** 加粗 */
		function set bold(value:Boolean):void;
		/** 下划线 */
		function set underline(value:Boolean):void;
		/** 斜体 */
		function set italic(value:Boolean):void;
		
		/** 背景色 */
		function get backgroundColor():uint;
		/** 显示值的显示格式 */
		function get textFormat():String;
		/** 前景色 */
		function get forecolor():uint;
		/** 尺寸调整方式 */
		function get textResize():int;
		/** 自动换行 */
		function get textWrap():Boolean;
		/** 缩进 */
		function get indentation():uint;
		/** 水平对齐 */
		function get horizontalAligh():int;
		/** 纵向对齐 */
		function get verticalAlign():int;
		/** 字体 */
		function get typeface():String;
		/** 字号 */
		function get fontsize():uint;
		/** 加粗 */
		function get bold():Boolean;
		/** 下划线 */
		function get underline():Boolean;
		/** 斜体 */
		function get italic():Boolean;
	}
}