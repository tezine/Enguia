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
	property int professionalID:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Reports")
		btnDoneVisible: false
	}
	TabView{
		id: tabView
		anchors{top: pageTitle.bottom;bottom: parent.bottom}
		width: parent.width
		style: tabViewStyleAndroid
		Tab{
			title:enguia.tr("Summary");
			VMUserBlockScheduleMngReportSummary{
			}
		}
		Tab{
			title:enguia.tr("Graphic");
			VMUserBlockScheduleMngReportGraphic{
			}
		}
		Tab{
			title:enguia.tr("Text");
			VMUserBlockScheduleMngReportText{
			}
		}
	}
}

