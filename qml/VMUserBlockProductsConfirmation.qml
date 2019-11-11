import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockProducts"
import "qrc:/BlockProducts"
import "qrc:/"
import "qrc:/mobilefunctions.js" as MobileFunctions

Rectangle {
	id:topWindow
	property int orderNumber:0
	color: enguia.backColor

	VSharedPageTitle{
		id:pageTitle
		title:enguia.tr("Order confirmed")
		btnBackVisible:true
		onSigBtnBackClicked:  mainWindow.popToMenu();
	}
	Rectangle{
		id: rectOrderNumber
		color:"#009688"
		anchors{ left:parent.left;right:parent.right;verticalCenter: parent.verticalCenter}
		height: parent.height*0.3
		Label{
			id: lblOrderNumber
			color:"white"
			anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter}
			font{pointSize: enguia.imenseFontPointSize;bold:true;}
			text: enguia.tr("Order number")+": "+ orderNumber.toString();
		}
	}
	Keys.onPressed:  {//call forceActiveFocus on completed
		if(event.key!==Qt.Key_Back)return;
		event.accepted = true;
		mainWindow.popToMenu();
	}
	Component.onCompleted: {
		topWindow.forceActiveFocus();//required or we don't get key pressed
	}
}

