#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quit All
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author lukasz_piotrak
# @raycast.authorURL https://raycast.com/lukasz_piotrak

tell application "System Events"
    set openApps to name of every application process where visible is true and name is not "Finder" and name is not "Raycast" and name is not "iTerm2"
end tell

repeat with appName in openApps
    tell application appName to quit
end repeat

