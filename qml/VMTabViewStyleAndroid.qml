import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0

Component {
    id: touchStyle
    TabViewStyle {
        tabsAlignment: Qt.AlignVCenter
        tabOverlap: 0
        frame: Item { }
        tab: Item {
            implicitWidth: control.width/control.count
            implicitHeight: enguia.height*0.07
            BorderImage {
                anchors.fill: parent
				border.bottom: enguia.tinyMargin
				border.top: enguia.tinyMargin
//				source: "qrc:///Images/tab_standard"
                source: styleData.selected ? "qrc:///Images/tab_selected.png":"qrc:///Images/tab_standard.png"
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    text: styleData.title.toUpperCase()
                    font.pointSize: enguia.mediumFontPointSize
                }
                Rectangle {
                    visible: index > 0
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
					anchors.margins: enguia.smallMargin
					width:1
                    color: "#3a3a3a"
                }
            }
        }
    }
}
