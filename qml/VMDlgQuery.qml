import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

VMDlgBase{
    id: dlgQuery
    implicitHeight: 240
    //acceptButtonText: qsTr("Ok")
    //rejectButtonText: qsTr("Cancel")
    property int identifier: 0
    signal sigConfirmed(string txt, int identifierID)
    //onAccepted: sigConfirmed(txtDetail.text,identifier)
    //onClickedOutside: reject();

    Label{
        id: txtDetail
        anchors{top:titleBar.bottom;bottom:parent.bottom;}
        color: "white"
        wrapMode: Text.Wrap
    }
    function popup(title, txt, icon,identifierID){
        if(identifierID) identifier=identifierID
        txtDetail.text=""
        titleText=title
        if(icon)titleIcon=icon
        else titleIcon="qrc:/Images/question.png"
        if(txt)txtDetail.text=txt;
        //height=txtDetail.height+100;        //nao funciona
        open()
    }
}
