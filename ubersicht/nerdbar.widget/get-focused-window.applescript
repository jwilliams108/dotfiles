#!/usr/bin/osascript

global frontApp, frontAppName, windowTitle

set windowTitle to ""
tell application "System Events"
  try
    set frontApp to first application process whose frontmost is true
    set frontAppName to name of frontApp
  end try
end tell

return frontAppName
