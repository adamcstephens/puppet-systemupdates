if [[ $aflag -eq 1 ]]
then
  do_update
  check_kernel
elif [[ $cflag -eq 1 ]]
then
  check_kernel
elif [[ $uflag -eq 1 ]]
then
  do_update
else
  print_usage
fi
