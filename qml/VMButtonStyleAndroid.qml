import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Component {
	id: androidBtnStyle
	ButtonStyle {
		background: Rectangle {
			implicitHeight: enguia.height*0.06
			implicitWidth: enguia.width*0.3
			//color:control.pressed?"#2E7D32": "#4CAF50"
			color:control.pressed?enguia.buttonPressedColor: enguia.buttonNormalColor
		}
		label: Label {
			text: control.text
			color: "white"
			font.pointSize: enguia.largeFontPointSize;
			height: control.height;
			width:control.width;
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			renderType: Text.NativeRendering
			elide: Text.ElideRight
		}
	}
}
