import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Rectangle{
	id: rect
	signal sigClicked();
	height: enguia.height*0.04
	width: height+ txt.width+(txt.width*0.3)
	property alias text: txt.text
	property alias textColor: txt.color
	property alias source: img.source
	color: "transparent"

	MouseArea{
		id: mouse
		anchors.fill: parent
		onClicked: sigClicked();
		hoverEnabled: true
		Rectangle {
			id: borderRect
			anchors.fill: parent
			opacity: mouse.pressed ? 1 : 0
			Behavior on opacity { NumberAnimation{ duration: 100 }}
			gradient: Gradient {
				GradientStop { position: 0 ; color: "#22000000" }
				GradientStop { position: 0.2 ; color: "#11000000" }
			}
			border.color: "darkgray"
			antialiasing: true
			radius: 4
		}
	}
	Label{
		id: txt
		anchors{right:img.left; verticalCenter: parent.verticalCenter}
		text:"ola"
		color:"white"
		horizontalAlignment: Text.AlignRight;
		font{pointSize: enguia.largeFontPointSize; bold:true}
	}
	Image {
		id: img
		anchors{right:parent.right; verticalCenter: parent.verticalCenter}
		source: "qrc:///back.png"
		width: rect.height*0.9
		height: rect.height*0.9
		sourceSize.width: width
		sourceSize.height: height
	}
}

