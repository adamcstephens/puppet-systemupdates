# class for managing automatic updates on systems
class systemupdates (
  $day                 = $::systemupdates::params::day,
  $hour                = $::systemupdates::params::hour,
  $minute              = $::systemupdates::params::minute,
  $exclude             = $::systemupdates::params::exclude,
  $auto_reboot         = $::systemupdates::params::auto_reboot,
  $use_crontab         = $::systemupdates::params::use_crontab,
  $use_anacron         = $::systemupdates::params::use_anacron,
  $logrotate_freq      = $::systemupdates::params::logrotate_freq,
  $logrotate_keep      = $::systemupdates::params::logrotate_keep,
  $disable_os_methods  = false,
  $pkgtosvcrestart     = {},
  $custom_commands     = [],
  $pkgtosystemreboot   = [],
  $custom_pre_commands = [],
) inherits systemupdates::params {
  validate_string($day)
  validate_string($hour)
  validate_string($minute)
  validate_bool($auto_reboot)
  validate_bool($use_crontab)
  if $exclude {
    validate_array($exclude)
  }
  if $use_anacron != false {
    validate_re($use_anacron, '^(hourly|daily|weekly|monthly)$',
      "${use_anacron} must be one of hourly, daily, weekly or monthly")
  }
  validate_string($logrotate_freq)
  validate_string($logrotate_keep)
  validate_bool($disable_os_methods)
  validate_hash($pkgtosvcrestart)
  validate_array($custom_commands)
  validate_array($pkgtosystemreboot)
  validate_array($custom_pre_commands)

  anchor { '::systemupdates::begin': } ->
  class { '::systemupdates::disable_os_methods': } ->
  class { '::systemupdates::packages': } ->
  class { '::systemupdates::logrotate': } ->
  class { '::systemupdates::script': } ->
  class { '::systemupdates::cron': } ->
  anchor { '::systemupdates::end': }

}
