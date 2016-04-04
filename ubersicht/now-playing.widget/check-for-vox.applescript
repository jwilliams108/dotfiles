#!/usr/bin/osascript

set processIsRunning to true

tell application "System Events"
  set runningProcesses to processes whose bundle identifier is "com.coppertino.Vox"
end tell

if runningProcesses is {} then set processIsRunning to false

return processIsRunning
