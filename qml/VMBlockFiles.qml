import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockFiles"

Rectangle {
	id: topWindow
	property var eBlockFile: enguia.createEntity("EBlockFile")
	property int currentFileNumber:0
	property var listView
	property var filesHash
	property int blockID:0
	property int filesSent:0;
	property int filesToSend:0;
	property int msgID:0

	VSharedPageTitle{
        id:pageTitle
		title: enguia.tr("File sending")
        btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
    }
	VSharedLabelRect{
		id: lblTitle
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
	}
	ColumnLayout{
		spacing: 0
		anchors{left:parent.left;right:parent.right;top:lblTitle.bottom;topMargin: enguia.mediumMargin;bottom:parent.bottom}
		VMBlockFilesImagesList{
			id: filesImageList
			Layout.fillWidth: true
			Layout.fillHeight: true
			onListItemClicked: {
				currentFileNumber=fileNumber;
                dlgFiles.setup(eBlockFile.fileTypes,true)
			}
			onSigMinFilesSelected: btnSend.visible=true;
		}
		VMBlockFilesList{
			id:filesList
			Layout.fillWidth: true
			Layout.fillHeight: true
			onListItemClicked: {
				currentFileNumber=fileNumber;
                dlgFiles.setup(eBlockFile.fileTypes,true)
			}
			onSigMinFilesSelected: btnSend.visible=true;
		}
		ProgressBar{
			id: progressBar
			Layout.fillWidth: true
			height: parent.height*0.01
			minimumValue: 0
			maximumValue: 100
			value: 0
			visible: false
		}
		VSharedButton{
			id: btnSend
			Layout.fillWidth: true
			visible: false
			text:enguia.tr("Send files")
			onClicked: sendFiles();
		}
	}
	VMRectMsg{
        id: rectMsg
		anchors.bottom: parent.bottom
        visible:false
    }
	VMDlgFileSelection{
		id: dlgFiles
		onSigFileSelected: {
			listView.setFilePath(currentFileNumber,absoluteFilePath)
			var model=listView.listModel;
			if(model.count<eBlockFile.maxFiles){
				var filesSetCount=getFileSetCount();
				if(filesSetCount===model.count){//we need to add another row
					var fileNumber=model.count;
					listView.append(fileNumber,getDescription(eBlockFile.filesDescriptions,fileNumber))
				}
			}
		}
	}
	function getFileSetCount(){
		var filesSetCount=0;
		var model=listView.listModel;
		for(var i=0;i<model.count;i++){
			if(model.get(i).filePath.length>0)filesSetCount++
		}
		return filesSetCount;
	}
    function sendFiles(){				
		filesSent=0;
		filesToSend=getFileSetCount();
		if(filesToSend<1)return;
		sendFile(0);
    }
	function sendFile(index){
		if(index>=listView.listModel.count)return;//nothing else to send
		var e=listView.listModel.get(index);
		if(e.filePath.length===0){
			sendFile(index+1);
			return;//nothing to send
		}
		statusBar.displaySuccess(enguia.tr("Sending file")+" "+(filesSent+1).toString());
		mSFiles.uploadBlockFile(msgID, mShared.userID,mShared.placeID,eBlockFile.msgTitle,e.filePath,eBlockFile.resizeImages,eBlockFile.maxWidth,function(id){
			if(id>0)msgID=id;
			if(id<1){statusBar.displayError(enguia.tr("Unable to send file")+":"+mSFiles.getFileName(e.filePath));return;}
			filesSent++;
			if(filesSent===filesToSend){
				statusBar.displaySuccess(enguia.tr("Files sent successfully"));
				mainWindow.popWithoutClear();
				return;
			}
			sendFile(index+1);
		});
	}
	function getDescription(descriptions, fileNumber){
		var descriptionList=descriptions.split(",");
		for(var i=0;i<descriptionList.length;i++){
			var description=descriptionList[i].trim()
			if(i===fileNumber)return description;
		}
		return ""
	}
    Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SBlockFiles,"GetBlock",function(eBlockFile){
			enguia.copyValues(eBlockFile, topWindow.eBlockFile)
			lblTitle.text=eBlockFile.userText;
			if(eBlockFile.onlyImages){
				filesImageList.visible=true;
				filesList.visible=false;
				listView=filesImageList
			}else{
				filesImageList.visible=false;
				filesList.visible=true;
				listView=filesList;
			}
			for(var i=0;i<eBlockFile.minFiles;i++){
				var description=getDescription(eBlockFile.filesDescriptions,i);
				listView.append(i,description)
			}
		},mShared.placeID);
    }	
}

