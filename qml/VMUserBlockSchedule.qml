import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockSchedule"
import "qrc:/BlockSchedule"
import "qrc:/"

Rectangle {
	id:topWindow
	property int blockID:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Schedule")
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
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
		onListItemClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///UserBlockSchedule/VMUserBlockScheduleDate.qml"),destroyOnPop:true,  immediate:true, properties:{serviceID:id} })
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileUserBlockSchedule);
		}
	}
	function getServices(){
		listView.clear();
		listView.loading=true;
		pageTitle.subtitle= enguia.tr("Select the service below")
		mSVC.metaInvoke(MSDefines.SUserServices,"GetUserServices",function(list){
			listView.loading=false;
			for(var i=0;i<list.length;i++){
				var eUserService=list[i];
				listView.append(eUserService.id, eUserService.name, eUserService.brief, eUserService.description)
			}
		},mShared.otherUserID);
	}
	Component.onCompleted: {
		topWindow.forceActiveFocus();//required or we don't get key pressed
		getServices();
		/*nao e usado por enquanto mSVC.metaInvoke(MSDefines.SBlockSchedule,"GetRuntimeBlockSchedule",function(e){
			if(e===undefined)return;
			MobileFunctions.eRBlockSchedule=enguia.createEntity("ERBlockSchedule");
			enguia.copyValues(e,MobileFunctions.eRBlockSchedule);
		},blockID);*/
	}
}

