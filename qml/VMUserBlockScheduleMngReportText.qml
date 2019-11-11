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
	color:enguia.backColor
	property bool loadingTextReport:false

	ColumnLayout{
		id: grid
		anchors{left:parent.left;right:parent.right;top:parent.top;}
		anchors.margins: enguia.largeMargin;
		spacing: 0
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Service")
		}
		VMComboBox{
			id:comboService
			Layout.fillWidth: true
		}
		Item{
			height: enguia.smallMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Start")
		}
		VMButton{
			id: btnStart
			Layout.fillWidth: true
			onClicked: dlgDate.launchDate(btnStart.dt,1)
		}
		Item{
			height: enguia.smallMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("End")
		}
		VMButton{
			id: btnEnd
			Layout.fillWidth: true
			onClicked: dlgDate.launchDate(btnEnd.dt,2)
		}
		Item{
			height: enguia.smallMargin
		}
		VMButton{
			Layout.fillWidth: true
			text:enguia.tr("Generate")
			onClicked:  generateReport();
		}
		Item{
			height: enguia.smallMargin
		}
	}
	ListModel {
		id: tableModel
	}
	TableView{
		id:tableView
		anchors{left:parent.left;right:parent.right;top:grid.bottom;bottom:parent.bottom;}
		TableViewColumn{ role: "name"  ; title: enguia.tr("Name") ; width: tableView.width*0.45 }
		TableViewColumn{ role: "day"  ; title: enguia.tr("Day") ; width: tableView.width*0.3; }
		TableViewColumn{ role: "count" ; title: enguia.tr("Count") ; width: tableView.width*0.2 }
		model: tableModel
		VSharedListEmptyRect{
			id: loadingFilesRect
			anchors.fill: parent
			visible: tableModel.count===0
			title: loadingTextReport?enguia.tr("Loading..."): enguia.tr("No records");
			z:10
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:parent.top;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:20
	}
	VMDlgDate{
		id: dlgDate
		onSigDateSelected: {
			switch(type){
				case 1://start
					btnStart.fillDate(dt);
					break;
				case 2://end
					btnEnd.fillDate(dt)
					break;
			}
		}
	}
	function addToTable(eTextReport){
		if(eTextReport.count===0)return;
		tableModel.append({name:eTextReport.name, day:Qt.formatDate(eTextReport.day,Qt.SystemLocaleShortDate), count:eTextReport.count})
	}
	function generateReport(){
		var today=new Date();
		tableModel.clear();
		if(btnStart.dt>today){statusBar.displayError(enguia.tr("Invalid start date"));return;}
		if(btnEnd.dt>today){statusBar.displayError(enguia.tr("Invalid end date"));return;}
		if(enguia.convertToDateOnly(btnStart.dt)>enguia.convertToDateOnly(btnEnd.dt)){statusBar.displayError(enguia.tr("Start date must be less than end date"));return;}
		if(enguia.daysTo(btnStart.dt,btnEnd.dt)>95){statusBar.displayError(enguia.tr("3 months maximum allowed"));return;}
		loadingTextReport=true;
		mSVC.metaInvoke(MSDefines.SUserSchedulesReports,"GetTextServicesReport",function(list){
			loadingTextReport=false;
			if(list===undefined)return;
			for(var i=0;i<list.length;i++){
				var eTextReport=list[i];
				addToTable(eTextReport)
			}
		},mShared.userID,comboService.getSelected(),btnStart.dt,btnEnd.dt);
	}
	Component.onCompleted: {
		btnStart.dt=enguia.addMonths(btnStart.dt,-1);
		btnStart.text=Qt.formatDate(btnStart.dt, Qt.SystemLocaleShortDate);
		btnEnd.text=Qt.formatDate(btnEnd.dt, Qt.SystemLocaleShortDate);
		comboService.append(0,enguia.tr("All"))
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserServices,"GetUserServices",function(list){
			loadingRect.visible=false;
			if(list===undefined)return;
			for(var i=0;i<list.length;i++){
				var eService=list[i];
				comboService.append(eService.id,eService.name)
			}
		},mShared.userID);
	}
}

