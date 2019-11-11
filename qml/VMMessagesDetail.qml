import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
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
	id:topWindow
    property int msgID:0
	property int fromPlaceID:0
	property int fromUserID:0
    property bool displayReplyButton:false
	property bool markAsRead:false
	property int currentMsgFileID:0
	property string currentMsgFileName:""

    VMPageTitle{
        id: pageTitle
		title: enguia.tr("Message")
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: pageTitle.right
        VMToolButton{
            id: toolAdd
            source: "qrc:///SharedImages/reply.png"
			anchors.right: toolMenu.left
			onSigClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///Messages/VMMessagesEdit.qml"),destroyOnPop:true,immediate:true, properties:{toPlaceID:fromPlaceID, toUserID:fromUserID, parentMsgID:msgID, parentMsgTitle:lblTitle.text, isReply:true}})
            visible:displayReplyButton
        }
		VMToolButton{
			id: toolMenu
			source: "qrc:///SharedImages/overflow.png"
			anchors.right: parent.right
			onSigClicked: myMenu.popup();
		}
    }
	VSharedLabelRect{
		id: lblTitle
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;}
		horizontalAlignment: Text.AlignHCenter
	}
	VMListEmptyRect{
		id: emptyRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	SplitView{
		orientation: Qt.Vertical
		anchors{left:parent.left;right:parent.right;top:lblTitle.bottom;bottom:parent.bottom;}
		VSharedText{
			id: textArea
			Layout.minimumHeight: parent.height*0.5
			Layout.fillHeight: true
			Layout.fillWidth: true
		}
		VMMessagesAttachmentList{
			id: attachmentList
			visible: false
			Layout.minimumHeight: parent.height*0.2
			color:"#F5F5F5"
			Layout.fillWidth: true
			onListItemPressAndHold:{
				if(id<1)return;
				currentMsgFileID=id;
				currentMsgFileName=fileName;
				attachMenu.popup();
			}
		}
	}
	VMDlgFileSelection{
		id: fileDlg
		onSigFolderClicked: {downloadFile(currentMsgFileID,absoluteFolderPath);close();}
	}
	Menu{
		id: attachMenu
		MenuItem{
			text:enguia.tr("Save...")
			onTriggered: fileDlg.setupGetExistingDirectory(true)
		}
	}
	Menu{
		id: myMenu
		MenuItem{
			id: menuToday
			text: enguia.tr("Report spam");
			onTriggered: reportSpam(msgID);
		}
	}
	function downloadFile(fileID, absoluteLocalFolderPath){
		mSFiles.downloadMsgFile(fileID,absoluteLocalFolderPath,function(ok){
			statusBar.displayResult(ok,enguia.tr("File downloaded successfully"),enguia.tr("Unable to download file"));
		});
	}
	function reportSpam(msgID){
		mSVC.metaInvoke(MSDefines.SMessagesSpams,"ReportSpam",function(ok){
			statusBar.displayResult(ok,enguia.tr("Spam reported successfully"),enguia.tr("Unable to report spam"))
		},msgID);
	}
    Component.onCompleted: {		
		emptyRect.visible=true;
		mSVC.metaInvoke(MSDefines.SMessages,"GetMsgContent",function(e){
			emptyRect.visible=false;
			topWindow.fromPlaceID=e.fromPlaceID;
			topWindow.fromUserID=e.fromUserID;
			lblTitle.text=e.title
			textArea.setText(e.content);
		},msgID,markAsRead);
		mSVC.metaInvoke(MSDefines.SMessagesFiles,"GetAttachmentsWithoutBlob",function(list){
			if(list.length===0)attachmentList.visible=false;
			else attachmentList.visible=true;
			for(var i=0;i<list.length;i++){
				var eMessageFile=list[i];
				attachmentList.append(eMessageFile)
			}
		},msgID);
    }
}

