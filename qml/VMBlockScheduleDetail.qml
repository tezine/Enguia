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
	property int serviceID:0

	VSharedPageTitle{
		id:pageTitle
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
	}
	VSharedText{
		id: txtArea
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:btnNext.top}
	}
	VSharedButton{
		id: btnNext
		text: enguia.tr("Next (timetable)");
		anchors{left:parent.left;right:parent.right;bottom:parent.bottom}
		onClicked: mainStack.push({item:Qt.resolvedUrl("qrc:///BlockSchedule/VMBlockScheduleDate.qml"),destroyOnPop:true, immediate:true, properties:{serviceID:serviceID} })
	}
	Component.onCompleted:{
		mSVC.metaInvoke(MSDefines.SPlaceServices,"GetService",function(ePlaceService){
			pageTitle.title=ePlaceService.name;
			pageTitle.subtitle=ePlaceService.brief;
			txtArea.setText(ePlaceService.description);
		},serviceID);
	}
}

