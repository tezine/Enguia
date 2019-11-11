import QtQuick 2.0
import QtQuick.Controls 1.3
import com.tezine.enguia 1.0

Label {
    font{pointSize: enguia.mediumFontPointSize;}
	renderType: Text.NativeRendering//nao usar transformation com esse rendertype
}
