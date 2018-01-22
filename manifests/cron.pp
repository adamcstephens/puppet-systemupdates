# cron management
class systemupdates::cron inherits systemupdates {
  $_use_crontab = str2bool($use_crontab)
  if $_use_crontab == true {
    $cron_ensure = 'present'
  } else {
    $cron_ensure = 'absent'
  }

  case $use_anacron {
    'hourly': {
      $anacron_hourly  = 'present'
      $anacron_daily   = 'absent'
      $anacron_weekly  = 'absent'
      $anacron_monthly = 'absent'
    }
    'daily': {
      $anacron_hourly  = 'absent'
      $anacron_daily   = 'present'
      $anacron_weekly  = 'absent'
      $anacron_monthly = 'absent'
    }
    'weekly': {
      $anacron_hourly  = 'absent'
      $anacron_daily   = 'absent'
      $anacron_weekly  = 'present'
      $anacron_monthly = 'absent'
    }
    'monthly': {
      $anacron_hourly  = 'absent'
      $anacron_daily   = 'absent'
      $anacron_weekly  = 'absent'
      $anacron_monthly = 'present'
    }
    false: {
      $anacron_hourly  = 'absent'
      $anacron_daily   = 'absent'
      $anacron_weekly  = 'absent'
      $anacron_monthly = 'absent'
    }
    default: { fail("Unknown anacron type: $  { use_anacron}") }
  }

  if $auto_reboot == true {
    $update_cmd = '/usr/local/sbin/system_update.sh -a'
  } else {
    $update_cmd = '/usr/local/sbin/system_update.sh -u'
  }

  file { '/etc/cron.hourly/system_update':
    ensure  => $anacron_hourly,
    content => "#!/usr/bin/env bash\n# Puppet managed system update script\n${update_cmd}\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
  }

  file { '/etc/cron.daily/system_update':
    ensure  => $anacron_daily,
    content => "#!/usr/bin/env bash\n# Puppet managed system update script\n${update_cmd}\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
  }

  file { '/etc/cron.weekly/system_update':
    ensure  => $anacron_weekly,
    content => "#!/usr/bin/env bash\n# Puppet managed system update script\n${update_cmd}\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
  }

  file { '/etc/cron.monthly/system_update':
    ensure  => $anacron_monthly,
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
