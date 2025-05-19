on triggerModelPicker(targetModelName)
	tell application "System Events"
		if not (exists process "ChatGPT") then return missing value
		tell process "ChatGPT"
			set frontmost to true
			
			-- ---------- Step 1: Find the main ChatGPT window ----------
			set mainWindow to missing value
			set chatDialogWindow to missing value
			repeat with w in windows
				try
					set sr to subrole of w
					if sr is "AXStandardWindow" then
						set mainWindow to w
					else if sr is "AXSystemDialog" then
						set chatDialogWindow to w
					end if
				end try
			end repeat
			if mainWindow is missing value then return missing value
			log "found mainWindow"
			-- ---------- Step 2: Click the Options button ----------
			set optionsBtn to missing value
			set targetGroup to missing value
			try
				set targetGroup to group 2 of splitter group 1 of group 1 of mainWindow
				if targetGroup is not missing value then log "found targetGroup"
				set optionsBtn to item 1 of (buttons of targetGroup whose value of attribute "AXAttributedDescription" is "Options")
			end try
			if optionsBtn is missing value then return missing value
			perform action "AXPress" of optionsBtn
			log "clicked options"
			
			-- ---------- Step 3: Locate the ModelGroup ----------
			set modelsGroup to missing value
			try
				set modelsGroup to scroll area 1 of group 1 of pop over 1 of optionsBtn
			end try
			if modelsGroup is missing value then return missing value
			log "found model group"
			
			-- ---------- Step 4: Find & click the more model button  ----------
			
			set moreModelBtn to missing value
			try
				set moreModelBtn to item 1 of (buttons of modelsGroup whose value of attribute "AXAttributedDescription" contains "More models")
			end try
			if moreModelBtn is missing value then return missing value
			perform action "AXPress" of moreModelBtn
			log "clicked more model"
			
			-- Optional: Log all model --
			
			set allObjects to buttons of modelsGroup
			repeat with obj in allObjects
				set r to role of obj
				set n to name of obj
				log r & " - name: " & n
			end repeat
			
			-- ---------- Step 5: Find & click the target model button  ----------
			set targetModelBtn to missing value
			try
				set targetModelBtn to item 1 of (buttons of modelsGroup whose value of attribute "AXAttributedDescription" contains targetModelName)
			end try
			if targetModelBtn is missing value then return missing value
			perform action "AXPress" of targetModelBtn
			log "clicked the target model"
		end tell
	end tell
end triggerModelPicker

triggerModelPicker("o3")