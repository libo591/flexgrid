package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Fact extends BasicFunc
	{
		public function Fact()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var result:int = 1;
			var start:int = parameters[0];
			for(var i:int=start;i>=1;i--){
				result *=i;
			}
			return result;
		}
	}
}