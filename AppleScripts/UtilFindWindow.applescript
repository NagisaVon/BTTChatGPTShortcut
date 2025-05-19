-- The ChatGPT app can have a main window(type of standard window), 
-- usually named "ChatGPT" but could sometimes be different, when no chat bar is open, this would be window 1
-- And when you use the chat bar it will make another window(type of system dialog), 
-- this will usually become the new window 1, and the main window will become window 2(order is not guaranteed)
-- This script will find the main window and the system dialog window if they exist and return the window object
tell application "System Events"
    if not (exists process "ChatGPT") then return missing value
    tell process "ChatGPT"
        set frontmost to true
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

        return {mainWindow, chatDialogWindow}
    end tell
end tell