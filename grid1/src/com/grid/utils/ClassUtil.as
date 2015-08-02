package com.grid.utils
{
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;

	public class ClassUtil
	{
		public function ClassUtil()  
		{  
		}  
		
		/** 
		 * 获取class的object package::className 
		 * */  
		public static function referenceClass(appDomain:ApplicationDomain,className:String):Object{  
			var ClassReference:Class = appDomain.getDefinition(className) as Class;  
			var instance:Object = new ClassReference();  
			return instance;  
		}  
		
		/** 
		 * 获取class的value 
		 * */  
		public static function referenceClassParameters(appDomain:ApplicationDomain,className:String,parameters:String):*{  
			return referenceClass(appDomain,className)[parameters];  
		}  
		
		/** 
		 * 执行方法 
		 * */  
		public static function referenceClassFunction(appDomain:ApplicationDomain,className:String,functionName:String,params:Array):*{  
			var instance:Object =referenceClass(appDomain,className);  
			return instance[functionName].apply(instance,params);
		}  
		
		/** 
		 * 执行方法 
		 * */  
		public static function referenceObjectFunction(instance:Object,functionName:String,params:Array):*{  
			return instance[functionName].apply(instance,params);   
		}  
		
		/** 
		 * 获取class name全名 
		 * */  
		public static function getClassFullName(value:Object):String{  
			return getQualifiedClassName(value);  
		}  
		
		
		/** 
		 * 获取class name 
		 * */  
		public static function getClassName(value:Object):String{  
			if(getQualifiedClassName(value).indexOf("::")!=-1)  
				return getQualifiedClassName(value).substring(getQualifiedClassName(value).indexOf("::")+2);  
			else  
				return getClassFullName(value);  
		}  
		
		/** 
		 * 获取所有的function列表 
		 * ps:只能获取去方法的名称，不可以获取protected and private 
		 * */  
		public static function getAllFunctionFromObject(instance:Object):ArrayCollection{  
			var functionArrayCollection:ArrayCollection=new ArrayCollection;  
			var method:XMLList=describeType(instance).method;  
			var num:int=method.length();  
			for(var i:int=0;i<num;i++){  
				var xml:XML=method[i];  
				functionArrayCollection.addItem(xml.@name);  
				xml=null;  
			}  
			return functionArrayCollection;  
		} 
	}
}