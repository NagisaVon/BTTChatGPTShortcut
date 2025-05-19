# AppleScript Notes

## starter template
```applescript
tell application "System Events"
	if not (exists process "YOUR_PROCESS") then return missing value
	tell process "YOUR_PROCESS"
		set frontmost to true
    end tell
end tell
```


## to list all attributes: 

```applescript
set a to attributes of obj
log a
```

## to list all properties: 

```applescript
set a to properties of obj
log a
```

or better
```applescript
repeat with attr in attributes of w
    try
        set attrName to name of attr
        set attrValue to value of attr
        log "Attribute: " & attrName & " → Value: " & attrValue
    on error errMsg
        log "Error reading attribute: " & errMsg
    end try
end repeat
```

## get a specific property:

it seems most of the properties are easily accessible
```applescript
set a to name of obj
log a
```

## get a specific attribute:

use `value of attribute` to get the value of a specific attribute
```applescript
set a to (value of attribute "AXFoo" of obj) as text
log a
```

## to list all object at this level:

```applescript
tell application "System Events"
    set appName to "ChatGPT"
    set appProcess to first process whose name is appName
    set allObjects to UI elements of appProcess
    repeat with obj in allObjects
        log (name of obj)
    end repeat
end tell
```
