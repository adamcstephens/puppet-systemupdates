# class for managing automatic updates on systems
class systemupdates (
  $day='Wed',
  $hour='4',
  $minute=fqdn_rand(59),
  $auto_reboot=false,
  $pkgtosvcrestart=undef,
  $use_crontab=true,
  $use_cron_daily=false,
) {

  validate_bool($auto_reboot)
  validate_bool($use_crontab)
  validate_bool($use_cron_daily)

  case $::osfamily {
    'Redhat': {
      $update_template = 'systemupdates/system_update_yum.sh.erb'
      package { 'yum-cron': ensure => absent, }
      package { 'yum-updatesd': ensure => absent, }
    }
    'Debian': {
      $update_template = 'systemupdates/system_update_apt.sh.erb'
      ensure_packages(['update-notifier-common'])
    }
    default: { fail("Unknown OS family: ${::osfamily}") }
  }

  if $auto_reboot == true {
    $update_cmd = '/usr/local/sbin/system_update.sh -a'
  } else {
    $update_cmd = '/usr/local/sbin/system_update.sh -u'
  }

  if $pkgtosvcrestart {
    validate_hash($pkgtosvcrestart)
  }

  if $use_crontab == true {
    $cron_ensure = present
  } else {
    $cron_ensure = false
  }

  if $use_cron_daily == true {
    $cron_daily_ensure = present
  } else {
    $cron_daily_ensure = absent
  }

  file { '/etc/cron.daily/system_update':
    ensure  => $cron_daily_ensure,
    content => "#!/usr/bin/env bash\n${update_cmd}\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
  }

  cron { 'system_update':
    ensure  => $cron_ensure,
    command => $update_cmd,
    user    => 'root',
    weekday => $day,
    hour    => $hour,
    minute  => $minute,
  }

  file { '/usr/local/sbin/system_update.sh' :
    content => template($update_template),
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
  }
}
