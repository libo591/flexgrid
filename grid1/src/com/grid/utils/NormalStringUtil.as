package com.grid.utils
{
	public class NormalStringUtil
	{
		public function NormalStringUtil()
		{
		}
		
		public static function expandExp(exp:String):String{
			var code:Number = "$".charCodeAt(0);
			var Acode:Number = "A".charCodeAt(0);
			var Zcode:Number = "Z".charCodeAt(0);
			var code0:Number = "0".charCodeAt(0);
			var code9:Number = "9".charCodeAt(0);
			var codeMao:Number = ":".charCodeAt(0);
			var codeDou:Number = ",".charCodeAt(0);
			var count:int = exp.length;
			for(var i:int=0;i<count;i++){
				var nowcode:Number = exp.charCodeAt(i);
				if(nowcode==codeMao){
					var beginCellName:String = "";
					var endCellName:String = "";
					var bs:Array = [];
					for(var bi:int=i-1;bi>=0;bi--){
						var bnc:Number = exp.charCodeAt(bi);
						if(bnc==code){
							break;	
						}else{
							bs.push(exp.charAt(bi));
						}
					}
					bs = bs.reverse();
					beginCellName = bs.join("");
					bs = [];
					for(var bi:int=i+1;bi<count;bi++){
						var bnc:Number = exp.charCodeAt(bi);
						var bc:String = exp.charAt(bi);
						if(bnc==code){
							continue;
						}else if(isSymbol(bc)){
							break;	
						}else{
							bs.push(bc);
						}
					}
					endCellName = bs.join("");
					var cellstr:String = "";
					var seq:String = "";
					var beginIndexarr:Array = CellUtil.splitCellToIndex(beginCellName);
					var endIndexarr:Array = CellUtil.splitCellToIndex(endCellName);
					for(var rowindex:int=beginIndexarr[0];rowindex<=endIndexarr[0];rowindex++){
						for(var colindex:int=beginIndexarr[1];colindex<=endIndexarr[1];colindex++){
							cellstr +=seq+"$"+CellUtil.getCellNameByIndex([rowindex,colindex]);
							seq = ",";
						}
					}
					exp = exp.replace("$"+beginCellName+":$"+endCellName,cellstr);
				}
			}
			return exp;
		}
		public static function getAllCellName(exp:String):Array{
			var code:Number = "$".charCodeAt(0);
			var Acode:Number = "A".charCodeAt(0);
			var Zcode:Number = "Z".charCodeAt(0);
			var code0:Number = "0".charCodeAt(0);
			var code9:Number = "9".charCodeAt(0);
			var count:int = exp.length;
			var stack:Array = [];
			var result:Array = [];
			for(var i:int=0;i<count;i++){
				var nowcode:Number = exp.charCodeAt(i);
				if(nowcode==code){
					stack.push("$");
				}
				
				if(stack.length>0){
					if((nowcode>=Acode&&nowcode<=Zcode)
						||(nowcode>=code0&&nowcode<=code9)){
						stack.push(exp.charAt(i));
					}else{
						if(nowcode!=code){
							var resultname:String = stack.join("");
							result.push(resultname.substring(1));
							stack = [];
						}
					}
				}
				
			}
			return result;
		}
		private static function isSymbol(c:String):Boolean{
			return c == '+' || c == '-' || c == '*' || c == '/' || c == '%' ||
				c == '=' || c == '&' || c == '|' || c == '!' || c == ':' ||
				c == ',' || c == '>' || c == '<' || c == '(' || c == ')' ||
				c == '[' || c == ']' || c == '{' || c == '}' || c == ';';
		}
	}
}