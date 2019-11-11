import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0


Component {
    id: indicatorStyle
    BusyIndicatorStyle{
        indicator: Image {
            visible: control.running
            anchors{right:parent.right}
            //fillMode: Image.PreserveAspectFit
            //height: mCommon.height*0.08
            //width: mCommon.height*0.08
            source: "qrc:/Images/busy.png"
            NumberAnimation on rotation {
                running: control.running
                loops: Animation.Infinite
                duration: 2000
                from: 0 ; to: 360
            }
        }
    }
}
