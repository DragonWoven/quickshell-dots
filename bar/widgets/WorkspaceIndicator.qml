pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import "../../theme"
import "../"
Item {
	anchors {
		top: parent.top
		bottom: parent.bottom
	}
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
}

