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
import "qrc:/"

Rectangle {
	color:enguia.backColor
	property int serviceID:0
	property var eUserService: enguia.createEntity("EUserService")

	VMPageTitle{
		id: pageTitle
		title: enguia.tr("Service")
		btnBackVisible:true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		titleLayout.anchors.right: toolBarRowLayout.left
		z:10
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
			}
		}
	}
	Flickable {
		id: flickable
		clip: true
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		contentWidth: parent.width
		contentHeight: grid.height+enguia.height*0.02+enguia.mediumMargin
		ColumnLayout{
			id: grid
			anchors{left:parent.left;right:parent.right;top:parent.top;}
			anchors.margins: enguia.mediumMargin
			spacing: 0
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Name")
			}
			VMTextField{
				id: txtName
				maximumLength: 50
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Brief")
			}
			VMTextField{
				id: txtBrief
				maximumLength: 100
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Price")
			}
			VMTextField{
				id: txtPrice
				inputMethodHints: Qt.ImhFormattedNumbersOnly
				Layout.fillWidth: true
			}
			Item{
				height: enguia.mediumMargin
			}
			VSharedLabelRectCompact{
				Layout.fillWidth: true
				text:enguia.tr("Duration")
			}
			VMTextField{
				id: txtDuration
				inputMethodHints: Qt.ImhFormattedNumbersOnly
				Layout.fillWidth: true
				placeholderText: enguia.tr("in minutes")
			}
			Item{
				height: enguia.mediumMargin
			}
		}
	}
	Rectangle {
		id: scrollbar
		anchors.right: flickable.right
		y: flickable.visibleArea.yPosition * flickable.height
		width: enguia.scrollWidth
		height: flickable.visibleArea.heightRatio * flickable.height
		color: "#BDBDBD"
	}
	function save(){
		Qt.inputMethod.commit();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Type at least 3 characters"));return;}
		Qt.inputMethod.hide();
		var price=0;
		if(txtPrice.text.length>0){
			price=parseFloat(txtPrice.text);
			if(isNaN(price)|| price<0){statusBar.displayError(enguia.tr("Invalid price"));return;}
		}
		eUserService.professionalUserID=mShared.userID;
		eUserService.name=txtName.text;
		eUserService.price=price;
		eUserService.id=serviceID;
		eUserService.brief=txtBrief.text;
		eUserService.duration=parseInt(txtDuration.text);
		mSVC.metaInvoke(MSDefines.SUserServices,"SaveUserService",function(id){
			statusBar.displayResult(id,enguia.tr("Service saved successfully"),enguia.tr("Unable to save service"));
			if(id>0)mainWindow.popWithoutClear();
		},eUserService);
	}
	Component.onCompleted: {
		if(serviceID<1)return;
		mSVC.metaInvoke(MSDefines.SUserServices,"GetUserService",function(eUserService){
			txtName.text=eUserService.name;
			txtBrief.text=eUserService.brief;
			txtDuration.text=eUserService.duration
			txtPrice.text=eUserService.price;
		},serviceID);
	}
}

