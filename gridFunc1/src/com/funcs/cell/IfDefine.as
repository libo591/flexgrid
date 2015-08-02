package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	import r1.deval.D;
	
	public class IfDefine extends BasicFunc
	{
		public function IfDefine()
		{
			super();
		}
		private function calcBooleanResult(str:String):Boolean{
			return D.evalToBoolean(str);
		}
		override public function excute(...parameters):Object{
			var result:Object=null;
			var argcount:int = parameters.length;
			var index:int = 0;
			while(index<argcount){
				if(index+1==argcount){
					result = parameters[argcount-1];
					break;
				}
				var currarg:String = parameters[index] as String;
				var currBool:Boolean = calcBooleanResult(currarg);
				if(currBool){
					result = parameters[index+1];
					break;
				}else{
					index+=2;
					continue;
				}
			}
			
			return result;
		}
	}
}