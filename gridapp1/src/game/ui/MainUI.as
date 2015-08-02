/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.Box;
	import morn.core.components.Button;
	import morn.core.components.ComboBox;
	import morn.core.components.TextInput;
	import morn.core.components.View;
	public class MainUI extends View {
		public var btn2:Button;
		public var btn3:Button;
		public var btn4:Button;
		public var funcName:TextInput;
		public var box:Box;
		public var styles:ComboBox;
		protected var uiXML:XML =
			<View>
			  <Button label="异步1" skin="png.comp.button" x="7" y="4"/>
			  <Button label="异步2" skin="png.comp.button" x="103" y="4" var="btn2"/>
			  <Button label="新建数据集" skin="png.comp.button" x="199" y="4" var="btn3"/>
			  <Button label="FX" skin="png.comp.button" x="444" y="4" var="btn4"/>
			  <TextInput skin="png.comp.textinput" x="295" y="4" var="funcName"/>
			  <Label text="切换样式:" x="9" y="33" width="87" height="25" align="center"/>
			  <ComboBox var="styles" labels="label1,label2" skin="png.comp.combobox" x="122" y="33" width="135" height="23"/>
			  <Label text="下面是表格：" x="9" y="71"/>
			  <Box x="9" y="94" width="982" height="395" var="box"/>
			  <Button label="调试" skin="png.comp.button" x="540" y="5"/>
			</View>;
		public function MainUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}