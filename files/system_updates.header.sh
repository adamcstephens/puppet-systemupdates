#!/usr/bin/env bash
#
# system_update.sh
#
# System Update script managed by Puppet
#

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"
export SYSTEM_UPDATE_LOG='/var/log/system_update.log'

# unset some problematic environment variables
unset DISPLAY
unset SSH_CONNECTION
unset REMOTE_HOST

# disable reboot by default, re-enable with arguments
REBOOT='false'

print_usage() {
  echo "Usage: system_update.sh [-v] (-a | -c | -u )
    -a update and reboot (equivalent to -u followed by -c)
    -c check and execute reboot if necessary
    -u do updates
    -v verbose (default is only error output)"
  exit
}

while getopts acuv name
do
 case $name in
   c) cflag=1
      REBOOT='true'
      if [[ $uflag -eq 1 ]]
      then
        print_usage
      fi
      ;;
   u) uflag=1
      if [[ $cflag -eq 1 ]]
      then
        print_usage
      fi
      ;;
   a) aflag=1
      REBOOT='true'
      ;;
   v)
      VERBOSE='true'
      ;;
   ? ) print_usage;;
 esac
done

