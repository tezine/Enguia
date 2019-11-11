import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0


Component {
    id: androidTableViewStyle
    TableViewStyle {
        textColor: "black"
        rowDelegate:Rectangle{
            implicitHeight: enguia.height*0.2
        }
        /*itemDelegate:Rectangle{
            implicitHeight: enguia.height*0.1
            Label{
                anchors.fill:parent
            }
        }*/
    }
}
