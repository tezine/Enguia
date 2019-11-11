import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0


Component{
    id: androidSwitchStyle
    SwitchStyle {
        groove: Rectangle {
            implicitHeight: enguia.height/10
            implicitWidth: enguia.width/3
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                width: parent.width/2 - 2
                height: enguia.screenHeight*0.06
                anchors.margins: 2
                color: control.checked ? "#468bb7" : "#222"
                Behavior on color {ColorAnimation {}}
                Text {
                    font.pointSize: enguia.largeFontPointSize
                    color: "white"
                    anchors.centerIn: parent
                    text: "ON"
                }
            }
            Item {
                width: parent.width/2
                height: parent.height
                anchors.right: parent.right
                Text {
                    font.pointSize: enguia.largeFontPointSize
                    color: "white"
                    anchors.centerIn: parent
                    text: "OFF"
                }
            }
            color: "#222"
            border.color: "#444"
            border.width: 2
        }
        handle: Rectangle {
            width: parent.parent.width/2
            height: control.height
            color: "#444"
            border.color: "#555"
            border.width: 2
        }
    }
}
