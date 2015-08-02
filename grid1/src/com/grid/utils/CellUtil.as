package com.grid.utils
{
	public class CellUtil
	{
		public function CellUtil()
		{
		}
		
		public static function xChanged(flag:int):Boolean{
			return flag&&CellUtil.XCHANGE==CellUtil.XCHANGE;
		}
		public static function yChanged(flag:int):Boolean{
			return flag&&CellUtil.YCHANGE==CellUtil.YCHANGE;
		}
		public static function wChanged(flag:int):Boolean{
			return flag&&CellUtil.WIDTHCHANGE==CellUtil.WIDTHCHANGE;
		}
		public static function hChanged(flag:int):Boolean{
			return flag&&CellUtil.HEIGHTCHANGE==CellUtil.HEIGHTCHANGE;
		}
		public static function textChanged(flag:int):Boolean{
			return flag&&CellUtil.TEXTCHANGE==CellUtil.TEXTCHANGE;
		}
		public static function fcChanged(flag:int):Boolean{
			return flag&&CellUtil.FORECOLORCHANGE==CellUtil.FORECOLORCHANGE;
		}
		public static function bcChanged(flag:int):Boolean{
			return flag&&CellUtil.BACKCOLORCHANGE==CellUtil.BACKCOLORCHANGE;
		}
		public static function typefaceChanged(flag:int):Boolean{
			return flag&&CellUtil.TYPEFACECHANGE==CellUtil.TYPEFACECHANGE;
		}
		public static function fontsizeChanged(flag:int):Boolean{
			return flag&&CellUtil.FONTSIZECHANGE==CellUtil.FONTSIZECHANGE;
		}
		public static function alignChanged(flag:int):Boolean{
			return flag&&CellUtil.ALIGNCHANGE==CellUtil.ALIGNCHANGE;
		}
		public static function valignChanged(flag:int):Boolean{
			return flag&&CellUtil.VALIGNCHANGE==CellUtil.VALIGNCHANGE;
		}
		public static function textFormatChanged(flag:int):Boolean{
			return flag&&CellUtil.TEXTFORMATCHANGE==CellUtil.TEXTFORMATCHANGE;
		}
		public static function indentChanged(flag:int):Boolean{
			return flag&&CellUtil.INDENTCHANGE==CellUtil.INDENTCHANGE;
		}
		public static function boldChanged(flag:int):Boolean{
			return flag&&CellUtil.BOLDCHANGE==CellUtil.BOLDCHANGE;
		}
		public static function italicChanged(flag:int):Boolean{
			return flag&&CellUtil.ITALICCHANGE==CellUtil.ITALICCHANGE;
		}
		public static function underlineChanged(flag:int):Boolean{
			return flag&&CellUtil.UNDERLINECHANGE==CellUtil.UNDERLINECHANGE;
		}
		public static function borderChanged(flag:int):Boolean{
			return flag&&CellUtil.BORDERCHANGE==CellUtil.BORDERCHANGE;
		}
		public static function cellImageChanged(flag:int):Boolean{
			return flag&&CellUtil.CELLIMAGECHANGE==CellUtil.CELLIMAGECHANGE;
		}
		private static var XCHANGE:int = Math.pow(2,0);
		private static var YCHANGE:int = Math.pow(2,1);
		private static var TEXTCHANGE:int = Math.pow(2,2);
		private static var WIDTHCHANGE:int = Math.pow(2,3);
		private static var HEIGHTCHANGE:int = Math.pow(2,4);
		private static var FORECOLORCHANGE:int = Math.pow(2,5);
		private static var BACKCOLORCHANGE:int = Math.pow(2,6);
		private static var TYPEFACECHANGE:int = Math.pow(2,7);
		private static var FONTSIZECHANGE:int = Math.pow(2,8);
		private static var ALIGNCHANGE:int = Math.pow(2,9);
		private static var VALIGNCHANGE:int = Math.pow(2,10);
		private static var TEXTFORMATCHANGE:int = Math.pow(2,11);
		private static var INDENTCHANGE:int = Math.pow(2,12);
		private static var BOLDCHANGE:int = Math.pow(2,13);
		private static var ITALICCHANGE:int = Math.pow(2,14);
		private static var UNDERLINECHANGE:int = Math.pow(2,15);
		private static var BORDERCHANGE:int = Math.pow(2,16);
		private static var CELLIMAGECHANGE:int = Math.pow(2,17);
		
		public static function setxChanged(flag:int):int{
			return flag^CellUtil.XCHANGE;
		}
		public static function setyChanged(flag:int):int{
			return flag^CellUtil.YCHANGE;
		}
		public static function setwChanged(flag:int):int{
			return flag^CellUtil.WIDTHCHANGE;
		}
		public static function sethChanged(flag:int):int{
			return flag^CellUtil.HEIGHTCHANGE;
		}
		public static function settextChanged(flag:int):int{
			return flag^CellUtil.TEXTCHANGE;
		}
		public static function setfcChanged(flag:int):int{
			return flag^CellUtil.FORECOLORCHANGE;
		}
		public static function setbcChanged(flag:int):int{
			return flag^CellUtil.BACKCOLORCHANGE;
		}
		public static function settypefaceChanged(flag:int):int{
			return flag^CellUtil.TYPEFACECHANGE;
		}
		public static function setfontsizeChanged(flag:int):int{
			return flag^CellUtil.FONTSIZECHANGE;
		}
		public static function setalignChanged(flag:int):int{
			return flag^CellUtil.ALIGNCHANGE;
		}
		public static function setvalignChanged(flag:int):int{
			return flag^CellUtil.VALIGNCHANGE;
		}
		public static function settextFormatChanged(flag:int):int{
			return flag^CellUtil.TEXTFORMATCHANGE;
		}
		public static function setindentChanged(flag:int):int{
			return flag^CellUtil.INDENTCHANGE;
		}
		public static function setboldChanged(flag:int):int{
			return flag^CellUtil.BOLDCHANGE;
		}
		public static function setitalicChanged(flag:int):int{
			return flag^CellUtil.ITALICCHANGE;
		}
		public static function setunderlineChanged(flag:int):int{
			return flag^CellUtil.UNDERLINECHANGE;
		}
		public static function setborderChanged(flag:int):int{
			return flag^CellUtil.BORDERCHANGE;
		}
		public static function setcellImageChanged(flag:int):int{
			return flag^CellUtil.CELLIMAGECHANGE;
		}
		
		public static function allChangeFlag():int{
			return parseInt("11111111111111111",2);
		}
		/**
		 * 0=A
		 */
		public static function getColNameByIndex(colindex:int):String{
			var quotient:int = colindex + 1;
			var remainder:int;
			var r:String="";
			while (quotient > 26) {
				remainder = (quotient % 26);
				quotient = int((quotient / 26));
				if (remainder == 0){
					r = (String.fromCharCode((64 + 26)) + r);
					quotient = (quotient - 1);
				} else {
					r = (String.fromCharCode((64 + remainder)) + r);
				};
			};
			if (quotient > 0){
				r = (String.fromCharCode((64 + quotient)) + r);
			};
			return r;
		}
		public static function getColIndexByName(colname:String):int{
			var len:int = colname.length;
			var result:int = 0;
			for(var i:int=0;i<len;i++){
				var nowcode:Number = colname.charCodeAt(i);
				nowcode = nowcode-65+1;
				result +=nowcode*Math.pow(26,(len-1-i));
			}
			return result-1;
		}
		public static function splitCellToIndex(cellName:String):Array{
			var len:int = cellName.length;
			var colname:String = "";
			var rowname:String = "";
			for(var i:int=0;i<len;i++){
				var nowcode:Number = cellName.charCodeAt(i);
				if(nowcode>=("A".charCodeAt(0))
					&&nowcode<=("Z".charCodeAt(0))){
					colname += cellName.charAt(i);
				}else{
					rowname += cellName.charAt(i);
				}
			}
			return [parseInt(rowname)-1,getColIndexByName(colname)];
		}
		public static function getCellNameByIndex(index:Array):String{
			var colname:String = getColNameByIndex(index[1]);
			return colname+(index[0]+1);
		}
	}
}