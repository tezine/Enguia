import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
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

Rectangle {
	property int id:0
	property string placeName:""
	property int placeID:0
	property int historyType:0
	property string title:""
	property date dateInserted:new Date();
	color:enguia.backColor

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Qualify")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		btnDoneVisible: true
		onDone: qualifyPlace();
	}
	Rectangle{
		id: rect
		anchors{top:pageTitle.bottom; left:parent.left;right:parent.right;}
		height: columnLayout.height+2*enguia.mediumMargin
		color:enguia.backColor
		ColumnLayout{
			id: columnLayout
			anchors{verticalCenter: parent.verticalCenter;leftMargin: enguia.mediumMargin;rightMargin: enguia.mediumMargin;right: parent.right;left: parent.left}
			VSharedLabel{
				id: lblPlaceName
				font{pointSize: enguia.hugeFontPointSize; bold: true}
				Layout.fillWidth: true;
				color: "#484B4E"
				text: placeName
			}
			VSharedLabel{
				id: lblTypeName
				Layout.fillWidth: true;
				color:  "#484B4E"
				text: title
			}
			VSharedLabel{
				id: lblDt
				Layout.fillWidth: true;
				color: "#484B4E"
				text: Qt.formatDate(dateInserted, Qt.SystemLocaleShortDate);
			}
		}
	}
	VSharedRatingSelection{
		id: indicator
		color:enguia.backColor
		height: enguia.height*0.05
		width: enguia.width*0.5
		rating: 10
		anchors{top:rect.bottom;horizontalCenter: parent.horizontalCenter}
	}
	VSharedLabelRect{
		id: rectComment
		anchors{left:parent.left;right:parent.right;top:indicator.bottom;}
		horizontalAlignment: Text.AlignHCenter
		text:enguia.tr("Comments")
	}
	TextArea{
		id: textArea
		inputMethodHints: Qt.ImhNoPredictiveText
		font{pointSize: enguia.largeFontPointSize;}
		anchors{left:parent.left;right:parent.right;top:rectComment.bottom;bottom:parent.bottom;}
	}
	function qualifyPlace(){
		statusBar.visible=false;
		Qt.inputMethod.hide();
		if(textArea.text.length<3){statusBar.displayError(enguia.tr("Invalid comment"));return;}
		if(textArea.text.length>200){statusBar.displayError(enguia.tr("Comment is limited to 200 characters"));return;}
		mSVC.metaInvoke(MSDefines.SUserQualifications,"QualifyPlace", function(ok){
			statusBar.displayResult(ok,enguia.tr("Qualification sent successfully"),enguia.tr("Unable to send qualification"));
			mainWindow.popWithoutClear();
		},placeID, mShared.userID, historyType, id, indicator.rating,textArea.text)
	}
}

