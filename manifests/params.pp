# class OS params
class systemupdates::params {
  $day            = 'Wed'
  $hour           = '4'
  $minute         = fqdn_rand(59)
  $auto_reboot    = false
  $use_crontab    = true
  $use_cron_daily = false

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
