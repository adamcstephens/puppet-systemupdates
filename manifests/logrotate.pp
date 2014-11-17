# manage log rotation configuration

class systemupdates::logrotate inherits systemupdates {
  file { '/etc/logrotate.d/system_update':
    content => template('systemupdates/logrotate.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
}
