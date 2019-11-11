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
	id: topWindow

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Reports")
		titleLayout.anchors.right: toolBarRowLayout.left
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			/*VMToolButton{
				id: toolAdd
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/add.png"
				onSigClicked: btnAddClicked();
				visible: false
			}*/
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	TabView{
		id: tabView
		anchors{top: pageTitle.bottom;bottom: parent.bottom}
		width: parent.width
		style: tabViewStyleAndroid
		Tab{
			title:enguia.tr("Summary");
			VMBlockProductsProReportsSummary{
			}
		}
		Tab{
			title:enguia.tr("Graphic");
			VMBlockProductsProReportsGraphic{
			}
		}
		Tab{
			title:enguia.tr("Text");
			VMBlockProductsProReportsText{
			}
		}
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockProductsProReports);
		}
	}
}

