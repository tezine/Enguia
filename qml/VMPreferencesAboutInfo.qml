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

Rectangle{
    anchors.fill:parent

    Rectangle{
		//border.width: 1
		//border.color: "black"
        anchors{ verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
        width: parent.width
		height: lblAbout.height
        Text{
            id: lblAbout
			anchors{top: parent.top; left:parent.left;right:parent.right}
			font{pointSize:enguia.largeFontPointSize;bold: true}
			text: qsTr("Copyright 2015 Tezine Technologies")
			horizontalAlignment: Text.AlignHCenter
			wrapMode: Text.Wrap
        }
		/*Text{
            id: lblFeedBack
            anchors{ top:lblAbout.bottom; left: lblAbout.left}
            font{pointSize: enguia.tinyFontPointSize}
            text: qsTr("Please send feedbacks to contact@tezine.com")
		}*/
    }

}
