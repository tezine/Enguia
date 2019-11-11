import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockProducts"
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
	height: grid.height
	width: parent.width
	property date collectDate: enguia.addDays(new Date(),1);
	property date deliveryDate: enguia.addDays(new Date(),2);
	color: enguia.buttonNormalColor

	GridLayout{
		id: grid
		columns: 3
		rowSpacing: 0
		columnSpacing: 0
		height: btnCollect.height+btnDeliver.height
		anchors{left:parent.left;leftMargin: enguia.mediumMargin;right:parent.right}
		VMLabel{
			id: lblStartDate
			color: "white"
			text: enguia.tr("Collection date")+":"
		}
		VMButton{
			id: btnCollect
			Layout.fillWidth: true
			text:Qt.formatDate(collectDate,Qt.DefaultLocaleShortDate)
			onClicked: dlgDate.launchDate(collectDate,1)
		}
		VMComboBox{
			id: comboCollect
			Layout.preferredWidth: parent.width*0.3
		}
		VMLabel{
			id: lblEndDate
			color: "white"
			text: enguia.tr("Delivery date")+":"
		}
		VMButton{
			id: btnDeliver
			text:Qt.formatDate(deliveryDate,Qt.DefaultLocaleShortDate)
			Layout.fillWidth: true
			onClicked: dlgDate.launchDate(deliveryDate,2)
		}
		VMComboBox{
			id: comboDeliver
			Layout.preferredWidth: parent.width*0.3
		}
	}
	VMDlgDate{
		id: dlgDate
		onSigDateSelected: {
			switch(type){
				case 1://collect
					collectDate=dt;
					btnCollect.text=Qt.formatDate(collectDate,Qt.DefaultLocaleShortDate)
					break;
				case 2://delivery
					deliveryDate=dt;
					btnDeliver.text=Qt.formatDate(deliveryDate,Qt.DefaultLocaleShortDate)
					break;
			}
		}
	}
	function getCollectPeriod(){
		return comboCollect.getSelected();
	}
	function getDeliveryPeriod(){
		return comboDeliver.getSelected();
	}
	Component.onCompleted: {
		comboCollect.append(MSDefines.DayPeriodMorning,enguia.tr("Morning"));
		comboCollect.append(MSDefines.DayPeriodAfternoon,enguia.tr("Afternoon"));

		comboDeliver.append(MSDefines.DayPeriodMorning,enguia.tr("Morning"));
		comboDeliver.append(MSDefines.DayPeriodAfternoon,enguia.tr("Afternoon"));
	}
}

