package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	public class Nvl extends BasicFunc
	{
		public function Nvl()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			if(parameters[0]==null){
				return parameters[1];
			}else{
				return parameters[0];
			}
		}
	}
}