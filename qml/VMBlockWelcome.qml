import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockWelcome"
import "qrc:/BlockSchedule"
import "qrc:/BlockProducts"
import "qrc:/Messages"
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
    id: topWindow
    property int placeID:0
	property var erBlockWelcome: enguia.createEntity("ERBlockWelcome")
	property string nextBlockPath:""

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
		source: mSFiles.getBannerUrl(placeID);
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
			onClicked: {
				if(enguia.isIOSNotAuthenticated()){mainWindow.popToLogin();return;}
				if(nextBlockPath.length<1)return;
				if(!mShared.isProfileComplete){
					statusBar.displayError(enguia.tr("Complete your profile before continue"));
					mainStack.push({item:Qt.resolvedUrl("qrc:///Preferences/VMPreferencesProfile.qml"),immediate:true, destroyOnPop:true })
					return;
				}
				mainStack.push({item:Qt.resolvedUrl(nextBlockPath),destroyOnPop:true, immediate:true, properties:{blockID:erBlockWelcome.nextBlockID} })
			}
		}
	}
    Menu {
        id: contextMenu
		MenuItem{
			id:menuMyAgenda
			text:enguia.tr("My Agenda")
			visible:false
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProAgenda.qml"),destroyOnPop:true, immediate:true })
		}
		MenuItem{
			id:menuMyOrders
			text:enguia.tr("My Orders")
			visible:false
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockProducts/VMBlockProductsProOrders.qml"),destroyOnPop:true, immediate:true })
		}
        MenuItem {
            id: menu1
            text: ""
			onTriggered: mainStack.push({item:Qt.resolvedUrl(mSBlocks.getUrlFromPageType(erBlockWelcome.menu1BlockType)),destroyOnPop:true, immediate:true, properties:{placeID:placeID} })
        }		
		MenuItem {
			id: menu2
			text: ""
			onTriggered: mainStack.push({item:Qt.resolvedUrl(mSBlocks.getUrlFromPageType(erBlockWelcome.menu2BlockType)),destroyOnPop:true, immediate:true, properties:{placeID:placeID} })
		}
		MenuItem {
			id: menu3
			text: ""
			onTriggered: mainStack.push({item:Qt.resolvedUrl(mSBlocks.getUrlFromPageType(erBlockWelcome.menu3BlockType)),destroyOnPop:true, immediate:true, properties:{placeID:placeID} })
		}
		MenuItem {
			id: menu4
			text: ""
			onTriggered: mainStack.push({item:Qt.resolvedUrl(mSBlocks.getUrlFromPageType(erBlockWelcome.menu4BlockType)),destroyOnPop:true, immediate:true, properties:{placeID:placeID} })
		}
		MenuItem{
			id: menuDrive
			text:enguia.tr("Drive to")
			onTriggered: enguia.driveToAddress(erBlockWelcome.address+","+erBlockWelcome.cityName)	 //enguia.driveToLatLong(-23.18613611, -46.84919371);
			visible: enguia.isAndroid() || enguia.isIOS()
		}
		MenuItem{
			id: menuAddToFavorites
			text:enguia.tr("Add to favorites")
			onTriggered: addToFavorites(mShared.userID,placeID)
			visible: false
		}
		MenuItem {
			id: menuSubscribeToNews
			text: enguia.tr("Subscribe to news")+"..."
			visible: false
			onTriggered: dlgClientWarning.open();
		}
		MenuItem{
			id: menuQualifyTourism
			text:enguia.tr("Qualify")+"..."
			onTriggered: dlgQualifyTourism.open();
			visible: false
		}
		MenuItem{
			id: menuSendMsg
			text:enguia.tr("Send message")+"..."
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,properties:{toPlaceID:mShared.placeID}})
		}
		MenuItem {
			id: menuReport
			text: enguia.tr("Report")+"..."
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Shared/VSharedReportAbuse.qml"),destroyOnPop:true, immediate:true })
		}
    }
	VMBlockWelcomeStatusDlg{
		id: dlgStatus
    }
	VMBlockWelcomeAddressDlg{
		id: dlgAddress
	}
	VMBlockWelcomeRatingDlg{
		id: dlgRating
	}
	VMBlockWelcomeQualifyDlg{
		id: dlgQualifyTourism
		onSigRateSet: qualifyTourism(mShared.userID,mShared.placeID,rating)
	}
	VMClientWarningDlg{
		id: dlgClientWarning
		onSigOkClicked: subscribeToNews(mShared.userID,placeID)
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
		id: emptyRect
		color: "white"
		anchors{left:parent.left;right:parent.right;top:imgBanner.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:50
	}
	function qualifyTourism(userID, placeID, rating){
		mSVC.metaInvoke(MSDefines.SUserQualifications,"QualifyTourism",function(ok){
			statusBar.displayResult(ok,enguia.tr("Qualification set successfully"),enguia.tr("Unable to set qualification"));
		},userID,placeID,rating);
	}
	function subscribeToNews(userID, placeID){
		mSVC.metaInvoke(MSDefines.SUserNews,"Subscribe",function(ok){
			statusBar.displayResult(ok,enguia.tr("Subscribed to news successfully"),enguia.tr("Unable to subscribe to news"));
		},userID,placeID);
	}
	function addToFavorites(userID, placeID){
		mSVC.metaInvoke(MSDefines.SUserFavorites,"AddPlaceToFavorites",function(ok){
			statusBar.displayResult(ok,enguia.tr("Place added to favorites successfully"),enguia.tr("Unable to add to favorites"));
		},userID,placeID);
	}
	Component.onCompleted: {
		mFlow.clear();
		emptyRect.visible=true;
		mShared.placeID=placeID;
		mSBlocks.getRuntimeBlockWelcome(mShared.userID, placeID, function(e){
			emptyRect.visible=false;
			enguia.copyValues(e,erBlockWelcome);
			dstore.saveValue("erblockwelcome",erBlockWelcome);
			MobileFunctions.erBlockWelcome=erBlockWelcome;
			pageTitle.title=e.name;
			vText.setText(e.description);
			var placeOpenStatus=mMobile.getOpenStatus(e);
			mFlow.setPlaceOpenStatus(placeOpenStatus);
			bar.setup(e.rating,e.qualificationEnabled, placeOpenStatus);
			if(enguia.isIOSNotAuthenticated()){
				btnOverflow.visible=false;
				bar.btnStatus.visible=false;
				btnEnter.text=enguia.tr("Login")
				btnEnter.visible=true;
				return;
			}
			nextBlockPath=mSBlocks.getUrlFromPageType(erBlockWelcome.nextBlockType);
			if(nextBlockPath.length<1){btnEnter.visible=false;}
			if(!erBlockWelcome.isFavorite)menuAddToFavorites.visible=true;
			if(erBlockWelcome.hasAgenda)menuMyAgenda.visible=true;
			if(erBlockWelcome.containsOrderBlock)menuMyOrders.visible=true;
			if(!erBlockWelcome.isUserSubscribedToNews)menuSubscribeToNews.visible=true;
			if(erBlockWelcome.menu1Text.length>0)menu1.text=erBlockWelcome.menu1Text;else menu1.visible=false;
			if(erBlockWelcome.menu2Text.length>0)menu2.text=erBlockWelcome.menu2Text;else menu2.visible=false;
			if(erBlockWelcome.menu3Text.length>0)menu3.text=erBlockWelcome.menu3Text;else menu3.visible=false;
			if(erBlockWelcome.menu4Text.length>0)menu4.text=erBlockWelcome.menu4Text;else menu4.visible=false;
			if(erBlockWelcome.isFun){
				bar.btnStatus.visible=false;
				menuQualifyTourism.visible=true;
				menuSendMsg.visible=false;
				menuSubscribeToNews.visible=false;
				if(erBlockWelcome.funPictureCount<=1){btnEnter.visible=false;}
			}
		});
	}
}
