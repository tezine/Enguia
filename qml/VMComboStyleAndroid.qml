import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Component {
    id: androidBtnStyle
    ComboBoxStyle {
        background: Rectangle {
            id: rectCategory
            //width: control.width
            //height: control.height
            implicitHeight: enguia.height*0.06
            implicitWidth: enguia.width*0.3
			color:enguia.buttonNormalColor
        }
        label: Text {
            anchors{verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter;}
            //anchors.right: background.right
            font.pointSize: enguia.hugeFontPointSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: control.currentText
        }
    }
}

