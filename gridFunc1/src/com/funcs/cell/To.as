package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	import r1.deval.D;
	
	public class To extends BasicFunc
	{
		public function To()
		{
			super();
		}
		override public function excute(...parameters):Object{
			var arg0:Number = parameters[0];
			var arg1:Number = parameters[1];
			var arg2:Number = parameters[2];
			var arr:Array = [];
			for(var i:Number=arg0;i<=arg1;i+=arg2){
				arr.push(i);
			}
			return arr;
		}
	}
}