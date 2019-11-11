import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockSchedule"

Rectangle {
	property int professionalID:0
	property int serviceID:0
	property string serviceName:""
	property var eService: enguia.createEntity("EPlaceService");
	color: enguia.backColor

	VMPageTitle{
		id:pageTitle
		btnBackVisible: true
		onSigBtnBackClicked: mainWindow.popOneLevel();
		title:enguia.tr("Service")
		btnDoneVisible: false
		//subtitle:serviceName
		RowLayout{
			id:toolBarRowLayout
			anchors{right:parent.right;top:parent.top;bottom:parent.bottom;}
			VMToolButton{
				id: toolSave
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///Images/save.png"
				onSigClicked: save();
				visible: true
			}
			VMToolButton{
				id: toolMenu
				Layout.fillHeight: true
				Layout.preferredWidth: height
				source: "qrc:///SharedImages/overflow.png"
				onSigClicked: overflowMenu.popup();
			}
		}
	}
	ColumnLayout{
		id: grid
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
		anchors.margins: enguia.largeMargin;
		spacing: 0
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Service name")
		}
		VMTextField{
			id: txtName
			Layout.fillWidth: true
			maximumLength: 200
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
			Layout.fillWidth: true
			placeholderText: enguia.tr("one line only")
			maximumLength: 300
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
			Layout.fillWidth: true
			inputMethodHints: Qt.ImhPreferNumbers
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
			Layout.fillWidth: true
			placeholderText: enguia.tr(" in minutes")
			inputMethodHints: Qt.ImhPreferNumbers
		}
		Item{
			height: enguia.mediumMargin
		}
		VSharedLabelRectCompact{
			Layout.fillWidth: true
			text:enguia.tr("Description")
		}
		TextArea{
			id: txtDescription
			font{pointSize: enguia.largeFontPointSize;}
			Layout.fillWidth: true
			Layout.fillHeight: true
		}
	}
	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	Menu{
		id: overflowMenu
		MenuItem{
			text: enguia.tr("Help")
			onTriggered: dlgHelp.setup(MSDefines.HelpTypeMobileBlockScheduleProServiceEdit);
		}
	}
	function save(){
		Qt.inputMethod.commit();
		Qt.inputMethod.hide();
		if(txtName.text.length<3){statusBar.displayError(enguia.tr("Invalid name"));return;}
		var duration=parseInt(txtDuration.text);
		if(isNaN(duration)|| duration<1 || duration>720){statusBar.displayError(enguia.tr("Invalid duration"));return;}
		var price=0;
		if(txtPrice.text.length>0){
			price=parseFloat(txtPrice.text);
			if(isNaN(price)|| price<0){statusBar.displayError(enguia.tr("Invalid price"));return;}
		}
		eService.placeID=mShared.placeID;
		eService.professionalID=professionalID;
		eService.name=txtName.text;
		eService.brief=txtBrief.text
		eService.description=txtDescription.text
		eService.price=price;
		eService.duration=duration;
		mSVC.metaInvoke(MSDefines.SPlaceServices,"SaveWithDefaultTimetable",function(id){
			statusBar.displayResult(id,enguia.tr("Service saved successfully"),enguia.tr("Unable to save service"));
			if(id>0)mainWindow.popWithoutClear();
		},enguia.convertObjectToJson(eService));
	}
	Component.onCompleted: {
		if(serviceID===0)return;
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SPlaceServices,"GetService",function(e){
			loadingRect.visible=false;
			enguia.copyValues(e,eService);
			txtName.text=e.name;
			txtBrief.text=e.brief;
			if(e.price>0)txtPrice.text=e.price
			txtDuration.text=e.duration;
			txtDescription.text=e.description;
		},serviceID);
	}
}

