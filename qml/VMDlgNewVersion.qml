import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

VMDlgBase{
    id: dlgNewVersion
    title: qsTr("New version available")
    //titleIcon: "qrc:/Images/sync.png"
    /*buttonTexts: [ "Open Store","Later"]
    onButtonClicked:{
        if(index===0)accept();
        else reject();
    }*/
    Rectangle{
        anchors{top:titleBar.bottom;bottom:parent.bottom;}
        Label{
            id: lbl
            text: qsTr("There is a new version available")
            color: "white"
            wrapMode: Text.Wrap
        }
    }
}
