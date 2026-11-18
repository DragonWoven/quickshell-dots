pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.UPower
import "../theme"
import "widgets"

PanelWindow {
	id:topBar
	anchors{
		top: true
		left: true
		right:true
	}
	WorkspaceIndicator{}

	implicitHeight: 30
	color: Colors.background	
	RowLayout {
		anchors {
			right: parent.right
			verticalCenter: parent.verticalCenter
		}	
		Clock{}
		Loader {
			active: UPower.displayDevice.ready && UPower.displayDevice.isLaptopBattery
			sourceComponent: Battery{}

		}
		
	}

	
}
