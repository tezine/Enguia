import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
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


Dialog {
	id: dlgBase
	visible:false
	property alias title: titlebar.title
	property alias titleBar:titlebar
	property alias saveVisible: titlebar.saveVisible
	property date dtStart: new Date()
	property int type:0
	signal sigDateSelected(date dt,int type)
	width: enguia.width
	height: enguia.height

	contentItem: Rectangle {
		implicitWidth: enguia.width
		implicitHeight: enguia.height
		VMDlgTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Date selection");
			onSigCancelClicked: close();
			saveVisible: false
		}
		VMCalendarToolBar{
			id: calendarToolBar
			height: enguia.height*0.07
			displayMonthOnly: true
			anchors{left:parent.left; right:parent.right;top:titlebar.bottom}
			onSigYearChanged: {
				var dt=calendar.selectedDate;
				dt.setFullYear(year);
				dlgBase.setDate(dt)
			}
			onSigNextClicked: {
				var dt=enguia.addMonths(calendar.selectedDate,1);
				dlgBase.setDate(dt)
			}
			onSigPreviousClicked: {
				var dt=enguia.addMonths(calendar.selectedDate,-1);
				dlgBase.setDate(dt)
			}
		}
		Calendar {
			id: calendar
			navigationBarVisible:false
			//style: calendarStyleAndroid
			anchors{left:parent.left; right:parent.right; top:calendarToolBar.bottom; bottom:parent.bottom}
			selectedDate: new Date()
			focus: true
			onClicked: {
				sigDateSelected(selectedDate,type);
				close();
			}
		}
	}
	function setDate(dt){
		if(dt===null)return;
		calendar.selectedDate=dt;
		calendarToolBar.setDate(dt);
	}
	function launchDate(dt, type){
		this.type=type;
		dlgBase.setDate(dt)
		open();
	}
}
