triggerModelPicker("o3")

on triggerModelPicker(targetModelName)
	tell application "System Events"
		if not (exists process "ChatGPT") then return missing value
		tell process "ChatGPT"
			set frontmost to true
			
			-- ---------- Step 1: Getting Window  ----------
			set focusedWin to my getFocusedWindow()
			if focusedWin is missing value then return missing value
			-- log "found focused window"
			-- ---------- Step 2: Click the Options button ----------
			set optionsBtn to missing value
			set targetGroup to missing value
			try
				set targetGroup to my getMainUIGroup(focusedWin)
				-- if targetGroup is not missing value then log "found targetGroup"
				set optionsBtn to item 1 of (buttons of targetGroup whose value of attribute "AXAttributedDescription" is "Options")
			end try
			if optionsBtn is missing value then return missing value
			perform action "AXPress" of optionsBtn
			-- log "clicked options"
			
			-- ---------- Step 3: Locate the ModelGroup ----------
			set modelsGroup to missing value
			try
				set modelsGroup to scroll area 1 of group 1 of pop over 1 of optionsBtn
			end try
			if modelsGroup is missing value then return missing value
			-- log "found model group"
			
			-- ---------- Step 4: Find & click the more model button  ----------
			
			set moreModelBtn to missing value
			try
				set moreModelBtn to item 1 of (buttons of modelsGroup whose value of attribute "AXAttributedDescription" contains "More models")
			end try
			if moreModelBtn is missing value then return missing value
			perform action "AXPress" of moreModelBtn
			log "clicked more model"
			
			-- Optional: Log all model --
			
			-- set allObjects to buttons of modelsGroup
			-- repeat with obj in allObjects
			-- 	set r to role of obj
			-- 	set n to name of obj
			-- 	log r & " - name: " & n
			-- end repeat
			
			-- ---------- Step 5: Find & click the target model button  ----------
			set targetModelBtn to missing value
			try
				set targetModelBtn to item 1 of (buttons of modelsGroup whose value of attribute "AXAttributedDescription" contains targetModelName)
			end try
			if targetModelBtn is missing value then return missing value
			perform action "AXPress" of targetModelBtn
			-- log "clicked the target model"
		end tell
	end tell
end triggerModelPicker

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
					-- log "Targeting standard window"
					return mainUIGroup
				else if sr is "AXSystemDialog" then
					set mainUIGroup to group 1 of focusedWin
					-- log "Targeting chat dialog window"
					return mainUIGroup
				end if
			on error
				return missing value
			end try
		end tell
	end tell
end getMainUIGroup