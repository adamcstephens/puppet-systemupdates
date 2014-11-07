# Create the script that does all the work
class systemupdates::script inherits systemupdates {
  file { '/usr/local/sbin/system_update.sh' :
    content => template($update_template),
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
  }
}
