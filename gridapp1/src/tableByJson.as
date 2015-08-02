package
{
	import com.basic.cursor.CursorManager;
	import com.demonsters.debugger.MonsterDebugger;
	import com.grid.model.GridController;
	import com.grid.model.GridEvent;
	import com.grid.model.GridEventDispatcher;
	import com.grid.styles.GridStyleController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import morn.core.handlers.Handler;
	
	public class tableByJson extends Sprite
	{
		private var _jsonFile:String;
		private var _json:String;
		private var cursor:CursorManager;
		private var _main:TableJsonMain;
		public function tableByJson()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,add2Stage);
		}
		
		protected function add2Stage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,add2Stage);
			_jsonFile = stage.loaderInfo.parameters.dataFile;
			ExternalInterface.addCallback("changeStyle",changeStyle);
			MonsterDebugger.initialize(this);
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf"],new Handler(complete));
		}
		
		private function changeStyle(styleName:String):void
		{
			GridStyleController.getInst().loadAndShowStyles(styleName);
		}
		
		private function complete():void
		{
			_main = new TableJsonMain();
			_main.width = stage.stageWidth;
			_main.height = stage.stageHeight;
			addChild(_main);
			var urlloader:URLLoader = new URLLoader();
			urlloader.addEventListener(Event.COMPLETE,fileComplete);
			urlloader.load(new URLRequest(_jsonFile));
		}
		
		protected function fileComplete(event:Event):void
		{
			_main.json = event.target.data;
		}
	}
}