import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Component {
    id: androidTextFieldStyle
    TextFieldStyle {
        textColor: enguia.fontColor
        font.pointSize: enguia.largeFontPointSize
        background: Rectangle {
            radius: 2
            implicitWidth: enguia.width*0.4
            implicitHeight: enguia.screenHeight*0.06
            border.color: "#333"
            border.width: 1
			color: control.readOnly?"#BDBDBD":"white"
        }
    }
}

