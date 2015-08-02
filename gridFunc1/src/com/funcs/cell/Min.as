package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	public class Min extends BasicFunc
	{
		public function Min()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:Array = parameters[0] as Array;
			var count:int = arg0.length;
			var min:Number = 0;
			for(var i:int=0;i<count;i++){
				min = Math.min(min,arg0[i]);
			}
			return min;
		}
	}
}