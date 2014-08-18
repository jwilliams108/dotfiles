#!/bin/sh
#SCRIPTPATH=$(dirname `which $0`)

while test $# -ge 2
do
  eval _$1='$2'
  shift 2
done

# ${_title} ${_artist} ${_album} ${_date}

#STATUS=`/usr/local/bin/cmus-remote -Q | grep status | awk '{print $2}'`
STATUS=${_status}
ARTIST=`/usr/local/bin/cmus-remote -Q | grep artist | grep -v albumartist | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`
ALBUM=`/usr/local/bin/cmus-remote -Q | grep album | grep -v albumartist | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`
TITLE=`/usr/local/bin/cmus-remote -Q | grep title | awk '{sub(/^[ ]*([^ ]+ +){2}/, ""); print $0}'`

if [ $STATUS = 'playing' ] ; then
  /usr/local/bin/terminal-notifier \
    -group 'cmus-notifier' \
    -title "${TITLE}" \
    -message "${ARTIST} - ${ALBUM}"
    #-appIcon "${SCRIPTPATH}/resources/voxicon.icns"
fi
