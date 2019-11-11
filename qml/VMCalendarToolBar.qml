import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Styles"
import "qrc:/Shared"

Rectangle {
	id:toolBar
	color:"#EAEAEA"
	signal sigNextClicked()
	signal sigPreviousClicked()
	property date dt:new Date()
	property bool displayMonthOnly:false
	property alias minimumYear: yearDlg.minimumYear
	signal sigYearChanged(int year);	

	VMImageButton{
		id: btnPrevious
		source: "qrc:///SharedImages/backblack.png"
		anchors{left:parent.left}
		width: parent.height
		height: parent.height
		onSigBtnClicked: sigPreviousClicked()
	}
	Label{
		id: lbl
		font{pointSize: enguia.hugeFontPointSize;bold:true}
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		color: "#484B4E"
		text: displayMonthOnly?Qt.formatDate(dt,"MMMM/yyyy"):  Qt.formatDate(dt,Qt.SystemLocaleShortDate)
		elide: Text.ElideRight
		anchors{left:btnPrevious.right;right: btnNext.left;top:parent.top;bottom:parent.bottom}
		MouseArea{
			anchors.fill: parent
			onClicked: yearDlg.open();
		}
	}
	VMImageButton{
		id: btnNext
		source:"qrc:///SharedImages/nextblack.png"
		anchors{right:parent.right}
		width: parent.height
		height: parent.height
		onSigBtnClicked: sigNextClicked()
	}
	VSharedYearSelectionDlg{
		id: yearDlg
		onSigYearSelected: {
			dt=enguia.setYear(dt,year);
			lbl.text=displayMonthOnly?Qt.formatDate(dt,"MMMM/yyyy"):  Qt.formatDate(dt,Qt.SystemLocaleShortDate)
			sigYearChanged(year);
		}
	}
	function setDate(dt){
		toolBar.dt=dt;
		lbl.text=displayMonthOnly?Qt.formatDate(dt,"MMMM/yyyy"):  Qt.formatDate(dt,Qt.SystemLocaleShortDate)
	}
}

