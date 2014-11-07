# Create the script that does all the work
class systemupdates::script inherits systemupdates {
  concat { '/usr/local/sbin/system_update.sh' :
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
  }

  concat::fragment { 'system_updates_header':
    target => '/usr/local/sbin/system_update.sh',
    source => 'puppet:///modules/systemupdates/system_updates.header.sh',
    order  => '01',
  }

  concat::fragment { 'system_updates_header_OS':
    target => '/usr/local/sbin/system_update.sh',
    source => "puppet:///modules/systemupdates/system_updates.header.${::osfamily}.sh",
    order  => '10',
  }

  concat::fragment { 'system_updates_OS_checkreboot':
    target  => '/usr/local/sbin/system_update.sh',
    content => template("systemupdates/system_updates.${::osfamily}-checkreboot.sh.erb"),
    order   => '20',
  }

  concat::fragment { 'system_updates_OS_dopkgtosvcrestart':
    target  => '/usr/local/sbin/system_update.sh',
    content => template("systemupdates/system_updates.${::osfamily}-dopkgtosvcrestart.sh.erb"),
    order   => '30',
  }

  concat::fragment { 'system_updates_OS_doupdate':
    target  => '/usr/local/sbin/system_update.sh',
    content => template("systemupdates/system_updates.${::osfamily}-doupdate.sh.erb"),
    order   => '40',
  }

  concat::fragment { 'system_updates_footer':
    target => '/usr/local/sbin/system_update.sh',
    source => 'puppet:///modules/systemupdates/system_updates.footer.sh',
    order  => '99',
  }
}
