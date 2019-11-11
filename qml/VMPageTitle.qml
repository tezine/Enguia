import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
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

Rectangle{
	id:pageTitle
    width: parent.width
	height: enguia.screenHeight*0.08
    //antigocolor: "#5958a2"
    color: "#01579B"
    property alias title: lblTitle.text
	property alias busy: indicator1.visible
    property alias subtitle: lblSubTitle.text
    property alias btnDoneVisible: toolDone.visible
    property alias btnCancelVisible: toolCancel.visible
    property alias accountName: lblAccountName.text
    property alias lblAccountVisible: lblAccountName.visible
    property alias busyIndicator: indicator1
    property alias btnBackVisible: btnBack.visible
    property alias btnDoneEnabled: toolDone.enabled
    property alias btnCancelEnabled: toolCancel.enabled
    property alias lblTitle: lblTitle
	property alias titleLayout:columnLayout
	property alias btnDone: toolDone;
    signal cancelled()
    signal done()
    signal sigBtnBackClicked();

	VMToolButton{
        id: btnBack
        source: "qrc:///Images/back.png"
        onSigClicked: sigBtnBackClicked();
        visible:false;
    }
	ColumnLayout{
		id: columnLayout
		anchors{left:btnBack.right;verticalCenter:parent.verticalCenter}
		spacing: 0
		Text{
			id: lblTitle
			text: ''
			color: 'white'
			font{pointSize: enguia.imenseFontPointSize;bold: true}
			verticalAlignment: Text.AlignVCenter
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignVCenter
			elide: Text.ElideRight
			renderType: Text.NativeRendering//nao usar transformation com esse rendertype
		}
		Text{
			id: lblSubTitle
			text:""
			color: "white"
			visible: text.length>0
			renderType: Text.NativeRendering//nao usar transformation com esse rendertype
			onTextChanged: {//let's resize pagetitle
				if(text.length<1)return;
				var itensHeight=lblTitle.height+lblSubTitle.height
				if(itensHeight>pageTitle.height)pageTitle.height=itensHeight
			}
		}
	}
    BusyIndicator{
        id: indicator1
        running: true
        anchors{right: parent.right;}
        height:parent.height
        width:parent.height;
        visible: false
    }
	VMToolButton{
        id: lblAccountName
        text: qsTr("barcelona")
        anchors{verticalCenter: parent.verticalCenter;right: parent.right;rightMargin: enguia.smallMargin}
        visible: false
        //onClicked: mData.push(MData.PageTypePreferencesCity)
    }
	VMToolButton{
        id: toolCancel
        anchors{right: toolDone.left;verticalCenter: parent.verticalCenter}
        source: "qrc:///Images/back.png"
        visible: false
        onSigClicked: cancelled()
    }
	VMToolButton{
        id: toolDone
        anchors{right: parent.right;verticalCenter: parent.verticalCenter}
        source: "qrc:///Images/save.png"
        visible: false
        onSigClicked: done()
    }
	Component.onCompleted: {
		var itensHeight=columnLayout.height
		if(itensHeight>pageTitle.height)pageTitle.height=itensHeight
	}
}

