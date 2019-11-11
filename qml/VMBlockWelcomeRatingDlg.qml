import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockWelcome"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	property alias title: titlebar.title
	property alias titleBar:titlebar

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.8
		implicitHeight:gridLayout.height+titlebar.height+enguia.height*0.05
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Rating")
			cancelText: enguia.tr("Ok");
			saveVisible: false
			onSigCancelClicked: close();
		}
		GridLayout{
			id: gridLayout
			columns:2
			anchors{top:titleBar.bottom;left:parent.left;right:parent.right;}
			anchors.margins: enguia.mediumMargin
             VMLabel{
				 text:enguia.tr("Unique views count")+": "
			 }
             VMLabel{
				 id: lblViewCount
			 }
             VMLabel{
				 text:enguia.tr("Qualifications received")+": "
			 }
             VMLabel{
				 id: lblTotalQualifications
			 }
             VMLabel{
				 text:enguia.tr("Positive qualifications")+": "
			 }
             VMLabel{
				 id: lblPositiveQualifications
			 }
             VMLabel{
				 text:enguia.tr("Negative qualifications")+": "
			 }
             VMLabel{
				 id: lblNegativeQualifications
			 }
		}
	}
	function setup(erBlockWelcome){
		var totalQualifications=erBlockWelcome.positiveCount+erBlockWelcome.negativeCount;
		lblViewCount.text=erBlockWelcome.viewCount
		lblTotalQualifications.text=totalQualifications;
		if(totalQualifications>0){
			lblPositiveQualifications.text=parseInt(100*erBlockWelcome.positiveCount/totalQualifications)+"%";
			lblNegativeQualifications.text=parseInt(100*erBlockWelcome.negativeCount/totalQualifications)+"%";
		}else{
			lblPositiveQualifications.text=0;
			lblNegativeQualifications.text=0;
		}

		open();
	}
}
