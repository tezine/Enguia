import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockProducts"
import "qrc:/"

Rectangle {

	VSharedList2{
		id:listView
		anchors.fill: parent
		onListItemPressAndHold: showDelete(id);
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditCategoriesEntry.qml"),immediate:true, destroyOnPop:true, properties:{categoryID:id, categoryName:name} })
		onSigDeleteClicked: removeCategory(id)
	}
	function removeCategory(id){
		mSVC.metaInvoke(MSDefines.SUserProductsCategories,"RemoveUserCategory",function(ok){
			statusBar.displayResult(ok,enguia.tr("Category removed successfully"),enguia.tr("Unable to remove category"));
			if(ok)listView.remove(id);
		},id);
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockProducts/VMUserBlockProductsEditCategoriesEntry.qml"),immediate:true, destroyOnPop:true, properties:{categoryID:0} })
	}
	function saveFields(){
		return true;
	}
	function refresh(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SUserProductsCategories, "GetAllUserCategories",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserProductCategory=list[i];
				listView.append(eUserProductCategory.id, eUserProductCategory.name, "","",0);
			}
		},mShared.userID);
	}
	Component.onCompleted: {
		refresh();
	}
}

