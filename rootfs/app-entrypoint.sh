#!/bin/bash
set -e

#set app name to ENV or default
PLAY_PROJECT_NAME="test"
PLAY_TEMPLATE="play-java"
PLAY_PROJECT_PORT="9000"

if [ "$APP_NAME" != "" ] ; then
    PLAY_PROJECT_NAME=$APP_NAME
fi

if [ "$ACTIVATOR_TEMPLATE" != "" ] ; then
    PLAY_PROJECT_TEMPLATE=$ACTIVATOR_TEMPLATE
fi

if [ "$APP_PORT" != "" ] ; then
    PLAY_PROJECT_PORT=$APP_PORT
fi

PROJECT_DIRECTORY=/app/$PLAY_PROJECT_NAME

log () {
    echo -e "\033[0;33m$(date "+%H:%M:%S")\033[0;37m ==> $1."
}

if [ "$1" == "activator" -a "$2" == "run" ] ; then
    if [ ! -d $PROJECT_DIRECTORY ] ; then
	  log "Creating example Play application"
      cd /app
      activator new $PLAY_PROJECT_NAME $PLAY_TEMPLATE
      log "Play app created"
    else 
	  log "App already created"
      cd $PROJECT_DIRECTORY 
    fi
fi

# Making sure we end up in the project directory
cd $PROJECT_DIRECTORY

exec /entrypoint.sh "$@"
