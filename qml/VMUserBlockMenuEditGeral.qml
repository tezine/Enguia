import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockMenu"
import "qrc:/"

Rectangle {

	VSharedList2{
		id:listView
		anchors.fill: parent
		onListItemPressAndHold: showDelete(id)
		onSigDeleteClicked: deleteMenu(id)
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockMenu/VMUserBlockMenuEditEntry.qml"),immediate:true, destroyOnPop:true, properties:{blockID:blockID,id:id} })
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:parent.top;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}	
	function saveFields(){
		return true;
	}
	function deleteMenu(id){
		mSVC.metaInvoke(MSDefines.SUserMenus, "DeleteUserMenu",function(ok){
			if(ok)listView.remove(id);
		},id);
	}
	function refresh(){
		listView.clear();
		mSVC.metaInvoke(MSDefines.SUserMenus,"GetUserMenus",function(list){
			for(var i=0;i<list.length;i++){
				var eUserMenu=list[i];
				listView.append(eUserMenu.id,eUserMenu.title,eUserMenu.subTitle);
			}
		},blockID);
	}
	Component.onCompleted: {
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserBlockMenu,"GetUserBlockMenuByID",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e,eUserBlockMenu);
		},blockID);
	}
}

