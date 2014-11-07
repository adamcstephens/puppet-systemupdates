# disable pre-existing OS update mechanisms
class systemupdates::disable_os_methods inherits systemupdates {
  if $disable_os_methods == true {
    case $::osfamily {
      'RedHat': {
        package { 'yum-cron': ensure => absent, }
        package { 'yum-updatesd': ensure => absent, }
      }
      default: { }
    }
  }
}
