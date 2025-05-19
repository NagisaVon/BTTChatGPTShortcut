
tell application "System Events"
	tell process "ChatGPT"
		set frontmost to true
		perform action "AXPress" of button 7 of group 2 of splitter group 1 of group 1 of window "ChatGPT"
	end tell
end tell



