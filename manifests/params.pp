# class OS params
class systemupdates::params {
  $day            = 'Wed'
  $hour           = '4'
  $minute         = "${fqdn_rand(59)}"
  $exclude        = undef
  $auto_reboot    = false
  $use_crontab    = true
  $use_anacron    = false
  $logrotate_freq = 'monthly'
  $logrotate_keep = '12'

  case $::osfamily {
    'Redhat': {
      $update_template = 'systemupdates/system_update_yum.sh.erb'
    }
    'Debian': {
      $update_template = 'systemupdates/system_update_apt.sh.erb'
    }
    default: { fail("Unsupported OS family: ${::osfamily}") }
  }
}
