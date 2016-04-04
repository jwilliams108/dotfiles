#!/bin/sh

VOX=`~/.ubersicht/now-playing.widget/check-for-vox.applescript`
CMUS=`/usr/local/bin/cmus-remote -Q 2>&1`

if [ $? -eq 0 ]; then
  echo `~/.ubersicht/now-playing.widget/cmus-now-playing.sh`
else
  if [ "$VOX" == "true" ]; then
    echo `~/.ubersicht/now-playing.widget/vox-now-playing.applescript`
  else
    echo "{ }"
  fi
fi
