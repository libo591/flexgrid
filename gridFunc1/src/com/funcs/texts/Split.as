package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Split extends BasicFunc
	{
		public function Split()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return (parameters[0] as String).split(parameters[1]);
		}
	}
}