import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0

Component{
    CalendarStyle {
        dayDelegate: Item {
            readonly property color sameMonthDateTextColor: "#444"
            readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : "gray"
            readonly property color selectedDateTextColor: "white"
            readonly property color differentMonthDateTextColor: "#bbb"
            readonly property color invalidDatecolor: "#dddddd"

            Rectangle {
                anchors.fill: parent
                border.color: "transparent"
                color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                anchors.margins: styleData.selected ? -1 : 0
            }

            Image {
                visible: true;//eventModel.eventsForDate(styleData.date).length > 0
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: -1
                width: enguia.width*0.05
                height: width
               // source: "qrc:///eventindicator.png"
            }

            Label {
                id: dayDelegateText
                text: styleData.date.getDate()
                font.pointSize: enguia.smallFontPointSize
                anchors.centerIn: parent
                color: {
                    var color = invalidDatecolor;
                    if (styleData.valid) {
                        // Date is within the valid range.
                        color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                        if (styleData.selected) {
                            color = selectedDateTextColor;
                        }
                    }
                    color;
                }
            }
        }
    }
}

