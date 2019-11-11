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
import "qrc:/"

Rectangle {
	TextArea{
		id: txtDescription
		anchors.fill: parent
		font{pointSize: enguia.largeFontPointSize}
		visible: true
	}
	function saveFields(){
		if(txtDescription.text.length>5000){statusBar.displayError(enguia.tr("Description is limited to 5000 characters"));return false;}
		if(txtDescription.text.length<1){statusBar.displayError(enguia.tr("Type the description"));return false;}
		eUserProduct.description=txtDescription.text;
		return true;
	}
	Component.onCompleted: {
		txtDescription.text=eUserProduct.description;
	}
}

