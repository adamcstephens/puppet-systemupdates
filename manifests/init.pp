# class for managing automatic updates on systems
class systemupdates (
  $day                = $::systemupdates::params::day,
  $hour               = $::systemupdates::params::hour,
  $minute             = $::systemupdates::params::minute,
  $auto_reboot        = $::systemupdates::params::auto_reboot,
  $use_crontab        = $::systemupdates::params::use_crontab,
  $use_cron_daily     = $::systemupdates::params::use_cron_daily,
  $disable_os_methods = false,
  $pkgtosvcrestart    = undef,
) inherits systemupdates::params {
  validate_string($day)
  validate_string($hour)
  validate_string($minute)
  validate_bool($auto_reboot)
  validate_bool($use_crontab)
  validate_bool($use_cron_daily)
  validate_bool($disable_os_methods)
  if $pkgtosvcrestart {
    validate_hash($pkgtosvcrestart)
  }

  anchor { '::systemupdates::begin': } ->
  class { '::systemupdates::disable_os_methods': } ->
  class { '::systemupdates::packages': } ->
  class { '::systemupdates::script': } ->
  class { '::systemupdates::cron': } ->
  anchor { '::systemupdates::end': }

}
