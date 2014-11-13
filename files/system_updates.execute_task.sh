execute_task() {
  task=$@
  if [[ "$VERBOSE" != 'true' ]]
  then
    TEMPLOG=$(mktemp)
    echo "$(date +"%b %d %H:%M:%S") Executing Task: ${@}" >$TEMPLOG
    eval $@ &>>$TEMPLOG
    TASKSTATUS=$?
  else
    echo "$(date +"%b %d %H:%M:%S") Executing Task: $@"
    eval $@
  fi
  if [[ "$VERBOSE" != 'true' ]]
  then
    if [ $TASKSTATUS -ne 0 ]
    then
      echo "Command returned non-zero. Output:"
      echo
      cat $TEMPLOG
    fi
    cat $TEMPLOG >> $SYSTEM_UPDATE_LOG
    rm -f $TEMPLOG
  fi
}

