import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"

Rectangle {
	property int professionalID:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Services")
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/add.png"
				onSigClicked: btnAddClicked();
			}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	VMBlockScheduleList{
		id: listView
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProServiceEdit.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:professionalID,serviceID:id, serviceName:name}})
		onListItemPressAndHold: listView.showDelete(id)
		onSigBtnDeleteClicked: removeService(id)
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProServices);
		}
	}
	function btnAddClicked(){
		mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleProServiceEdit.qml"),destroyOnPop:true,immediate:true, properties:{professionalID:professionalID}})
	}
	function removeService(id){
		mSVC.metaInvoke(MSDefines.SPlaceServices,"Delete",function(ok){
			statusBar.displayResult(ok,enguia.tr("Service removed successfully"),enguia.tr("Unable to remove service"));
			if(ok)listView.remove(id)
		},id);
	}
	Stack.onStatusChanged: {//carregado no onCodeCompleted e pop
		if(Stack.status!==Stack.Activating)return;
		listView.clear();
		listView.loading=true;		
		mSVC.metaInvoke(MSDefines.SPlaceServices,"GetServicesByProfessional",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var ePlaceService=list[i];
				listView.append(ePlaceService.id, ePlaceService.name, ePlaceService.brief, ePlaceService.description)
			}
		},mShared.placeID,professionalID)
	}
}

