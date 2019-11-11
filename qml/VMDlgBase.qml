import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0

Rectangle {
    id: dlgBase
    //	anchors{left:parent.left; leftMargin: enguia.mediumMargin; right:parent.right; rightMargin: enguia.mediumMargin;top:parent.top;topMargin:enguia.mediumMargin; bottom:parent.bottom;bottomMargin:enguia.mediumMargin}
    //dlgBase.width= enguia.width - 20;
    //dlgBase.height= enguia.height - 20;
    width:340;
    height:620;
    property alias title: titlebar.title
    property alias titleBar:titlebar
    property alias saveVisible: titlebar.saveVisible
    color: "white"
    border.width: 1
    opacity: 0//todo mudar para 0
    visible: opacity > 0
    signal sigBtnSaveClicked();

    Behavior on opacity {
        NumberAnimation { duration: 400 }
    }

	VMDlgTitleBar{
        id: titlebar
        anchors{top:parent.top}
        width: parent.width;
		title: enguia.tr("Title");
    }

    function forceClose() {
        if(dlgBase.opacity == 0)return; //already closed
        dlgBase.opacity = 0;
    }
    function popup() {
        //page.opened();
        dlgBase.opacity = 1;
    }
}

