package com.funcs.datetime
{
	import com.boboeye.basic.date.DateParser;
	
	import mx.formatters.DateFormatter;

	public class DateUtil
	{
		public function DateUtil()
		{
		}
		public static function date2Str(date:Date,format:String="YYYY-MM-DD HH:NN:SS"):String{
			var dformat:DateFormatter = new DateFormatter();
			dformat.formatString = format;
			return dformat.format(date);
		}
		public static function str2Date(str:Object):Date{
			var result:Date = null;
			if(str!=null){
				if(str is Date){
					result = str as Date;
				}else if(str is String){
					result = DateParser.parse2Date(str as String);
				}else if(str is Number){
					result = new Date();
					result.setTime(str as Number);
				}
			}
			return result;
		}
	}
}