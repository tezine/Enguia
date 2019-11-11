import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockFiles"


Rectangle {
	property alias placeholderText: txtField.placeholderText
	signal sigBtnClicked();
	Layout.fillWidth: true
	height: txtField.height

	RowLayout{
		anchors.fill: parent
		VSharedTextField{
			id: txtField
			Layout.fillWidth: true
		}
		VSharedButton{
			id: btnFile1
			text:"..."
			width: parent.width*0.2
			onClicked: sigBtnClicked()
		}
	}
}

