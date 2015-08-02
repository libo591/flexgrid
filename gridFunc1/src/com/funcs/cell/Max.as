package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	public class Max extends BasicFunc
	{
		public function Max()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:Array = parameters[0] as Array;
			var count:int = arg0.length;
			var max:Number = 0;
			for(var i:int=0;i<count;i++){
				max = Math.max(max,arg0[i]);
			}
			return max;
		}
	}
}