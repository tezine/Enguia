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

Rectangle{
    property int secondColumnWidth: enguia.screenWidth*0.5
    signal sigBtnSaveClicked(string defaultAuthor, bool autoLogin, int listCount);

    VMPageTitle{
        id: pageTitle
        title: qsTr("App Config")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
        VMToolButton{
            id: btnSave
            anchors{right:parent.right}
            source: "qrc:///Images/save.png"
            onSigClicked: sigBtnSaveClicked(txtAuthor.text, switchAutoLogin.checked, parseInt(txtListCount.text));
        }
    }
    Grid{
        id: grid
        columns: 2
        spacing: 5
        anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom: parent.bottom; topMargin: enguia.mediumMargin; leftMargin: enguia.mediumMargin; rightMargin: enguia.mediumMargin}
        Text{
            id: lblAuthor
            font{pointSize: enguia.mediumFontPointSize}
            text: qsTr("Default author")
        }
        TextField{
            id: txtAuthor
            style: textFieldStyleAndroid
            width: secondColumnWidth
            maximumLength: 50
        }
        Text{
            id: lblListCount
            font{pointSize: enguia.mediumFontPointSize}
            text: qsTr("List count")
        }
        TextField{
            id: txtListCount
            style: textFieldStyleAndroid
            width: secondColumnWidth
            validator: IntValidator{}
            inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
            maximumLength: 3
        }
        /*ja estava comentado em c++Text{
            id: lblPeriod
            font{family: Defines.fontFamily;pointSize: Defines.mediumFontPointSize}
            text: qsTr("Agenda period")
        }
        WButton{
            id: btnPeriod
            inverted: true
            text: "..."
            onClicked: dlgAgendaPeriod.open()
            width:secondColumnWidth
        }
        Text{
            id: lblSorting
            font{family: Defines.fontFamily;pointSize: Defines.mediumFontPointSize}
            text: qsTr("Agenda sorting")
        }
        WButton{
            id: btnSorting
            inverted: true
            text: "..."
            onClicked: dlgAgendaSorting.open()
            width: secondColumnWidth
        }
        Text{
            id: lblSendNow
            font{family: Defines.fontFamily;pointSize: Defines.largeFontPointSize}
            text: qsTr("Send fun on time")
        }
        Switch{
            id: switchSend
        }*/
        Text{
            id: lblAutoLogin
            font{pointSize: enguia.mediumFontPointSize}
            text: qsTr("Auto-login")
        }
        Switch{
            id: switchAutoLogin
            style: switchStyleAndroid
        }
    }
    /*   TEnguiaAppConfig{
        id: tEnguiaAppConfig
    }*/
    /*ja estava comentado em c++DlgAgendaPeriod{
        id: dlgAgendaPeriod
        onSelected: {
            btnPeriod.text=name;
            btnPeriod.tableID=id;
        }
    }
    DlgAgendaSorting{
        id: dlgAgendaSorting
        onSelected: {
            btnSorting.text=name
            btnSorting.tableID=id;
        }
    }*/
	VDlgError{
        id: dlgError
    }
    Component.onCompleted:{
		mSVC.metaInvoke(MSDefines.SUserPreferences,"GetUserAppConfig",function(e){
			txtAuthor.text=e.defaultAuthor
			switchAutoLogin.checked=e.autoLogin;
			txtListCount.text=e.listCount.toString();
		},mShared.userID);
    }
}
