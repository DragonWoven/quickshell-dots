import QtQuick
import "../../theme"
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
