/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class ColHeaderFuncConfigUI extends View {
		public var confirmButton:Button;
		public var searchInput:TextInput;
		public var dataList:List;
		protected var uiXML:XML =
			<View>
			  <Tab labels="过滤,预警" skin="png.comp.tab" x="1" y="2" selectedIndex="0" height="25"/>
			  <Button label="确定" skin="png.comp.button" x="410" y="325" var="confirmButton" height="30"/>
			  <Box x="5" y="30">
			    <CheckBox label="空值均不显示" skin="png.comp.checkbox" x="282" y="9"/>
			    <TextInput skin="png.comp.textinput" width="220" height="30" var="searchInput"/>
			    <List y="54" width="220" height="240" var="dataList" repeatX="1" repeatY="8" spaceY="0" spaceX="0">
			      <VScrollBar skin="png.comp.vscroll" x="200" height="240" name="scrollBar"/>
			      <Box name="render">
			        <CheckBox x="5" y="0" skin="png.comp.checkbox" height="30" name="check"/>
			        <Label text="label" x="30" y="0" width="160" height="30" name="label"/>
			      </Box>
			    </List>
			  </Box>
			</View>;
		public function ColHeaderFuncConfigUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}