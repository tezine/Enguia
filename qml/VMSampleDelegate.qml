import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Column{
    id: column
    width: parent.width-2
    anchors.horizontalCenter:parent.horizontalCenter
    Rectangle{
        id: rectDescription
        height: enguia.height*0.1
        width: parent.width
        color: "lightgrey"
        Text{
            id: headerDescription
            anchors{left: parent.left;leftMargin: 10;verticalCenter: rectDescription.verticalCenter}
            font{pointSize:enguia.mediumFontPointSize;bold: true}
            text: title
            color: "black"
        }
    }
    Text{
        id: txtDescription
        wrapMode: Text.Wrap
        width: parent.width
        anchors{left: parent.left;leftMargin: 10;top: rectDescription.bottom}
        font{pointSize: enguia.mediumFontPointSize}
        text: description
    }
    Component.onCompleted:{
        //list.height+=column.height
    }
}

