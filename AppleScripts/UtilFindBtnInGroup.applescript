-- Two type of way to locate a element (similar to HTML getElementsByClassName)


on findButtonByAXAttributedAXHelp(desiredDesc)
	-- desiredDesc: the keyword or full description you want to match
	tell application "System Events"
		if not (exists process "ChatGPT") then return missing value
		tell process "ChatGPT"
			set frontmost to true
			-- The path found by UI Browser; the main UI structure usually doesn't change.
			try
				set targetGroup to group 2 of splitter group 1 of group 1 of window "ChatGPT"
			on error
				return missing value
			end try
			repeat with aButton in (buttons of targetGroup)
				set descVal to ""
				-- Notes:  Some of the attributes are NSString, thus can be read like this (inlucdes AXHelp, AXDescription, AXTitle, etc.)
				-- But AXAttributedDescription is NSAttributedString, can only be read using the 'whose' keyword
				try
					set descVal to (value of attribute "AXHelp" of aButton) as text
				end try
				log descVal
				if descVal contains desiredDesc then
					return aButton
				end if
			end repeat
		end tell
	end tell
	return missing value
end findButtonByAXAttributedAXHelp

findButtonByAXAttributedAXHelp("Transcribe voice")


on findButtonByAXAttributedDescription(desiredDesc)
	-- desiredDesc: the keyword or full description you want to match
	tell application "System Events"
		if not (exists process "ChatGPT") then return missing value
		tell process "ChatGPT"
			set frontmost to true
			-- The path found by UI Browser; the main UI structure usually doesn't change.
			try
				set targetGroup to group 2 of splitter group 1 of group 1 of window "ChatGPT"
			on error
				return missing value
			end try
			set matchingButtons to missing value
			try
				-- AXAttributedDescription can only be searched using the 'whose' keyword;
				-- value of attribute doesn’t work here.
				set matchingButtons to (buttons of targetGroup whose value of attribute "AXAttributedDescription" contains desiredDesc)
			end try
			if matchingButtons is not {} and matchingButtons is not missing value then return item 1 of matchingButtons
		end tell
	end tell
	
	return missing value
end findButtonByAXAttributedDescription

findButtonByAXAttributedDescription("Dictation")