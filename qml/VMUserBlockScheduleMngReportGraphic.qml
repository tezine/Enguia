import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import QtCharts 2.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockSchedule"
import "qrc:/BlockSchedule"
import "qrc:/"

Rectangle {
	color:enguia.backColor

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
			id: comboService
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
	}
	ChartView {
		id:chartView
		anchors{left:parent.left;right:parent.right;top:grid.bottom;bottom:parent.bottom;}
		antialiasing: true
		ValueAxis {
			id: valueAxisX
			visible: false
			min: 0
			max: 12
		}
		ValueAxis{
			id: valueAxisY
			min: 0
			max: 15
		}
		DateTimeAxis{
			id:dateTimeAxis
			 format: "yyyy MMM"
			tickCount: 5
		}
		LineSeries {
			id:lineSeries
			visible: false
			axisX: valueAxisX
			axisY: valueAxisY
			onClicked: {

			}
		}
		VSharedListEmptyRect{
			id: loadingChart
			anchors.fill: parent
			visible: false
			title: enguia.tr("Loading...")
			z:10
		}
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
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:parent.top;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:20
	}
	function getMaxValue(list){
		if(!list || list.length===0)return 0;
		var max=0;
		for(var i=0;i<list.length;i++){
			if(list[i].count>max)max=list[i].count
		}
		return max
	}
	function generateReport(){
		var today=new Date();
		if(btnStart.dt>today){statusBar.displayError(enguia.tr("Invalid start date"));return;}
		if(btnEnd.dt>today){statusBar.displayError(enguia.tr("Invalid end date"));return;}
		if(enguia.convertToDateOnly(btnStart.dt)>enguia.convertToDateOnly(btnEnd.dt)){statusBar.displayError(enguia.tr("Start date must be less than end date"));return;}
		if(enguia.daysTo(btnStart.dt,btnEnd.dt)>95){statusBar.displayError(enguia.tr("3 months maximum allowed"));return;}
		lineSeries.clear();
		lineSeries.name=enguia.tr("Service report")
		valueAxisY.titleText=enguia.tr("Appointments")
		loadingChart.visible=true;
		mSVC.metaInvoke(MSDefines.SUserSchedulesReports,"GetGraphicServiceReport",function(list){
			loadingChart.visible=false;
			lineSeries.visible=true
			if(list.length<1)return;
			var maxValue=getMaxValue(list);
			if(maxValue===0)return;
			valueAxisY.max=maxValue
			valueAxisX.max=list.length;
			lineSeries.append(0,0);
			for(var i=0;i<list.length;i++){
				var eGraphReportPoint=list[i];
				lineSeries.append(i+1, eGraphReportPoint.count)
			}
		},mShared.userID,btnStart.dt,btnEnd.dt,comboService.getSelected());
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

