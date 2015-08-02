package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	public class Avg extends BasicFunc
	{
		public function Avg()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:Array = parameters[0] as Array;
			var arg1:Boolean = false;
			if(parameters.length>=2){
				arg1 = parameters[1] as Boolean;
			}
			var count:int = arg0.length;
			var avgcount:int = 0;
			var sum:Number = 0;
			for(var i:int=0;i<count;i++){
				if(arg0[i]==null){
					if(arg1){
						avgcount++;
					}
				}else{
					sum +=arg0[i];
					avgcount++;
				}
			}
			return sum/avgcount;
		}
	}
}