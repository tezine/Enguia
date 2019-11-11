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
import "qrc:/"


Rectangle {
    property int toPlaceID:0
	property int toUserID:0
    property bool justSet:false
	property int parentMsgID:0
	property string parentMsgTitle:""
	property bool isReply:false
	color: enguia.backColor

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Message edition")
        busyIndicator.visible: false
        btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popWithoutClear();
		titleLayout.anchors.right: toolAttach.left
		VMToolButton{
			id: toolAttach
			source: "qrc:///Images/addattach.png"
			anchors.right: toolSend.left
            onSigClicked: dlgFileSelection.setup("",true);
			visible: toUserID===0
		}
        VMToolButton{
            id: toolSend
            source: "qrc:///SharedImages/send.png"
			anchors.right: parent.right
			onSigClicked: {
				Qt.inputMethod.commit();
				sendMsg(mShared.userID,toPlaceID,toUserID, txtTitle.text,textArea.text)
			}
        }
    }
	VSharedLabelRect{
		id: lblReplyTitle
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
		visible: isReply
	}
	ColumnLayout{
		id:columnLayout
		anchors.top: lblReplyTitle.visible?lblReplyTitle.bottom:pageTitle.bottom
		anchors{left:parent.left;leftMargin: enguia.mediumMargin; right:parent.right;rightMargin: enguia.mediumMargin; topMargin:enguia.mediumMargin; bottom:parent.bottom;bottomMargin:enguia.mediumMargin}
		spacing: enguia.smallMargin
		RowLayout{
            id:rowLayoutTo
			Layout.preferredHeight: txtTo.height
			Layout.fillWidth: true
			VMTextField{
				id: txtTo
				Layout.fillWidth: true
				placeholderText: enguia.tr("To")+":";
				maximumLength: 50
				inputMethodHints: Qt.ImhNoPredictiveText
                visible:true
				onTextChanged: {
					if(txtTo.readOnly)return;
					Qt.inputMethod.commit();
					if(text.length<3)contactList.visible=false;
					if(justSet){justSet=false;return;}
					if(text.length>3)getContacts(mShared.userID, text)
				}
			}
			VMImageButton{
				id: btnClearTo
                visible: txtTo.text.length>0
				Layout.maximumWidth: txtTo.height
				Layout.maximumHeight: txtTo.height
				source: "qrc:///Images/delete.png"
				Layout.preferredHeight: parent.height
				Layout.preferredWidth: parent.height
				onSigBtnClicked: {
					txtTo.readOnly=false;
					txtTo.text=""
					toUserID=0;
				}
			}
		}
		VMTextField{
			id: txtTitle
			Layout.fillWidth: true
			placeholderText: enguia.tr("Subject")+":"
			maximumLength: 50
			visible: isReply?false:true
		}
		TextArea{
			id: textArea
			Layout.fillWidth: true
			Layout.fillHeight: true
			font{pointSize: enguia.largeFontPointSize;}
		}
		VMMessagesAttachmentList{
			id: attachmentList
			Layout.minimumHeight: parent.height*0.2
			Layout.maximumHeight: parent.height*0.2
			color:"#F5F5F5"
			Layout.fillWidth: true
			onListItemPressAndHold: showDelete(fileName)
			onSigBtnDeleteClicked: remove(fileName)
		}
	}
	VMContactsList{
        id: contactList
		anchors{top:columnLayout.top;left:parent.left;right:parent.right;bottom:parent.bottom}
		anchors.topMargin: enguia.height*0.06
        visible: false
        onListItemClicked: {
            justSet=true;
			txtTo.text=name
			toPlaceID=placeID;
			toUserID=userID
            contactList.visible=false;
            txtTo.visible=true;
			txtTo.readOnly=true;
			if(toUserID>0)attachmentList.listModel.clear();
        }
    }    
	VMDlgFileSelection{
		id: dlgFileSelection
		onSigFileSelected: {
			var fileSize=mSFiles.getFileSize(absoluteFilePath);
			if(fileSize>5000000){statusBar.displayError(enguia.tr("Maximum size allowed is 5Mb"));return;}
			attachmentList.visible=true;
			attachmentList.appendLocalFile(absoluteFilePath)
			if(attachmentList.listModel.count===5)toolAttach.enabled=false;
		}
	}
	function sendMsg(currentUserID, toPlaceID,toUserID, title, content){
		statusBar.visible=false;
		Qt.inputMethod.hide();
		if(toPlaceID<1 && toUserID<1){statusBar.displayError(enguia.tr("Select a destination"));return;}
		if(title.length<3){statusBar.displayError(enguia.tr("Invalid title"));return;}
		if(content.length>10000){statusBar.displayError(enguia.tr("Maximum size is 10.000 chars"));return;}
		mSVC.metaInvoke(MSDefines.SUserMessages,"SendMsg",function(msgID){
			if(msgID>0){
				if(attachmentList.listModel.count===0){statusBar.displaySuccess(enguia.tr("Message sent successfully"));mainWindow.popWithoutClear();}
				else sendFiles(toPlaceID, msgID)
			}else{statusBar.displayError(enguia.tr("Unable to send message"));}
		},currentUserID,toUserID, toPlaceID, title,content,parentMsgID);
    }
	function sendFiles(toPlaceID, msgID){
		var model=attachmentList.listModel;
		var filesSent=0;
		var filesToSend=model.count;
		statusBar.displaySuccess(enguia.tr("Sending files..."))
		for(var i=0;i<model.count;i++){
			var completeFilePath=model.get(i).localFilePath;
			var fileName=model.get(i).fileName
			mSFiles.sendMsgFile(msgID, mShared.userID,0,0,toPlaceID,fileName, completeFilePath,function(id){
				if(id<1)statusBar.displayError(enguia.tr("Unable to send file"))
				filesSent++;
				if(filesSent===filesToSend){statusBar.displaySuccess(enguia.tr("Message sent successfully")); mainWindow.popWithoutClear();}
			});
		}
	}
	function getContacts(currentUserID, txt){
		contactList.clear();
		contactList.visible=false;
		mSVC.metaInvoke(MSDefines.SUserContacts,"SearchUserContacts",function(list){
			if(list.length<1)return;
			contactList.visible=true;
			for(var i=0;i<list.length;i++){
				var eContact=list[i];
				contactList.append(eContact.placeID, eContact.userID, eContact.name)
			}
		},currentUserID,txt);
    }
	function getPlace(placeID){
		mSVC.metaInvoke(MSDefines.SPlaces,"GetByID",function(ePlace){
			txtTo.text=ePlace.name;
		},toPlaceID)
	}
	function getUser(userID){
		mSVC.metaInvoke(MSDefines.SUsers,"GetAllFieldsByID",function(eUser){
			txtTo.text=eUser.name;
		},userID);
	}
	Component.onCompleted:{
		attachmentList.visible=false;
		if(parentMsgID>0){//reply
			txtTitle.readOnly=true;
            btnClearTo.visible=false;
			var truncatedTitle = parentMsgTitle.substring(0,46);//to add Re:
			lblReplyTitle.text="Re: "+truncatedTitle;
			txtTitle.text=lblReplyTitle.text;
			textArea.focus=true;
		}else{//new message
		}
		if(toPlaceID>0){//called from welcomescreen
			txtTo.readOnly=true;
			getPlace(toPlaceID)
		}else if(toUserID>0){
			txtTo.readOnly=true;
			getUser(toUserID)
		}
	}
}

