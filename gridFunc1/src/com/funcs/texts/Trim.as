package com.funcs.texts
{
	import com.adobe.utils.StringUtil;
	import com.funcs.BasicFunc;
	
	public class Trim extends BasicFunc
	{
		public function Trim()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return StringUtil.trim(parameters[0]);
		}
	}
}