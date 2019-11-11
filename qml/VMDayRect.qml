import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"

Rectangle {	
	id:rect
	border.color: "lightgray"
	border.width: 1
	property bool selected:false
	property date dt:new Date()
	color:"white"

	Label{
		font.pointSize: enguia.tinyFontPointSize
		anchors.fill: parent
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		wrapMode: Text.Wrap
		text: Qt.formatDate(dt,Qt.SystemLocaleLongDate)
	}
	MouseArea{
		anchors.fill: parent
		onClicked: {
			if(selected)rect.color="white"
			else rect.color="#66BB6A"
			rect.selected=(!selected)
		}
	}
}

