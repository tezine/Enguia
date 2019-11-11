import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/MyPortal"
import "qrc:/"

Rectangle {
	property int clientID:0
	property int selectedClientUserID:0//received from GetUserClientDetail below
	property string fontColor:"#484B4E"
	color: enguia.backColor

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Client detail")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
//			VMToolButton{
//				id: toolAdd
//				Layout.fillHeight: true
//				Layout.preferredWidth: height
//				source: "qrc:///Images/add.png"
//				onSigClicked: btnAddClicked();
//				visible: true
//			}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	Rectangle{
		id: rect
		anchors{top:pageTitle.bottom; left:parent.left;right:parent.right;}
		height: columnLayout.height+2*enguia.mediumMargin
		color:"transparent"
		ColumnLayout{
			id: columnLayout
			anchors{verticalCenter: parent.verticalCenter;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right; left: parent.left}
			VSharedLabel{
				id: lblClientName
				font{pointSize: enguia.hugeFontPointSize; bold: true}
				Layout.fillWidth: true;
				color: fontColor
			}
			VSharedLabel{
				id: lblClientMobile
				Layout.fillWidth: true;
				color: fontColor
			}
			VSharedLabel{
				id: lblClientPhone
				Layout.fillWidth: true;
				color: fontColor
			}
			VSharedLabel{
				id: lblClientCity
				Layout.fillWidth: true;
				color: fontColor
			}
			VSharedLabel{
				id: lblClientAddress
				Layout.fillWidth: true;
				color: fontColor
			}
			VSharedLabel{
				id: lblClientPostalCode
				Layout.fillWidth: true;
				color: fontColor
			}
		}
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Send message...")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,properties:{toUserID:selectedClientUserID}})
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Component.onCompleted: {
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserClients,"GetUserClientDetail",function(e){
			loadingRect.visible=false;
			selectedClientUserID=e.clientUserID;
			lblClientName.text=e.name;
			lblClientPhone.text=e.homePhone;
			lblClientMobile.text=e.mobilePhone;
			lblClientCity.text=e.cityName;
			lblClientAddress.text=e.homeAddress;
			lblClientPostalCode.text=e.homePotalCode;
		},clientID);
	}
}

