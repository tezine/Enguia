import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Shared"
import "qrc:/Components"

Image{
    id: rect
    signal sigClicked();
    anchors.verticalCenter: parent.verticalCenter
    sourceSize.width: parent.height
    sourceSize.height: parent.height
    height: parent.height
    width: parent.height
    property alias text: txt.text

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            //audioEngine.sounds["btnSound"].play();
            rect.sigClicked();
        }
        hoverEnabled: true
        Rectangle {
            anchors.fill: parent
            opacity: mouseArea.pressed ? 1 : 0
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
        anchors.fill: parent;
        font{pointSize:enguia.hugeFontPointSize;bold:true}
        verticalAlignment: Text.AlignVCenter
    }
}

