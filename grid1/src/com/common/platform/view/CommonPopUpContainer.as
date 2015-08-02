package com.common.platform.view
{
	
	
	public class CommonPopUpContainer extends CommonPopUpContainerUI
	{
		public function CommonPopUpContainer()
		{
			//this.addEventListener(CloseEvent.CLOSE,closeNow);
		}
		
		
		/*protected function closeNow(event:CloseEvent):void
		{
			var elecount:int = this.numElements;
			for(var i:int=0;i<elecount;i++){
				this.getElementAt(i).dispatchEvent(new CloseEvent(CloseEvent.CLOSE));	
			}
			PopUpManager.removePopUp(this);
		}*/
		
		override public function set width(value:Number):void{
			super.width = value;
			this.header.width = value;
			this.closeBtn.x = value - 35;
			this.dragArea = "0,0,"+value+",26";
			this.title.width = value/2;
			this.content.width = value;
		}
		
		override public function set height(value:Number):void{
			super.height = value;
			this.header.height = value;
			this.content.height = value-26;
		}
	}
}