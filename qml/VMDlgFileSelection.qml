import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
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
import "qrc:/"

Dialog {
	id: dlg
	visible:false
    property bool readOnly:true
	property alias title: titlebar.title
	property alias titleBar:titlebar
	property alias saveVisible: titlebar.saveVisible
	signal sigFileSelected(string fileName, string absoluteFilePath)
	signal sigFolderClicked(string folderName, string absoluteFolderPath)
	width: enguia.width
	height: enguia.height

	contentItem: Rectangle {
		implicitWidth: enguia.width
		implicitHeight: enguia.height
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Files")
			saveVisible: false
			onSigCancelClicked: close();
		}
		VSharedListFolders{
			id: folderList
			anchors{left:parent.left;right:parent.right;top:titlebar.bottom;bottom:parent.bottom;}
			onListItemClicked: {
				if(isDir){
					sigFolderClicked(name, absoluteFilePath)
					getFoldersAndFiles(absoluteFilePath,"");
				}
				else{
					sigFileSelected(name, absoluteFilePath)
					close();
				}
			}
		}
	}
	function getFoldersAndFiles(path,filter){
		folderList.clear();
        var list= mSFiles.getLocalFoldersAndFiles(path,filter,readOnly);
		for(var i=0;i<list.length;i++){
			var e=list[i];
			folderList.append(e.fileName, e.absoluteFilePath, e.isDir);
		}
	}
	function setupGetExistingDirectory(onlyWritableFolders){        
		if(onlyWritableFolders){
            dlg.readOnly=false;
			title=enguia.tr("Select a folder")
			folderList.setupGetWritableFolders();
		}
		open();
	}
	Component.onCompleted:{
		getFoldersAndFiles("","")
	}
    function setup(filter, readOnly){
        dlg.readOnly=readOnly;
		getFoldersAndFiles("",filter)
		open();
	}
	function setupGallery(){
		folderList.clear();
		var list=mSFiles.getLocalPictures();
		for(var i=0;i<list.length;i++){
			var eFileInfo=list[i];
			folderList.append(eFileInfo.fileName, eFileInfo.absoluteFilePath, eFileInfo.isDir);
		}
		open();
	}
}


