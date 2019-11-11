import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

VMDlgBase{
	title: enguia.tr("Price range");
    //buttonTexts: [ qsTr("Cancel")]
   // onButtonClicked: reject();
   // onClickedOutside: reject();
    signal sigPriceSelected(int id, string name)

	VMListForDlg{
        id: list
        anchors{top:titleBar.bottom;bottom:parent.bottom;}
        width: parent.width
        onListItemClicked: {
            sigIconSelected( name, image);
            forceClose();
        }
    }
    Component.onCompleted:{
        list.append("Free", PriceRange.Free);
        list.append("Up to 10", PriceRange.UpTo10);
        list.append("Up to 20",PriceRange.UpTo20);
        list.append("Up to 30",PriceRange.UpTo30);
        list.append("Up to 40",PriceRange.UpTo40);
        list.append("Up to 50",PriceRange.UpTo50);
    }
}
