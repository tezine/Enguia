import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0

Component {
    id: androidCheckStyle
    CheckBoxStyle {
        indicator: Rectangle {
            implicitWidth: enguia.height*0.06
            implicitHeight: enguia.height*0.06
            radius: 3
            border.color: control.activeFocus ? "darkblue" : "gray"
            border.width: 1
            Rectangle {
                visible: control.checked
				//color: "#555"
				color: "#0288D1"
                border.color: "#333"
                radius: 1
                anchors.margins: 4
                anchors.fill: parent
            }
        }
        label: Text{
            text: control.text;
            font{pointSize:enguia.largeFontPointSize;}
        }
    }
}


