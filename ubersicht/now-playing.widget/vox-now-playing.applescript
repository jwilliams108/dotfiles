#!/usr/bin/osascript

tell application "System Events"
  set myList to (name of every process)
end tell

if myList contains "Vox" then
  set player to "Vox"
else
  return "{ }"
end if

tell application "Vox"
  set trackname to track
  set artistname to artist
  set albumname to album

  set state to player state
end tell

if state is 1 then
  set status to "playing"
else if state is 0 then
  set status to "paused"
else
  set status to "stopped"
end if

return "{ \"now_playing\": { \"title\": \"" & trackname & "\", \"artist\": \"" & artistname & "\", \"album\": \"" & albumname & "\", \"status\": \"" & status & "\" } }"
