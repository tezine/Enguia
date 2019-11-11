import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/UserBlockWelcome"
import "qrc:/BlockWelcome"
import "qrc:/Messages"
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
	id: topWindow
	property int otherUserID:0
	property int nextBlockID:0
	property string nextBlockPath:""
	property var erBlockWelcome: enguia.createEntity("EUserBlockWelcome")

	VMPageTitle{
		id:pageTitle
		btnBackVisible:mShared.previewMode?false:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: btnOverflow.left
		VSharedToolButton{
			id: btnOverflow
			anchors{right:parent.right}
			source: "qrc:///SharedImages/overflow.png"
			onSigClicked: contextMenu.popup();
		}
	}
	Image{
		id: imgBanner
		source: mSFiles.getUserBannerUrl(otherUserID);
		width: parent.height*0.3
		height: parent.height*0.3
		sourceSize.height: parent.height*0.3
		sourceSize.width: parent.height*0.3
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		onStatusChanged: {
			switch(status){
				case Image.Error:
					source="qrc:///SharedImages/pictureunknownbig.jpg"
					break;
				case Image.Ready:
					imgProgress.visible=false
					break;
			}
		}
		VSBusyIndicator{
			id: imgProgress
			anchors{verticalCenter:parent.verticalCenter ;horizontalCenter: parent.horizontalCenter;}
			height:parent.height*0.9
			width: parent.height*0.9
			running: true
			visible: true
		}
	}
	ColumnLayout{
		id: columnLayout
		anchors{left:parent.left;right:parent.right;top:imgBanner.bottom;bottom:parent.bottom;}
		spacing: 0
		VMBlockWelcomeBar{
			id: bar
			btnInfo.visible: false
			Layout.fillWidth: true
			Layout.preferredHeight: enguia.height*0.06
			Layout.maximumHeight: enguia.height*0.06
		}
		VSharedText{
			id: vText
			Layout.fillWidth: true
			Layout.fillHeight: true
			text:""
		}
		VSharedButton{
			id: btnEnter
			text:enguia.tr("Enter")
			Layout.fillWidth: true
			onClicked: btnEnterClicked();
		}
	}
	Menu {
		id: contextMenu
		MenuItem{
			id: menuDrive
			text:enguia.tr("Drive to")
			onTriggered: enguia.driveToAddress(erBlockWelcome.address+","+erBlockWelcome.cityName)	 //enguia.driveToLatLong(-23.18613611, -46.84919371);
			visible: false
		}
		MenuItem{
			id: menuAddToFavorites
			text:enguia.tr("Add to favorites...")
			onTriggered: favoriteMenu.popup();
			visible: false
		}
		MenuItem{
			id: menuSendMsg
			text:enguia.tr("Send message")+"..."
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,properties:{toUserID:otherUserID}})
		}
//		MenuItem {
//			id: menuReport
//			text: enguia.tr("Report")+"..."
//			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Shared/VSharedReportAbuse.qml"),destroyOnPop:true, immediate:true })
//		}
	}
	Menu{
		id:favoriteMenu
		MenuItem{
			text:enguia.tr("Family")
			onTriggered: addToFavorites(mShared.userID,otherUserID,MSDefines.BlockVisibilityFamily);
		}
		MenuItem{
			text:enguia.tr("Best friends")
			onTriggered: addToFavorites(mShared.userID,otherUserID,MSDefines.BlockVisibilityBestFriends);
		}
		MenuItem{
			text:enguia.tr("Friends")
			onTriggered: addToFavorites(mShared.userID,otherUserID,MSDefines.BlockVisibilityFriends);
		}
		MenuItem{
			text:enguia.tr("Fellow worker")
			onTriggered: addToFavorites(mShared.userID,otherUserID,MSDefines.BlockVisibilityFellowWorker);
		}
		MenuItem{
			text:enguia.tr("Other")
			onTriggered: addToFavorites(mShared.userID,otherUserID,MSDefines.BlockVisibilityOthers);
		}
	}
	VMBlockWelcomeStatusDlg{
		id: dlgStatus
	}
	VMBlockWelcomeAddressDlg{
		id: dlgAddress
	}
	MouseArea{
		anchors.fill: topWindow
		propagateComposedEvents: true
		z: 1000000000
		onPressed: {
			enguia.closeDialogs(topWindow)
			mouse.accepted = false;
		}
	}
	VMListEmptyRect{
		id: loadingRect
		color: "white"
		anchors{left:parent.left;right:parent.right;top:imgBanner.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:50
	}
	function btnEnterClicked(){
		if(nextBlockPath.length<1)return;
		if(!mShared.isProfileComplete){
			statusBar.displayError(enguia.tr("Complete your profile before continue"));
			mainStack.push({item:Qt.resolvedUrl("qrc:///Preferences/VMPreferencesProfile.qml"),immediate:true, destroyOnPop:true })
			return;
		}
		mainStack.push({item:Qt.resolvedUrl(nextBlockPath),destroyOnPop:true, immediate:true, properties:{blockID:nextBlockID} })
	}
	function addToFavorites(userID, otherUserID, visibility){
		mSVC.metaInvoke(MSDefines.SUserFavorites,"AddUserToFavorites",function(ok){
			statusBar.displayResult(ok,enguia.tr("Added to favorites successfully"),enguia.tr("Unable to add to favorites"));
		},userID,otherUserID,visibility);
	}
	Component.onCompleted:{
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserBlockWelcome,"GetRuntimeUserBlockWelcomeByUserID",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e,erBlockWelcome)
			dstore.saveValue("eUserBlockWelcome",erBlockWelcome);
			pageTitle.title=e.userName;
			mShared.otherUserID=otherUserID;
			mMobile.currentUserVisibility=e.currentUserVisibility;
			MobileFunctions.userBlockWelcomeOpenStatus=mMobile.getUserBlockWelcomeOpenStatus(e);
			console.debug("current user visibility:",mMobile.getVisibilityName(e.currentUserVisibility));
			if(mMobile.testVisibility(mMobile.currentUserVisibility,e.infoVisibility)){
				bar.btnInfo.visible=true;
				if(enguia.isAndroid() || enguia.isIOS())menuDrive.visible=true;
			}
			nextBlockID=e.nextBlockID;
			if(!e.isFavorite)menuAddToFavorites.visible=true;
			if(e.nextBlockID<1)btnEnter.visible=false;
			vText.setText(e.description);
			bar.setup(0,false,true);
			if(!e.displayStatus)bar.btnStatus.visible=false;
			nextBlockPath=mSBlocks.getUrlFromUserBlockType(e.nextBlockType);
		},mShared.userID, otherUserID);
	}
}
