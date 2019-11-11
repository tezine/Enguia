import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/BlockSchedule"

Rectangle {
	property int professionalID:0

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Reports")
		btnDoneVisible: false
//		RowLayout{
//			id:toolBarRowLayout
//			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
//			VMToolButton{
//				id: toolSave
//				Layout.fillHeight: true
//				Layout.preferredWidth: height
//				source: "qrc:///Images/save.png"
//				onSigClicked: save();
//				visible: true
//			}
//			VMToolButton{
//				id: toolMenu
//				Layout.fillHeight: true
//				Layout.preferredWidth: height
//				source: "qrc:///SharedImages/overflow.png"
//				onSigClicked: overflowMenu.popup();
//			}
//		}
	}
	TabView{
		id: tabView
		anchors{top: pageTitle.bottom;bottom: parent.bottom}
		width: parent.width
		style: tabViewStyleAndroid
		Tab{
			title:enguia.tr("Summary");
			VMBlockScheduleProReportSummary{
			}
		}
		Tab{
			title:enguia.tr("Graphic");
			VMBlockScheduleProReportGraphic{
			}
		}
		Tab{
			title:enguia.tr("Text");
			VMBlockScheduleProReportText{
			}
		}
	}
}

