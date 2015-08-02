package com.funcs.texts
{
	import com.funcs.IFunc;
	
	/**
	 * 在源字符串中查找子串的位置
	 */
	public class FindFunc implements IFunc
	{
		public function FindFunc()
		{
		}
		
		public function excute(...parameters):Object
		{
			var strSrc:String = parameters[0] as String;
			var strSub:String = parameters[1] as String;
			var start:int = 0;
			if(parameters.length>=3){
				start = int(parameters[2]);
			}
			return strSrc.indexOf(strSub,start);
		}
	}
}