import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockGPS"

Rectangle {
	property int blockID:0

	VMPageTitle{
        id:pageTitle
		title: enguia.tr("Positioning sending")
        btnBackVisible:true
		onSigBtnBackClicked:  mainWindow.popToMenu();
        btnDoneVisible: false
    }
    Image{
        id: mapImg
        source:"qrc:///SharedImages/map.png"
        anchors{top:pageTitle.bottom;}
        width:parent.width
        height:parent.height*0.3
        sourceSize.width: parent.width
        sourceSize.height: parent.height*0.3
    }
	VMBlockGPSList{
        id: listView
        anchors{left:parent.left;right:parent.right;top:mapImg.bottom; bottom:parent.bottom;}
        onListItemClicked: dlg.open()
    }
	VMBlockGPSDlg{
        id: dlg
        onSigNumberSelected: {
            lblResult.text="Pedido confirmado"
            lblOrderNumber.text="Alameda Casa Blanca "+number.toString();
            rectTotal.visible=true;
            listView.visible=false
        }
    }
    Rectangle{
        id: rectTotal
        visible: false
        color:"#009688"
        anchors{left:parent.left;right:parent.right;top:mapImg.bottom; bottom:parent.bottom;}
        ColumnLayout{
            anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter;}
            Label{
                id: lblResult
                color:"white"
                font{pointSize: enguia.largeFontPointSize;bold:true;}
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            Label{
                id: lblOrderNumber
                color:"white"
                font{pointSize: enguia.largeFontPointSize;bold:true;}
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    Component.onCompleted: {
        listView.append(1,"Avenida Paulista")
        listView.append(2,"Rua Itapeva")
        listView.append(3,"Alameda Casa Blanca")
        listView.append(4,"Alameda Santos")
        listView.append(5,"Avenida 9 de Julho")
        listView.append(6,"Rua Carlos do Pinhal")
    }
}

