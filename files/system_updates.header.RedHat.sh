if [[ "$VERBOSE" == "true" ]]
then
  YUMARGS='-y'
else
  YUMARGS="-y -d 0 -e 0"
fi

