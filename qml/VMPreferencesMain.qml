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
	property variant mSqlite

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Preferences")
		btnBackVisible:true
		titleLayout.anchors.right: pageTitle.right
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	VMListMenu2{
		id: menuList
		anchors{top: pageTitle.bottom;left: parent.left;right: parent.right;bottom:rowLayout.top}
		onListItemClicked:mainStack.push({item:Qt.resolvedUrl("qrc:///"+value),destroyOnPop:true,immediate:true});
	}
	RowLayout{
		id: rowLayout
		anchors{left:parent.left;leftMargin: enguia.mediumMargin; bottom:parent.bottom;bottomMargin: enguia.mediumMargin; }
		Image{
			source:'qrc:///Images/disconnect.png'
			width: enguia.height*0.06
			height: enguia.height*0.06
			sourceSize.width: enguia.height*0.06
			sourceSize.height:enguia.height*0.06
		}
		Label{
			text: enguia.tr("Logout")
			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			font{pointSize: enguia.largeFontPointSize;bold:true}
		}
		MouseArea{
			anchors.fill: parent
			onClicked: {
				enguia.setAutoLogin(mSUsers.getDefaultLogin(),"",false);
				mainWindow.popToLogin();
			}
		}
	}
	Component.onCompleted:{
		menuList.clear()
		menuList.append(enguia.tr('Help'),"Preferences/VMPreferencesHelp.qml",0,'qrc:///Images/help.png')
		menuList.append(enguia.tr('Profile'),"Preferences/VMPreferencesProfile.qml",0,'qrc:///Images/profile.png')
		menuList.append(enguia.tr('Notifications'),"Preferences/VMPreferencesNotifications.qml",0,'qrc:///Images/push.png')
		menuList.append(enguia.tr('My places'),"Tourism/VMTourismMain.qml" ,0,'qrc:///Images/picture.png')
		menuList.append(enguia.tr('Contact us'),"Preferences/VMPreferencesContact.qml",0,'qrc:///SharedImages/msg.png')
		menuList.append(enguia.tr('About'),"Preferences/VMPreferencesAbout.qml" ,0,'qrc:///Images/about.png')
	}
}

