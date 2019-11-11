import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/BlockProducts"

Rectangle {
	property date currentDate:new Date();
	property date today:new Date();
	property bool loading:false

	VMCalendarToolBar{
		id: calendarToolBar
		height: enguia.height*0.07
		displayMonthOnly: true
		anchors{left:parent.left; right:parent.right;top:parent.top;}
		onSigNextClicked: {
			setCurrentDate(enguia.addMonths(currentDate,1));
			getSummary(currentDate);
		}
		onSigPreviousClicked: {
			setCurrentDate(enguia.addMonths(currentDate,-1));
			getSummary(currentDate);
		}
	}
	ListModel {
		id: summaryModel
	}
	TableView{
		id:tableView
		anchors{left:parent.left;right:parent.right;top:calendarToolBar.bottom;bottom:parent.bottom}
		TableViewColumn{ role: "key"  ; title: enguia.tr("Property") ; width: tableView.width*0.8 }
		TableViewColumn{ role: "content" ; title: enguia.tr("Value") ; width: tableView.width*0.15 }
		model: summaryModel
		VSharedListEmptyRect{
			id: loadingFilesRect
			anchors.fill: parent
			visible: summaryModel.count===0
			title: loading?enguia.tr("Loading..."): enguia.tr("No records");
			z:10
		}
	}
	function addToTable(key, value){
		summaryModel.append({key:key, content:value})
	}
	function setCurrentDate(dt){
		if(dt>today)return;
		calendarToolBar.dt=dt;
		currentDate=dt;
	}
	function getSummary(dt){
		summaryModel.clear();
		loading=true;
		mSVC.metaInvoke(MSDefines.SReports,"GetOrdersProSummary",function(list){
			loading=false;
			for(var i=0;i<list.length;i++){
				var ePropValue=list[i]
				addToTable(enguia.getPropertyName(ePropValue.property), ePropValue.value)
			}
		},mShared.placeID,currentDate);
	}
	Component.onCompleted: {
		getSummary(currentDate)
	}
}

