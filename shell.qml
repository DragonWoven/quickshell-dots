import Quickshell
import QtQuick
import Quickshell.Io
import "bar"
import "lockscreen"
import Quickshell.Wayland

ShellRoot {
	id: root
	property bool barActive: true
	
	IpcHandler{
		target: "bar"
		function refresh(): void {
			root.barActive = false
			barRefreshTimer.restart()
			

		}
	}

	Timer{
		id: barRefreshTimer
		interval: 150
		onTriggered: root.barActive = true;
	}

	Loader {
		active: root.barActive
		source: "bar/TopBar.qml"
	}
	VolumeOSD{}
	LockShell{}

}
