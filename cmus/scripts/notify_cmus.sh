#!/bin/sh
#SCRIPTPATH=$(dirname `which $0`)

while test $# -ge 2
do
  eval _$1='$2'
  shift 2
done

# ${_title} ${_artist} ${_album} ${_date}

#STATUS=`/opt/local/bin/cmus-remote -Q | grep status | awk '{print $2}'`
STATUS=${_status}
ARTIST=`/opt/local/bin/cmus-remote -Q | grep artist | grep -v albumartist | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`
ALBUM=`/opt/local/bin/cmus-remote -Q | grep album | grep -v albumartist | grep -v replaygain | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`
TITLE=`/opt/local/bin/cmus-remote -Q | grep title | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`

if [ $STATUS = 'playing' ] ; then
  /opt/local/bin/terminal-notifier \
    -group 'cmus-notifier' \
    -title "${TITLE}" \
    -message "${ARTIST} - ${ALBUM}"
    #-appIcon "${SCRIPTPATH}/resources/voxicon.icns"
fi
