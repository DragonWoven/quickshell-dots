import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "theme"


Scope {
	id: volumeOSD
	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			console.log("Volume Changed!")
			volumeOSD.shouldShowOSD = true
			hideTimer.restart()
		}

	}
	property bool shouldShowOSD: false
	property bool shouldShowOSDT: false

	Timer {
		id:hideTimer
		interval: 1000
		onTriggered: volumeOSD.shouldShowOSD = false
	}
	LazyLoader {
		active: volumeOSD.shouldShowOSD

		PanelWindow {
			implicitWidth: 400
			implicitHeight: 50
			exclusiveZone: 0
			anchors.bottom: true
			Rectangle {
				anchors.fill: parent
				color: Colors.background
				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}
					Text {
						text: "󰕾"
						color: Colors.primary
						font {
							pixelSize:20
						}


					}
					Rectangle {
						radius: 20
						Layout.fillWidth: true
						implicitHeight: 10
						color: Colors.surfaceContainer
						Rectangle {
							anchors{
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}
							color: Colors.primary
							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
							radius: parent.radius
						}
					}
					Text{
						text: Math.round((Pipewire.defaultAudioSink?.audio.volume ?? 0) * 100) + "%"
						color: Colors.primary
					}

				}
			}
		}
	}
}
