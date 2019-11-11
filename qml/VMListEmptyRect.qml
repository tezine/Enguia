import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Styles"

Rectangle{
	id: rect
	height: parent.height
	color:"#EAEAEA"
	property alias title: lbl.text
	Label{
		id: lbl
		color: "#484B4E"
		font.pointSize: enguia.largeFontPointSize
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
	}
}

