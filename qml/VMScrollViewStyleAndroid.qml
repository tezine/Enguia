import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0


Component {
    id: touchStyle
    ScrollViewStyle {
        transientScrollBars: true
        handle: Item {
            implicitWidth: 14
            implicitHeight: 26
            Rectangle {
                color: "#424246"
                anchors.fill: parent
                anchors.topMargin: 6
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.bottomMargin: 6
            }
        }
        scrollBarBackground: Item {
            implicitWidth: 14
            implicitHeight: 26
        }
    }
}
