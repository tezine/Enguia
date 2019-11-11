import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Rectangle{
	color:"transparent"
	property alias source: back.source
	anchors.verticalCenter: parent.verticalCenter
	width: parent.height
	height: parent.height
	signal sigBtnClicked();

	Image {
		id: back
		source: "qrc:///back.png"
		anchors.fill: parent
		sourceSize.height: parent.height
		sourceSize.width: parent.height

		MouseArea {
			id: mouse
			hoverEnabled: true
			anchors.fill: parent
			onClicked: {
				//audioEngine.sounds["btnSound"].play();
				sigBtnClicked();
			}
			Rectangle {
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
	}

}
