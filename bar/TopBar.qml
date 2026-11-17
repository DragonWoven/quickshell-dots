pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.UPower
import "../theme"

PanelWindow {
	id:topBar
	anchors{
		top: true
		left: true
		right:true
	}
	implicitHeight: 30
	color: Colors.background
	TagService{
		id:tags
	}
	RowLayout{
		anchors {
			top: parent.top
			bottom: parent.bottom
		}
		Repeater {
		model:9
		Text {
			required property int index
			property string targetNum: (index+1).toString()
			property bool isActive: tags.activeTag == targetNum
			property bool ws: tags.tagsData.tags[index].client_count > 0;
			style: Text.Outline
			styleColor: "black"
			color: isActive ? Colors.primary : (ws ? Colors.surfaceContainer : Colors.background)
			text: targetNum
			font {
				pixelSize: 14
				bold: true
			}
		}
	}

	}
	RowLayout {
		anchors {
			right: parent.right
			verticalCenter: parent.verticalCenter
		}
		Rectangle {
			implicitHeight: 21
			implicitWidth: clock.implicitWidth + 12
			radius: 13
			color: Colors.surfaceContainer
			Text {
				id: clock
				anchors.centerIn: parent

				color: Colors.primary
				text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")

				Timer {
					interval: 1000
					running: true
					repeat: true
					onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - hh:mm AP")
				    }
				}
		}
		
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
	}

	
}
