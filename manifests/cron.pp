# cron management
class systemupdates::cron inherits systemupdates {
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

  if $auto_reboot == true {
    $update_cmd = '/usr/local/sbin/system_update.sh -a'
  } else {
    $update_cmd = '/usr/local/sbin/system_update.sh -u'
  }

  file { '/etc/cron.daily/system_update':
    ensure  => $cron_daily_ensure,
    content => "#!/usr/bin/env bash\n# Puppet managed system update script\n${update_cmd}\n",
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
}
