-- Returns the appropriate ChatGPT window for UI operations:
--  If a window is focused, returns that window.
--  Otherwise, if a chat dialog window exists (AXSystemDialog), returns that.
--  Otherwise, returns the main window (AXStandardWindow).
tell application "System Events"
	if not (exists process "ChatGPT") then return missing value
	tell process "ChatGPT"
		set frontmost to true
		set mainWindow to missing value
		set chatDialogWindow to missing value
		set focusedWindow to missing value
		
		repeat with w in windows
			try
				set sr to subrole of w
			end try
			try
				if value of attribute "AXFocused" of w then
					set focusedWindow to w
				end if
			end try
			if sr is "AXStandardWindow" then
				set mainWindow to w
			else if sr is "AXSystemDialog" then
				set chatDialogWindow to w
			end if
		end repeat
		
		if focusedWindow is not missing value then
			return focusedWindow
		else if chatDialogWindow is not missing value then
			log "targeting chat bar window"
			return chatDialogWindow
		else
			log "targeting standard window"
			return mainWindow
		end if
	end tell
end tell