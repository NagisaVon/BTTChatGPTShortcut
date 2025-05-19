on toggleTranscription()
	tell application "System Events"
		if not (exists process "ChatGPT") then return missing value
		tell process "ChatGPT"
			-- Bring ChatGPT to front so AX API can see its UI tree
			set frontmost to true
			
			set startBtn to missing value
			set endBtn to missing value
			-- ---------- Step 1: Look in the main window ----------
			try
				-- TODO: Main window name could change it seems, not sure how to reproduce this
				set mainWindowGroup to group 2 of splitter group 1 of group 1 of window "ChatGPT"
				-- log "Found Main Window Group"
				set startBtnMain to my findButtonByAXAttributedDescription(mainWindowGroup, "Dictation")
				set endBtnMain to my findButtonByAXAttributedDescription(mainWindowGroup, "Confirm")
				if startBtnMain is not missing value then set startBtn to startBtnMain
				if endBtnMain is not missing value then set endBtn to endBtnMain
			end try
			-- ---------- Step 2: Look in the chat bar window ----------
			try
				set chatBarGroup to group 1 of window 1
				-- log "Found Chat Bar Group"
				set startBtnChatBar to my findButtonByAXAttributedDescription(chatBarGroup, "Dictation")
				set endBtnChatBar to my findButtonByAXAttributedDescription(chatBarGroup, "Confirm")
				-- Alway prefer the chat bar so if the button is found in the chat bar, it will override the main window button
				if startBtnChatBar is not missing value then set startBtn to startBtnChatBar
				if endBtnChatBar is not missing value then set endBtn to endBtnChatBar
			end try
			
			-- ---------- Step 3: Perform the action ----------
			-- always prefer end first, ChatGPT has a bug where you click start at the a window when the other window is already started dicatating
			if (endBtn is not missing value) then
				perform action "AXPress" of endBtn
			else if (startBtn is not missing value) then
				perform action "AXPress" of startBtn
			else if true then
				-- log "no matching buttons found, exiting"
			end if
		end tell
	end tell
end toggleTranscription


on findButtonByAXAttributedDescription(targetGroup, desiredDesc)
	tell application "System Events"
		tell process "ChatGPT"
			set matchingButtons to missing value
			try
				set matchingButtons to (buttons of targetGroup whose value of attribute "AXAttributedDescription" contains desiredDesc)
			end try
			-- log matchingButtons
			if matchingButtons is not {} and matchingButtons is not missing value then return item 1 of matchingButtons
		end tell
	end tell
	
	return missing value
end findButtonByAXAttributedDescription


toggleTranscription()