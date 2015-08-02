/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class CalculatorUI extends View {
		public var dispArea:TextArea;
		public var textInput:TextInput;
		public var helpLabel:Label;
		public var confirmLabel:Label;
		protected var uiXML:XML =
			<View>
			  <Box x="0" y="0" width="500" height="349">
			    <TextArea skin="png.comp.textarea" x="0" y="0" width="492" height="300" var="dispArea" editable="true" align="right" multiline="true" wordWrap="true" selectable="true" scrollBarSkin="png.comp.vscroll"/>
			    <TextInput skin="png.comp.textinput" x="0" y="310" width="292" height="30" var="textInput" align="left"/>
			    <Label text="帮助" x="312" y="311" width="45" height="30" align="center" var="helpLabel"/>
			    <Label text="设置" x="362" y="311" height="30" width="45" align="center" var="confirmLabel"/>
			  </Box>
			</View>;
		public function CalculatorUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}