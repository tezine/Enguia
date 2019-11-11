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

Rectangle {
    id: tabContactsList
    anchors.fill: parent
    property alias lblNoData: labelNoData
    property alias listContacts: contactList

	VMContactsList {
        id: contactList
        anchors.fill: parent
        onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Contacts/VContactsDetail.qml"),destroyOnPop:true,properties:{contactID:selectedContactID, userID:selectedUserID, userName:selectedUserName}})
    }
    Label {
        id: labelNoData
		text: enguia.tr("No contacts yet")
        color: "blue"
        font {pointSize: enguia.largeFontPointSize }
        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
        visible: false
    }
}
