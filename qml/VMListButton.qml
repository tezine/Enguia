import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0


Image{
    signal sigClicked();
    anchors.verticalCenter: parent.verticalCenter

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onClicked: sigClicked();
    }
}
