import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
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
import "qrc:/Tourism"

Rectangle {
    anchors.fill: parent
    property alias picsModel: picsModel
    property int currentIndex:0
    property alias model: picsModel
	property int filesSent:0;
	property int filesToSend:0;
    color:"gray"

    ListModel{
        id: picsModel
    }
    GridView{
        id: grid1Pics
		anchors{top: parent.top;bottom: parent.bottom;left: parent.left;right: parent.right;topMargin: enguia.mediumMargin;}
		cellWidth: enguia.width/3;
		cellHeight:enguia.width/3;
        clip: true
        model: picsModel
        delegate: Rectangle{
		   width: enguia.width/3;
		   height: enguia.width/3;
           border{color: "black";width: 1}
           radius: 10
            BorderImage{
                id: background
                anchors{fill: parent;leftMargin: -parent.anchors.leftMargin;rightMargin: -parent.anchors.rightMargin}
                visible: mouseArea.pressed
            }
            Image{
				id: realImg
                anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
				width: enguia.width/3.1;
				height: enguia.width/3.1;
                source: model.thumbPath
				asynchronous: true
				cache: false
				visible: status===Image.Ready
            }
			Rectangle{
				id: rectSelect
				visible: realImg.status!==Image.Ready
				color:"#EEEEEE"
				anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
				width: enguia.width/3.1;
				height: enguia.width/3.1;
				Label{
					id: lblSelect
					anchors.fill: parent
					font{pointSize: enguia.largeFontPointSize;bold:true}
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					text:enguia.tr("Select")
					color:"#2096F2"
				}
			}
            MouseArea{
                id: mouseArea
				anchors.fill: parent
                onClicked:{
                    currentIndex=model.index
					menu.popup();
                }
            }
        }
    }
	VMDlgFileSelection{
		id: dlgFiles
		onSigFileSelected: {
			picsModel.get(currentIndex).filePath=absoluteFilePath;
			picsModel.get(currentIndex).thumbPath=enguia.convertFileToURL(absoluteFilePath)
		}
	}
	VMDlgPicDetail{
		id: dlgPicDetail
		onSigSaveClicked: {
			picsModel.get(currentIndex).name=title;
			picsModel.get(currentIndex).description=description;
		}
	}
	Connections{
		target:mMobile
		onSigPictureChanged:{//called whenever user takes a picture
			picsModel.get(currentIndex).filePath=path;
			picsModel.get(currentIndex).thumbPath=enguia.convertFileToURL(path)
		}
	}
    Menu{
        id: menu
		MenuItem{
			id: menuTakePicture
			text: enguia.tr("Take a picture")
			onTriggered: mainStack.push({item:Qt.resolvedUrl("qrc:///Tourism/VMTourismEditTakePicture.qml"),destroyOnPop:true,immediate:true})
			visible: enguia.isAndroid()||enguia.isIOS()
		}
        MenuItem{
            id: menuGallery
			text: enguia.tr("Set picture")
            onTriggered: dlgFiles.setup("*.jpg",true);
        }
        MenuItem{
			id: menuDetail
			text: enguia.tr("Set details")
			onTriggered:dlgPicDetail.setup(picsModel.get(currentIndex).name, picsModel.get(currentIndex).description)
        }
		MenuItem{
			id: menuMainPicture
			text: enguia.tr("Set as main picture")
			onTriggered: setMainPicture(picsModel.get(currentIndex).picID)
		}
    }
	function hasPicturesToSend(){
		for(var i=0;i<picsModel.count;i++){
			if(picsModel.get(i).filePath!=='')return true;
		}
		return false;
	}
	function getFilesToSendCount(){
		var count=0;
		for(var i=0;i<picsModel.count;i++){
			if(picsModel.get(i).filePath.length!==0)count++
		}
		return count;
	}
	function sendPictures(placeID){
		filesSent=0;
		filesToSend=getFilesToSendCount();
		if(filesToSend<1)return;
		sendPicture(0,picsModel.count);
	}
	function sendPicture(index,total){//we have to serialize sending pictures to avoid dead lock on db
		if(index>=picsModel.count)return;//nothing else to send
		var e=picsModel.get(index);
		if(e.filePath.length===0){
			sendPicture(index+1);
			return;//nothing to send
		}
		statusBar.displaySuccess(enguia.tr("Sending picture")+" "+(filesSent+1).toString());
		mSFiles.uploadPictureUsedAfterBlockWelcome(placeID,e.picID, e.name, e.description, e.filePath,e.isMainPicture, function(id){
			filesSent++;
			if(id<1){statusBar.displayError(enguia.tr("Unable to send picture"));return;}
			if(filesSent===filesToSend){
				statusBar.displaySuccess(enguia.tr("Pictures sent successfully"));
				mainWindow.popWithoutClear();
				return;
			}
			sendPicture(index+1);
		});
	}
	function getItemByPicNumber(picNumber){
		for(var i=0;i<picsModel.count;i++){
			if(picsModel.get(i).picID===picNumber)return picsModel.get(i)
		}
		return null;
	}
	function setMainPicture(picNumber){
		for(var i=0;i<picsModel.count;i++){
			if(picsModel.get(i).picID===picNumber){
				picsModel.get(i).isMainPicture=true;
			}else picsModel.get(i).isMainPicture=false;
		}
		if(ePlace.id===0)return;
		//if the picture was already sent, we set it into the server
		mSVC.metaInvoke(MSDefines.SPlacePictures,"SetMainPicture",function(ok){
		},ePlace.id,picNumber)
	}
	function clearModel(placeID){
		picsModel.clear();
		picsModel.append({"picID":1, "thumbPath":mSFiles.getPictureUrl(placeID,1), "name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":2, "thumbPath":mSFiles.getPictureUrl(placeID,2),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":3, "thumbPath":mSFiles.getPictureUrl(placeID,3),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":4, "thumbPath":mSFiles.getPictureUrl(placeID,4),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":5, "thumbPath":mSFiles.getPictureUrl(placeID,5),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":6, "thumbPath":mSFiles.getPictureUrl(placeID,6),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":7, "thumbPath":mSFiles.getPictureUrl(placeID,7),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":8, "thumbPath":mSFiles.getPictureUrl(placeID,8),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":9, "thumbPath":mSFiles.getPictureUrl(placeID,9),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":10, "thumbPath":mSFiles.getPictureUrl(placeID,10),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":11, "thumbPath":mSFiles.getPictureUrl(placeID,11),"name":"", "description":"",filePath:'',isMainPicture:false})
		picsModel.append({"picID":12, "thumbPath":mSFiles.getPictureUrl(placeID,12),"name":"", "description":"",filePath:'',isMainPicture:false})
	}	
    Component.onCompleted: {
		clearModel(ePlace.id);
		if(ePlace.id===0)return;//new place
		mSVC.metaInvoke(MSDefines.SPlacePictures,"GetPictures",function(list){
			for(var i=0;i<list.length;i++){
				if(i>11)break;//only 12 images allowed
				var ePlacePicture=list[i];
				var itemModel=getItemByPicNumber(ePlacePicture.picNumber)
				itemModel.name=ePlacePicture.name;
				itemModel.description=ePlacePicture.description;
			}
		},ePlace.id)
    }
}

