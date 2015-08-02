package com.funcs
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.model.GridEvent;
	import com.grid.utils.ModuleClassLoad;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import morn.core.handlers.Handler;
	
	import r1.deval.D;

	/**
	 * 加载配置文件，注册函数名和类名的对应关系
	 */
	public class FuncsLoader
	{
		private var _funcInfo:Object = {};
		private static var _inst:FuncsLoader = new FuncsLoader();
		public function FuncsLoader()
		{
		}
		public static function getInst():FuncsLoader{
			return _inst;
		}
		public function init():void{
			App.loader.loadAssets(["functions.swf"],new Handler(swfLoaded));
		}
		
		private function swfLoaded():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,loaded);
			urlLoader.load(new URLRequest("functions.xml"));
		}
		
		private function loaded(event:Event):void
		{
			var str:String = event.target.data;
			var root:XML = new XML(str);
			var groups:XMLList = root.group as XMLList;
			for(var gi:int=0;gi<groups.length();gi++){
				var group:XML = groups[gi] as XML;
				var groupObj:Object={};
				var funcs:XMLList = group.func as XMLList;
				for(var i:int=0;i<funcs.length();i++){
					var func:XML = funcs[i] as XML;
					var funcObj:Object = {};
					var funcName:String = func.@name;
					var funcClass:String = func.@clz;
					var funcDesc:String = func.text();
					funcObj["name"] = funcName;
					funcObj["clz"] = funcClass;
					funcObj["desc"] = funcDesc;
					var ifunc:IFunc = App.asset.getAsset(funcClass) as IFunc;//new (this._funcDomain.getDefinition(funcClass) as Class);
					if(ifunc!=null){
						D.importFunction(funcName,ifunc.excute);
						groupObj[funcName] = funcObj;
					}
				}
				this._funcInfo[group.@type] = groupObj;
			}
			var ge:GridEvent = new GridEvent(GridEvent.GRIDEVENT_FUNCTIONLOADED);
			ge.dispatch();
		}

		public function get funcInfo():Object
		{
			return _funcInfo;
		}

		public function set funcInfo(value:Object):void
		{
			_funcInfo = value;
		}

		public function funcGroup(groupType:String):Object{
			return this._funcInfo[groupType];
		}

		public function funcObj(funcName:String):Object{
			var result:Object=null;
			for(var groupName:String in this._funcInfo){
				var g:Object = this._funcInfo[groupName];
				for(var fcn:String in g){
					if(fcn==funcName){
						result = g[fcn];
						break;
					}
				}
			}
			return result;
		}
	}
}