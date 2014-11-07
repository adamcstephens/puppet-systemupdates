if [[ $aflag -eq 1 ]]
then
  do_update
  check_reboot
elif [[ $cflag -eq 1 ]]
then
  check_reboot
elif [[ $uflag -eq 1 ]]
then
  do_update
else
  print_usage
fi
