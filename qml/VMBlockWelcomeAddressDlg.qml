import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import com.tezine.enguia 1.0
import "qrc:/Components"
import "qrc:/Shared"
import "qrc:/BlockWelcome"

Dialog {
	id: dlg
	visible:false
	modality: Qt.NonModal
	property alias title: titlebar.title
	property alias titleBar:titlebar

	contentItem: Rectangle {
		implicitWidth:enguia.width*0.9
		z:2
		implicitHeight:gridLayout.height+titlebar.height+enguia.height*0.05
		VSharedTitleBar{
			id: titlebar
			anchors{top:parent.top}
			width: parent.width;
			title: enguia.tr("Address")
			cancelText: enguia.tr("Ok");
			saveVisible: false
			onSigCancelClicked: close();
		}
		Flickable {
			id:flickable
			clip: true
			width: parent.width;
			anchors{top:titlebar.bottom;bottom:parent.bottom}
			contentWidth: parent.width
			contentHeight: gridLayout.height+enguia.height*0.02+enguia.mediumMargin
			GridLayout{
				id: gridLayout
				columns:2
				anchors{left:parent.left;right:parent.right;verticalCenter: parent.verticalCenter}
				anchors.margins: enguia.smallMargin;
                VMLabel{
					text:enguia.tr("Address")+": "
				}
                VMLabel{
					id: lblAddress
					Layout.fillWidth: true
					wrapMode: Text.Wrap
				}
                VMLabel{
					text:enguia.tr("Zipcode")+": "
				}
                VMLabel{
					id: lblPostalCode
				}
                VMLabel{
					text:enguia.tr("Phone 1")+": "
				}
                VMLabel{
					id: lblPhone1
				}
                VMLabel{
					text:enguia.tr("Phone 2")+": "
					visible: lblPhone2.text.length>0
				}
                VMLabel{
					id: lblPhone2
					visible: lblPhone2.text.length>0
				}
                VMLabel{
					text:enguia.tr("Phone 3")+": "
					visible: lblPhone3.text.length>0
				}
                VMLabel{
					id: lblPhone3
					visible: lblPhone3.text.length>0
				}
                VMLabel{
					text:enguia.tr("Neighborhood")+": "
				}
                VMLabel{
					id: lblNeighborhood
				}
                VMLabel{
					text:enguia.tr("City region")+": "
				}
                VMLabel{
					id: lblCityRegion
				}
                VMLabel{
					text:enguia.tr("Website")+": "
				}
                VMLabel{
					id: lblWebsite
					font.underline: true
					color: "#42A5F5"
					Layout.fillWidth: true
					wrapMode: Text.Wrap
					MouseArea{
						anchors.fill: parent
						onClicked: enguia.openUrl(lblWebsite.text)
					}
				}
                VMLabel{
					text:enguia.tr("Capacity")+": "
					visible: lblCapacity.text.length>0
				}
                VMLabel{
					id: lblCapacity
					visible: lblCapacity.text.length>0
				}
                VMLabel{
					text:enguia.tr("Structure")+": "
					visible: lblStructure.text.length>0
				}
                VMLabel{
					id: lblStructure
					visible: text.length>0
				}
			}
		}
//		Rectangle {
//			id: scrollbar
//			anchors.right: flickable.right
//			anchors.top: flickable.top;
//			y: flickable.visibleArea.yPosition * flickable.height
//			width: enguia.scrollWidth
//			height: flickable.visibleArea.heightRatio * flickable.height
//			color: "#BDBDBD"
//			z:1
//		}
	}
	function setup(erBlockWelcome){
		lblAddress.text=erBlockWelcome.address
		lblPostalCode.text=erBlockWelcome.postalCode
		lblPhone1.text=erBlockWelcome.phone1;
		lblPhone2.text=erBlockWelcome.phone2;
		lblPhone3.text=erBlockWelcome.phone3;
		lblNeighborhood.text=erBlockWelcome.neighborhood;
		lblCityRegion.text=mShared.getCityRegionName(erBlockWelcome.cityRegionID);
		lblWebsite.text=erBlockWelcome.webSite;
		lblCapacity.text=erBlockWelcome.capacity
		lblStructure.text=erBlockWelcome.structure;
		open();
	}
}

