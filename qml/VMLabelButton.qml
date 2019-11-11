import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Rectangle{
    signal sigClicked();
    height: parent.height
    width: txt.width+(txt.width*0.3)
    property alias text: txt.text
    property alias textColor: txt.color
	property alias fontPointSize: txt.font.pointSize
	property alias fontBold: txt.font.bold
	property bool borderVisible:false
	property alias elide: txt.elide
    color: "transparent"

    MouseArea{
        id: mouse
        anchors.fill: parent
        onClicked: sigClicked();
        hoverEnabled: true
        Rectangle {
            anchors.fill: parent
			opacity: (borderVisible ||mouse.pressed) ? 1 : 0
			//opacity: mouse.pressed ? 1 : 0
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
        color:"white"
        font{pointSize: enguia.largeFontPointSize; bold:true}
        anchors{verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
    }
}


