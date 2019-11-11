import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Events"
import "qrc:/Components"
import "qrc:/Contacts"
import "qrc:/Favorites"
import "qrc:/Messages"
import "qrc:/News"
import "qrc:/Preferences"
import "qrc:/Qualifications"
import "qrc:/Search"
import "qrc:/Shared"
import "qrc:/Styles"

VMDlgBase{
	title:enguia.tr("Contacts");
    //buttonTexts: [ "Cancel"]
    signal sigContactSelected(int id, string name)
    //onButtonClicked: reject();
   //onClickedOutside: reject();

	VMListForDlg{
        id: list
        anchors{top:titleBar.bottom;bottom:parent.bottom;}
        width: parent.width
        onListItemClicked: {
            sigIconSelected( name, image);
            forceClose();
        }
    }

/* Connections{
        id: contactsConnection
        ignoreUnknownSignals: true
        onReceivedContacts:{
            busy.visible=false;
            for(var i=0;i<list.length;i++){
                if(list[i].name.length<3)dlgModel.append({"modelData":list[i].login,"tableID":list[i].userID})
                else dlgModel.append({"modelData":list[i].name,"tableID":list[i].userID})
            }
        }
    }
    function popup(userID){
        busy.visible=true;
        mContacts=mData.mContacts
        contactsConnection.target=mContacts;
        currentContactID=userID
        dlgModel.clear();
        mContacts.getContacts();
        open();
    }*/
}
