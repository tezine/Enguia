import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Styles"
import "qrc:/Shared"

Rectangle{
	color: 'transparent'
	property alias textFieldStyle: textFieldStyleAndroid


	VMTextFieldStyleAndroid{
		id: textFieldStyleAndroid
	}
}
