import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import "../theme"

Rectangle {
	id: shellRoot
	required property LockContext context
	color: Colors.background	

	Label {
		id: clock
		property var date: new Date()

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 100
		}
		color: Colors.primary

		// The native font renderer tends to look nicer at large sizes.
		renderType: Text.NativeRendering
		font.pointSize: 80

		// updates the clock every second
		Timer {
			running: true
			repeat: true
			interval: 1000

			onTriggered: clock.date = new Date();
		}

		// updated when the date changes
		text: {
			const hours = this.date.getHours().toString().padStart(2, '0');
			const minutes = this.date.getMinutes().toString().padStart(2, '0');
			return `${hours}:${minutes}`;
		}
	}

	ColumnLayout {
		// Uncommenting this will make the password entry invisible except on the active monitor.
		// visible: Window.active

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.verticalCenter
		}

		RowLayout {
			TextField {
				id: passwordBox

				implicitWidth: 400
				padding: 10

				focus: true
				enabled: !shellRoot.context.unlockInProgress
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData

				// Update the text in the context when the text in the box changes.
				onTextChanged: shellRoot.context.currentText = this.text;

				// Try to unlock when enter is pressed.
				onAccepted: shellRoot.context.tryUnlock();

				// Update the text in the box to match the text in the context.
				// This makes sure multiple monitors have the same text.
				Connections {
					target: shellRoot.context

					function onCurrentTextChanged() {
						passwordBox.text = shellRoot.context.currentText;
					}
				}
			}

			Button {
				text: "Unlock"
				padding: 10

				// don't steal focus from the text box
				focusPolicy: Qt.NoFocus

				enabled: !shellRoot.context.unlockInProgress && shellRoot.context.currentText !== "";
				onClicked: shellRoot.context.tryUnlock();
			}
		}

		Rectangle {
			visible: shellRoot.context.showFailure
			color: Colors.surfaceContainer
			border.width: 3
			implicitWidth: passwordBox.implicitWidth + 5
			implicitHeight: 30 
			radius: 20
			border.color: Colors.error
			Text {
				anchors.margins: 5
				anchors.left: parent.left
				anchors.bottom: parent.bottom
				anchors.top: parent.top
				color: Colors.error
				text: "Incorrect password"
				font.bold: true
			}
		}
	}
}
