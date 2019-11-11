import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	signal sigOkClicked();

	contentItem: Rectangle {
		id:rect
		implicitWidth:enguia.width*0.8
		implicitHeight:enguia.height*0.4
		Label{
			id:lbl
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.mediumMargin;
			font.pointSize: enguia.largeFontPointSize
			text:enguia.tr("If you subscribe to news, the place will receive your Enguia profile (name, address, phone...). \nAre you sure you want to subscribe?")
			wrapMode: Text.Wrap
			Component.onCompleted: {
				rect.implicitHeight=lbl.height+enguia.height*0.08+enguia.height*0.02+enguia.mediumMargin
			}
		}
		Rectangle{
			id: rectCancel
			border.color: "lightgray"
			border.width: 1
			anchors{left:parent.left;bottom:parent.bottom;}
			height: enguia.height*0.08
			width: (parent.width/2)
			Label{
				text:enguia.tr("Cancel")
				anchors.fill: parent
				font.pointSize: enguia.largeFontPointSize
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
			}
			MouseArea{
				anchors.fill: parent
				onClicked: close();
			}
		}
		Rectangle{
			id: rectAccept
			border.color: "lightgray"
			border.width: 1
			anchors{left:rectCancel.right;bottom:parent.bottom;}
			height: enguia.height*0.08
			width: (parent.width/2)
			Label{
				text:enguia.tr("Yes")
				anchors.fill: parent
				font.pointSize: enguia.largeFontPointSize
				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
			}
			MouseArea{
				anchors.fill: parent
				onClicked: { sigOkClicked();close();}
			}
		}
	}
}

