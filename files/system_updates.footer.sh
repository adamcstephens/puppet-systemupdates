if [[ $aflag -eq 1 ]]
then
  do_update
  do_reboot
elif [[ $cflag -eq 1 ]]
then
  do_reboot
elif [[ $uflag -eq 1 ]]
then
  do_update
else
  print_usage
fi
