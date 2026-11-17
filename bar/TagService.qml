import Quickshell
import Quickshell.Io

Scope {
	id:tagService
	property string activeTag: "1"
	property var tagsData: []

	Process {
		id:mmsgWatch
		command: ["mmsg", "watch", "all-tags"]
		running: true
		stdout: SplitParser {
			splitMarker: "\n"
			onRead: data => {
				if (!data) return;	
				let parsed = JSON.parse(data).all_tags[0]
				tagService.tagsData = parsed
				// console.log(JSON.stringify(parsed.tags[1].index, null, 2))
				for (const tag of parsed.tags) {
					if(tag.is_active){
						tagService.activeTag = tag.index
						console.log("active index" + tag.index)
					}
				}
				
				
			}  
		}
	}
}
