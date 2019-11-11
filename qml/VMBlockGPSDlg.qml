import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockGPS"

Dialog {
    id: dlg
    visible:false
    signal sigNumberSelected(int number);

    contentItem: Rectangle {
        implicitWidth:enguia.width*0.8
        implicitHeight:txtNumber.height+rowLayout.height
        VSharedTextField{
            id: txtNumber
			placeholderText: enguia.tr("Number")+":"
            anchors{left:parent.left;right:parent.right;top:parent.top;}
        }
        RowLayout{
            id: rowLayout
            anchors{left:parent.left;right:parent.right;top:txtNumber.bottom;}
            VSharedButton{
				text:enguia.tr("Cancel")
                style:buttonStyleCancel
                Layout.fillWidth: true;
                onClicked: close();
            }
            VSharedButton{
                text:"Confirmar pedido"
                Layout.fillWidth: true
                onClicked:{
                    sigNumberSelected(txtNumber.text)
                    close();
                }
            }
        }
    }
    Component.onCompleted: {

    }
}
