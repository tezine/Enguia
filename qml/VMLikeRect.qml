import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Rectangle {
    implicitWidth: 40
    implicitHeight: 20
    color: "transparent"
    border{width: 1}
    property alias value:lbl.text
    signal sigItemClicked()

    Image{
        id: img
        anchors{left:parent.left;leftMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
        source:"qrc:///Images/like.png"
        width: 16
        height: 16
    }
    Label{
        id: lbl
        anchors{left: img.right; leftMargin: enguia.smallMargin; verticalCenter: parent.verticalCenter}
        font{pointSize: enguia.tinyFontPointSize;bold: true}
        color: "darkorange"
    }
    MouseArea{
        anchors.fill: parent
        onClicked: sigItemClicked()
    }
}
