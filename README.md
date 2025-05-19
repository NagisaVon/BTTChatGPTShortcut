# BTTChatGPTShortcut

Bind shortcuts to the "Start Transcription" button of the macOS ChatGPT app. 

## Two implementations

1. **BTT's Image template Matching**: This implementation uses BTT's Find/Search Image on Screen & Move Mouse action, this was my initial implementation, should be more reliable unless they change the button's image. This implementation run a bit slow and clunky. To use it, import the `TriggerByImage.bttpreset` preset into BTT. 
2. **AppleScript**: This implementation uses AppleScript to bind the shortcut to the "Start Transcription" button using the Accessibility API. It's faster but if the app changes the layout of the UI, this will break. To use it, import the `TriggerByAppleScript.bttpreset` preset into BTT.

## Future Todo

- [ ] Main window name could change it seems, not sure how to reproduce this
- [ ] Add model switching using command-1, command-2, etc.
- [ ] ctrl-c interupt request, ctrl-r retry
- [ ] 