package com.grid.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.ObjectUtil;

	public class CloneUtil
	{
		public function CloneUtil()
		{
		}
		
		/** 
		 *	克隆对象
		 *	能保留对象类型，但是对象中如果包括其他对象，则子对象为浅clone 
		 */
		public static function cloneObject(object:Object,newObject:*=null):Object{
			var qClassName:String = getQualifiedClassName(object);
			var objectType:Class = getDefinitionByName(qClassName) as Class;
			var tempObject:* =  new objectType;
			var objInfo:Object = ObjectUtil.getClassInfo(object); 
			var fieldName:Array = objInfo["properties"] as Array; 
			for each(var pn:String in fieldName){
				tempObject[pn] = object[pn];
			}
			return tempObject;
		}
	}
}