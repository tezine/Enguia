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
    anchors.fill: parent
    property alias lblNoData: lblNoData
    property alias menuList: menuList

	VMListGroupedMenu{
        id: menuList
        anchors.fill: parent
        //onListItemClicked: mData.push(MData.PageTypeMessagesExchanged, {otherUserID:id, otherUserName:name});
    }
    Label{
        id: lblNoData
        anchors{horizontalCenter: parent.horizontalCenter;verticalCenter: parent.verticalCenter}
        font{pointSize: enguia.largeFontPointSize}
		text: enguia.tr("No messages available")
        color: "blue"
        visible: false
    }
    Component.onCompleted:{
        if(enguia.isPreview()){
            menuList.append('Lulets',1);
        }
    }
}

