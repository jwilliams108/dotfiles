#!/bin/sh

CMUS=`/usr/local/bin/cmus-remote -Q 2>&1`

if [ $? -eq 0 ] ; then
  echo `~/.ubersicht/now-playing.widget/cmus-now-playing.sh`
else
  echo `~/.ubersicht/now-playing.widget/vox-now-playing.applescript`
fi
