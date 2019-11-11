import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
	id:topWindow
	property int blockID:0
	property bool hasManyProfessionals:false
	property bool listingProfessionals:false

    VSharedPageTitle{
        id:pageTitle
        btnBackVisible: true
		onSigBtnBackClicked: btnBackClicked()
		title:enguia.tr("Schedule")
    }
	VMBlockScheduleList{
		id: listView
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		onListItemClicked: {
			if(!listingProfessionals){
				if(description.length>0)mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleDetail.qml"),destroyOnPop:true, immediate:true, properties:{serviceID:id} })
				else mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleDate.qml"),destroyOnPop:true,  immediate:true, properties:{serviceID:id} })
			}else{//now we have to list the services the professional attend
				getServices(id)
			}
		}
	}
	Keys.onPressed:  {//call forceActiveFocus on completed
		if(event.key!==Qt.Key_Back)return;
		event.accepted = true;
		btnBackClicked()
	}
	function btnBackClicked(){
		if(hasManyProfessionals && (!listingProfessionals))getProfessionals();
		else mainWindow.popOneLevel();
	}
	function getServices(professionalID){
		listView.clear();
		listView.loading=true;
		pageTitle.subtitle= enguia.tr("Select the service below")
		mSVC.metaInvoke(MSDefines.SPlaceServices,"GetServicesByProfessional",function(list){
			listView.loading=false;
			listingProfessionals=false;
			for(var i=0;i<list.length;i++){
				var ePlaceService=list[i];
				listView.append(ePlaceService.id, ePlaceService.name, ePlaceService.brief, ePlaceService.description)
			}
		},mShared.placeID,professionalID)
	}
	function getProfessionals(){
		listView.clear();
		listView.loading=true;
		mSVC.metaInvoke(MSDefines.SPlaceScheduleProfessionals,"GetProfessionals",function(list){
			if(list.length===1){getServices(list[0].id);return;}
			hasManyProfessionals=true;
			listView.loading=false;
			pageTitle.subtitle=enguia.tr("Select a professional below")
			listingProfessionals=true;
			for(var i=0;i<list.length;i++){
				var eProfessional=list[i];
				listView.append(eProfessional.id, eProfessional.name, eProfessional.brief,"")
			}
		},blockID);
	}
	Component.onCompleted: {
		topWindow.forceActiveFocus();//required or we don't get key pressed
		getProfessionals();
		/*nao e usado por enquanto mSVC.metaInvoke(MSDefines.SBlockSchedule,"GetRuntimeBlockSchedule",function(e){
			if(e===undefined)return;
			MobileFunctions.eRBlockSchedule=enguia.createEntity("ERBlockSchedule");
			enguia.copyValues(e,MobileFunctions.eRBlockSchedule);
		},blockID);*/
	}
}
