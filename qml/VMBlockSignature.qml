import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.2
//import "qrc:///Scripts/Defines.js" as Defines
import QtQuick.Window 2.0
import com.tezine.enguia 1.0
import "qrc:/BlockSignature"

Rectangle {
	width: 360
	height: 360
	border.color: "#094bb4"
	border.width: 2
	property int xpos
	property int ypos
	property int oldXPos
	property int oldYPos
	property int blockID:0

	Canvas {
		id: myCanvas
		anchors.fill: parent
		renderStrategy: Canvas.Threaded

		onPaint: {
			var ctx = getContext('2d')
			ctx.fillStyle = "black"
			ctx.beginPath();
			ctx.moveTo(oldXPos, oldYPos);
			ctx.lineTo(xpos, ypos);
			ctx.strokeStyle = 'black';
			ctx.lineWidth = 3;
			ctx.stroke();
			ctx.closePath();
			oldXPos=xpos;
			oldYPos=ypos;
		}

		MouseArea{
			anchors.fill: parent
			onPressed: {
				oldXPos= xpos = mouseX
				oldYPos= ypos = mouseY
				myCanvas.requestPaint()
			}
			onMouseXChanged: {
				xpos = mouseX
				ypos = mouseY
				myCanvas.requestPaint()
			}
			onMouseYChanged: {
				xpos = mouseX
				ypos = mouseY
				myCanvas.requestPaint()
			}
		}

	}
	function limpar(){
		var ctx = myCanvas.getContext('2d');
		ctx.save();
		ctx.setTransform(1, 0, 0, 1, 0, 0);
		ctx.clearRect(0, 0, myCanvas.width, myCanvas.height);
		ctx.restore();
		myCanvas.requestPaint();
	}
	function isCanvasEmpty() { // true if all pixels Alpha equals to zero
		var ctx = myCanvas.getContext('2d');
		var imageData=ctx.getImageData(0,0,myCanvas.width,myCanvas.height);
		for(var i=0;i<imageData.data.length;i+=4)
			if(imageData.data[i+3]!==0)return false;
		return true;
	}
	function save(completePath){
		return myCanvas.save(completePath);
	}
}
