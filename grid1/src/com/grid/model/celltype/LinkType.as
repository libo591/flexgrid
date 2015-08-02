package com.grid.model.celltype
{
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import morn.core.components.LinkButton;
	import morn.core.handlers.Handler;
	
	
	public class LinkType extends NONEType
	{
		private var _linkButton:LinkButton;
		public function LinkType()
		{
		}
		
		override public function display():void
		{
			if(_linkButton==null){
				_linkButton = new LinkButton();
				_linkButton.clickHandler = new Handler(clickNow);
				p.addChild(_linkButton);
			}
			_linkButton.width = cw;
			_linkButton.height = ch;
			_linkButton.label = cell.extendProp.text;
		}
		
		private function clickNow(content:*=null):void
		{
			navigateToURL(
				new URLRequest(cell.extendProp.typeData["href"]),"_blank");
		}
	}
}