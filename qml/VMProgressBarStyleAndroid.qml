import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0


Component {
    id: touchStyle
    ProgressBarStyle {
        panel: Rectangle {
            implicitHeight: enguia.height*0.02
            implicitWidth: enguia.width*0.5
            color: "#444"
            opacity: 0.8
            Rectangle {
                antialiasing: true
                radius: 1
                color: "#468bb7"
                height: parent.height
                width: parent.width * control.value / control.maximumValue
            }
        }
    }
}
