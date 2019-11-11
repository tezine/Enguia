import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/Styles"
import "qrc:/UserBlockText"
import "qrc:/"

Rectangle {


	VMListEmptyRect{
		id: loadingRect
		anchors{left:parent.left;right:parent.right;top:parent.top;bottom:parent.bottom}
		visible: false
		title: enguia.tr("Loading...")
		z:10
	}
	function saveFields(){
		return true;
	}
	Component.onCompleted: {
		loadingRect.visible=true;
		mSVC.metaInvoke(MSDefines.SUserBlockText,"GetUserBlockTextByID",function(e){
			loadingRect.visible=false;

		},blockID);
	}
}

