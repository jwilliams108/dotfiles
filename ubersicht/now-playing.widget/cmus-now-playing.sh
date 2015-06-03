#!/bin/sh

# This function will start our JSON text.
startJSON() {
  echo '{'
}

# This function will return a single block of JSON for a single service.
exportNowPlaying() {
  echo '  "now_playing": {'
  echo '    "title": "'${TITLE}'",'
  echo '    "artist": "'${ARTIST}'",'
  echo '    "album": "'${ALBUM}'",'
  echo '    "status": "'${STATUS}'"'
  echo '  }'
}

# This function will finish our JSON text.
endJSON() {
  echo '}'
}

CMUS=`/usr/local/bin/cmus-remote -Q 2>&1`

startJSON
if [ "$CMUS" == "${CMUS/not running/}" ]; then
  # only output now playing if cmus is running
  STATUS=`/usr/local/bin/cmus-remote -Q | grep status | awk '{print $2}'`
  ARTIST=`/usr/local/bin/cmus-remote -Q | grep artist | grep -v albumartist | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`
  ALBUM=`/usr/local/bin/cmus-remote -Q | grep album | grep -v albumartist | grep -v replaygain | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`
  TITLE=`/usr/local/bin/cmus-remote -Q | grep title | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`

  exportNowPlaying
fi
endJSON
