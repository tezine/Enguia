import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"

Dialog {
	id: dlgBase
	visible:false

	contentItem: Rectangle {
		id: dlgExit
		implicitWidth: enguia.width*0.8
		implicitHeight: enguia.height*0.27
		//anchors{verticalCenter: parent.verticalCenter; horizontalCenter:parent.horizontalCenter;}
		color: "white"
		border.width: 1
		border.color: "black"
		opacity: 0
		radius: 10
		visible: opacity > 0
		Behavior on opacity {
			NumberAnimation { duration: 600 }
		}

		Text{
			id: txtTitle
			anchors{top:parent.top; topMargin:enguia.smallMargin; left:parent.left; leftMargin: enguia.smallMargin;}
			text:enguia.tr("Exit Enguia")
			font{pointSize: enguia.hugeFontPointSize}
			color: "#33b5e5"
			height: parent.height*0.06
		}
		Rectangle{
			id: rectLine
			anchors{top:txtTitle.bottom; topMargin: enguia.mediumMargin; left:parent.left; right:parent.right }
			height: enguia.height*0.003
			color: "#0099cc"
		}
		Text{
			id: txtContent
			anchors{top:rectLine.bottom ;horizontalCenter:parent.horizontalCenter ;bottom:rectGrey.top}
			text: enguia.tr("Are you sure you want to exit?");
			height: parent.height*0.09
			verticalAlignment: Text.AlignVCenter
			font{pointSize: enguia.largeFontPointSize;}
		}
		Rectangle{
			id: rectGrey
			anchors{topMargin:enguia.largeMargin; left:parent.left; right:parent.right; bottom:txtNo.top}
			height: parent.height*0.003
			color: "#bababa"
		}
		Text{
			id: txtNo
			text: enguia.tr("No");
			anchors{left:parent.left;bottom:parent.bottom}
			width: parent.width/2
			height: enguia.height*0.08
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			font{pointSize: enguia.mediumFontPointSize;}
			MouseArea{
				anchors.fill: parent
				onClicked: close();
			}
		}
		Rectangle{
			id: rectVertGrey
			color:"#bababa"
			anchors{left:txtNo.right; top:rectGrey.bottom;bottom:parent.bottom}
			width: parent.height*0.003
		}
		Text{
			id: txtYes
			text: enguia.tr("Yes");
			anchors{right:parent.right; bottom:parent.bottom}
			width: parent.width/2
			height: enguia.height*0.08
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			font{pointSize: enguia.mediumFontPointSize;}
			MouseArea{
				anchors.fill: parent
				onClicked: Qt.quit();
			}
		}
		RowLayout{
			id: rowLayout
			anchors{top: rectGrey.bottom; left:parent.left; right: parent.right; bottom:parent.bottom}
		}
	}
	function forceClose() {
		dlgExit.visible=false;
		if(dlgExit.opacity === 0)return; //already closed
		dlgExit.opacity = 0;
	}
	function popup() {
		visible=true;
		this.height=enguia.height*0.27
		this.width=enguia.width*0.8
		dlgExit.opacity = 1;
	}
}
