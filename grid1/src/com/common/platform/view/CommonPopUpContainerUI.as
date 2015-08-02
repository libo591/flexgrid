package com.common.platform.view
{
	import morn.core.components.Box;
	import morn.core.components.Button;
	import morn.core.components.Dialog;
	import morn.core.components.Image;
	import morn.core.components.Label;
	
	public class CommonPopUpContainerUI extends Dialog
	{
		public var header:Image;
		public var closeBtn:Button;
		public var title:Label;
		public var content:Box;
		protected var uiXML:XML =
			<Dialog>
			  <Image var="header" url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="310"/>
			  <Button var="closeBtn" skin="png.comp.btn_close" x="265" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="261" height="26" name="drag"/>
			  <Label var="title" url="png.comp.label" x="20" y="3" width="261" height="26" />
			  <Box var="content" x="0" y="26" />
			</Dialog>;
		public function CommonPopUpContainerUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}