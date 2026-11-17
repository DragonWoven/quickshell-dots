import QtQuick
import "../../theme/"
import Quickshell.Services.UPower
import Quickshell
Rectangle{	
			id: batteryPill
		implicitWidth: battery.implicitWidth + 16
		implicitHeight: 21
		color: Colors.surfaceContainer
		radius: 13
		Text {
			id: battery
			anchors.centerIn: parent
			visible: UPower.displayDevice.isPresent
			color: Colors.primary
			text: {
			    var batteryPercent = Math.floor(UPower.displayDevice.percentage * 100);
			    if (batteryPercent >= 90)
				return "";
			    if (batteryPercent >= 70)
				return "";
			    if (batteryPercent >= 40)
				return "";
			    if (batteryPercent >= 20)
				return "   " + batteryPercent +"%"
			    return "   " + batteryPercent + "%";
			}
			font {
				pixelSize: 13
			}
		    }
		Text {
                anchors.centerIn: parent
		anchors.horizontalCenterOffset: {
			var batteryPercent = Math.floor(UPower.displayDevice.percentage * 100)
		
			if (batteryPercent >= 40)
				return -1;
			if (batteryPercent < 10)
				return -11;

			return -15
		} // Fine-tune position
                color: Colors.success
                text: "󱐌"
                font.pixelSize: 12 // Make it slightly smaller to fit "inside"
                visible: UPower.displayDevice.state === 1	
            	}
		MouseArea {
			id: batteryMouseArea
			anchors.fill: parent
			hoverEnabled: true
		}
		PopupWindow {
			id: batteryPopup
			visible: batteryMouseArea.containsMouse

			anchor.window: topBar
			anchor.rect.x: batteryPill.mapToItem(null, 0, 0).x + (batteryPill.width / 2) - (width / 2)
			anchor.rect.y: topBar.height

			implicitWidth: popupText.implicitWidth + 20
			implicitHeight: popupText.implicitHeight + 10
			color: "transparent"

			Rectangle {
			    anchors.fill: parent
			    color: Colors.surfaceContainer
			    radius: 10
			    border.color: Colors.primary
			    border.width: 1

			    Text {
				id: popupText
				anchors.centerIn: parent
				text: "Battery: " + Math.floor(UPower.displayDevice.percentage * 100) + "%"
				color: Colors.primary
				font.pixelSize: 12
			    }
			}
    		}	}
