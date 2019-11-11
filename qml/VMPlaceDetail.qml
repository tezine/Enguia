import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Shared"
import "qrc:/"
import "qrc:/Components"

Rectangle{
	id: placesDetailPage
	property int secondColumnWidth: enguia.width*0.5
	property int funID: 0
	property bool inFavorites: false
	property bool inSqlite: false
	property variant mFavorites
	property int pictureCount:0
	property int funUserID:0

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Detail")
		busyIndicator.visible: true
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		VMToolButton{
			id: toolMenu
			anchors.right: parent.right
			source: "qrc:///Images/overflow.png"
			onSigClicked: myMenu.open()
		}
	}
	VSharedRatingIndicator{
		id: ratingIndicator
		anchors{left:parent.left; right:parent.right; top:pageTitle.bottom;}
		//maximumValue: 5
	}
	VMPlaceDetailList{
		id: list
		anchors{top: ratingIndicator.bottom;left: parent.left;right: parent.right;bottom: parent.bottom}
	}
	Menu{
		id: myMenu
		MenuItem{
			id: menuViewComments
			text: enguia.tr("Comments")
			//onClicked: mData.push( MData.PageTypeFunDetailComments, {funID:funID, funUserID:funUserID})
		}
		MenuItem{
			id: menuPictures
			text: enguia.tr("Pictures")
			//onClicked: mData.push(MData.PageTypeFunDetailPictures,{funID:funID,picturesCount:pictureCount})
		}
		/*ja estava comentado em c++MenuItem{
			id: menuDrive
			text: qsTr("Drive")
			onClicked:{
				myMenu.close();
				queryDialog.open();
			}
		}
		MenuItem{
			id: menuShared
			text: qsTr("Share")
			onClicked: mData.push( MData.PageTypeFunDetailShareToFriends, {funID:funID})
		}
		MenuItem{
			id: menuEdit
			text: qsTr("Edit")
			onClicked: mData.push( MData.PageTypeFunDetailEditMain, {funID:funID, inSqlite:inSqlite})
		}*/
		MenuItem{
			id: menuRemove
			text: enguia.tr("Delete")
			visible: false
			onTriggered:{
				/*if(inSqlite){
					if(!mFun.removeFunFromSqlite(funID)){
						banner.popup(qsTr("Unable to remove"));
					}else mData.push(MData.PageTypeFun)
					}else{// on server
						mFun.removeFun(funID);
					}*/
			}
		}
		MenuItem{
			id: menuAddToFavorites
			text: enguia.tr("Add to favorites")
			onTriggered:{
				/*if(!inFavorites)mFavorites.addFun(funID)
					else mFavorites.removeFunFromFavorites(funID)*/
			}
		}
	}
	VMBanner{
		id: banner
	}
	VMDlgQuery{
		id: queryDialog
		/*icon: "qrc:///Images/question"
			width: parent.width
			height: 200
			titleText: "Drive with Nokia Drive"
			message: "Are you sure you want close Enguia and open Nokia Drive?"
			acceptButtonText: "Yes"
			rejectButtonText: "Cancel"
			onAccepted:{
			}*/
	}
	Connections	{
		/*target: mFun
			onReceivedDetail:{
				pageTitle.busyIndicator.visible=false;
				if(!cs)return;
				if(cs.rating<1 || cs.rating>5)ratingIndicator.visible=false;
				else ratingIndicator.visible=true;
				ratingIndicator.count=cs.voteCount;
				ratingIndicator.ratingValue=cs.rating;
				if(cs.picCount<1)menuPictures.visible=false;
				else menuPictures.visible=true;
				pictureCount=cs.picCount;
				funUserID=cs.userID;
				if(funUserID===mData.userID && cs.visibility===parseInt(MData.VisibilityPrivate))menuRemove.visible=true;
				list.append(cs.name,cs.brief,cs.description,cs.address, cs.startDate, cs.endDate, cs.email, cs.capacity, cs.structure, cs.price, cs.agerange, cs.webSite, cs.postalCode, cs.phone1,
				cs.mondayStart, cs.mondayEnd, cs.tuesdayStart, cs.tuesdayEnd, cs.wednesdayStart, cs.wednesdayEnd, cs.thursdayStart, cs.thursdayEnd, cs.fridayStart, cs.fridayEnd,
				cs.saturdayStart, cs.saturdayEnd, cs.sundayStart, cs.sundayEnd)
			}
			onAnswerRemoveFun:{
				if(!ok)banner.popup(qsTr("Unable to remove"));
				else mData.push(MData.PageTypeFun)
			}*/
	}
	Connections{
		/*id: favoritesConnection
			ignoreUnknownSignals: true
			onAddedToFavorites:{
				if(ok)banner.popup(qsTr('Place added to favorites'));
				else banner.popup(qsTr('Failed to add to favorites'));
			}
			onRemovedFunFromFavorites:{
				if(ok){
					inFavorites=false;
					menuAddToFavorites.text=qsTr("Add to Favorites");
					banner.popup(qsTr('Fun removed from favorites'));
				}else banner.popup(qsTr('Failed to remove from favorites'));
			}*/
	}
	function setup(state){
		/*mFavorites=mData.mFavorites;
			favoritesConnection.target=mFavorites
			mImages.stopDownloadImages();
			list.listModel.clear()
			if(inFavorites)menuAddToFavorites.text=qsTr("Remove from favorites");
			if(inSqlite){
				pageTitle.busyIndicator.visible=false;
				ratingIndicator.visible=false;
				menuViewComments.visible=false;
				menuPictures.visible=false;
				menuAddToFavorites.visible=false;
				menuRemove.visible=true;
				var fun=mFun.getDetailFromSqlite(funID);
				list.append(fun.name,fun.brief,fun.description,fun.address, fun.startDate, fun.endDate, fun.email, fun.capacity, fun.structure, fun.price, fun.agerange, fun.webSite, fun.postalCode, fun.phone1,
				fun.mondayStart, fun.mondayEnd, fun.tuesdayStart, fun.tuesdayEnd, fun.wednesdayStart, fun.wednesdayEnd, fun.thursdayStart, fun.thursdayEnd, fun.fridayStart, fun.fridayEnd,
				fun.saturdayStart, fun.saturdayEnd, fun.sundayStart, fun.sundayEnd)
			}else mFun.getDetail(funID)*/
	}
	Component.onCompleted:{
		if(enguia.isPreview()){
			pageTitle.busyIndicator.visible=false;
			/*ratingIndicator.count=5
				ratingIndicator.ratingValue=4;
				list.append("Mockup",'Brief','Description','Address', '2014-01-01', '2014-10-10', 'bruno@tezine.com', 300, "cadeiras", 2, 2, 'www.bozo.com', '132230', '1234533',
				'08:00:00', '18:00:00', '08:00:00', '18:00:00', '08:00:00', '18:00:00', '08:00:00', '18:00:00', '08:00:00', '18:00:00',
				'08:00:00', '18:00:00', '08:00:00', '18:00:00')*/
		}
	}
}
