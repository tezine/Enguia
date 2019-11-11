import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockText"

Rectangle {
    color:"#3f3f3f"
	property int blockID:0

	VMPageTitle{
        id:pageTitle
		title: ""
        btnBackVisible:true
        onSigBtnBackClicked: mainWindow.popOneLevel();
        VSharedToolButton{
			id: btnNext
            anchors{right:parent.right}
            source: "qrc:///SharedImages/next.png"
			visible: false
        }
    }
	TextArea{
		id:txtArea
		readOnly: true
		font{pointSize: enguia.largeFontPointSize;}
		anchors{left:parent.left;right:parent.right;top:pageTitle.bottom;bottom:parent.bottom;}
	}
    Component.onCompleted: {
		mSVC.metaInvoke(MSDefines.SBlockText,"GetByID",function(eBlockText){
			pageTitle.title=eBlockText.title;
			txtArea.text=eBlockText.txt
		},blockID);
    }
}

