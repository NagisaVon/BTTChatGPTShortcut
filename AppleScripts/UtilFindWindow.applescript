-- The ChatGPT app can have a main window, usually named "ChatGPT" but could sometimes be different, when no chat bar is open, this would be window 1
-- And when you use the chat bar it will make another system dialog window, this will become the new window 1, and the main window will become window 2

-- Returns the appropriate ChatGPT window for UI operations:
--  If a window is focused, returns that window.
--  Otherwise, if a chat dialog window exists (AXSystemDialog), returns that.
--  Otherwise, returns the main window (AXStandardWindow).
on getFocusedWindow()
    tell application "System Events"
        if not (exists process "ChatGPT") then return missing value
        tell process "ChatGPT"
            set frontmost to true
            set focusedWin to missing value
            set focusedWin to value of attribute "AXFocusedWindow"
            return focusedWin
        end tell
    end tell
end getFocusedWindow


on getMainUIGroup(focusedWin)
	tell application "System Events"
        if not (exists process "ChatGPT") then return missing value
        tell process "ChatGPT"
			try
				set sr to subrole of focusedWin
				if sr is "AXStandardWindow" then
					set mainUIGroup to group 2 of splitter group 1 of group 1 of focusedWin
					log "Targeting standard window"
					return mainUIGroup
				else if sr is "AXSystemDialog" then
					set mainUIGroup to group 1 of focusedWin
					log "Targeting chat dialog window"
					return mainUIGroup
				end if
			on error
				return missing value
			end try
		end tell
	end tell
end getMainUIGroup