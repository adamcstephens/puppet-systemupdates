# puppet-systemupdates

[![Puppet Forge](http://img.shields.io/puppetforge/v/adamcstephens/systemupdates.svg)](https://forge.puppetlabs.com/adamcstephens/systemupdates)

#### Table of Contents

1. [Usage](#usage)
2. [Reference](#reference)

Puppet module for configuring systems for automatic package updates. This module provides a custom update
mechanism which utilizes distribution package managers, allowing for a consistent update experience
across supported distributions.

This module is designed to run from a cron task, and will only output on a failed return code from a task.

The following distributions are known to be supported:

* CentOS/RHEL 5-7
* Ubuntu 14.04

Please file an issue if you have successfully tested this on other apt/yum systems.

# Usage

Default update mechanism is once a week on Wed at 4am with a random minute (0-59). 
These can be customized with class paramaters.

## Manifest

```
class { '::systemupdates':
  day => 'Wed',
  hour => '4',
  minute => fqdn_rand(59),
  auto_reboot => false,
}
```

## Hieradata

You can use Hiera to customize the configuration more granularly. Make sure to use
single quotes if referencing the shell script variables

```
systemupdates::use_crontab: false
systemupdates::use_anacron: 'daily'
systemupdates::exclude:
  - 'kernel*'
  - 'glibc*'
systemupdates::pkgtosvcrestart:
  jre:
    - elasticsearch
    - logstash
  elasticsearch: "elasticsearch"
systemupdates::custom_commands:
  - 'apt-get -y $APTARGS dist-upgrade puppet'
  - 'apt-get -y $APTARGS -f install'
  - 'apt-get -y $APTARGS autoremove'
systemupdates::pkgtosystemreboot:
  - glibc
  - openssl
```

# Reference

## Paramaters

###`use_crontab`

Whether to create a crontab entry for root.

Default: true

###`use_anacron`

Whether to create an anacron file. Must be one of hourly, daily, weekly or monthly if set.

Default: false

###`auto_reboot`

Wether to automatically reboot, if necessary, after completion of upgrade.

Default: false

###`exclude`

An optional array of packages to exclude from the update process.

Default: undef

###`day`

Day of the week for root crontab entry. See [cron type](https://docs.puppetlabs.com/references/latest/type.html#cron)

Default: Wed

###`hour`

Hour of the day for root crontab entry. See [cron type](https://docs.puppetlabs.com/references/latest/type.html#cron)

Default: 4 (am)

###`minute`

Minute of the hour for root crontab entry. See [cron type](https://docs.puppetlabs.com/references/latest/type.html#cron)

Default: fqdn_rand(59)

###`logrotate_freq`

How frequently to rotate logs. See logrotate documentation.

Default: monthly

###`logrotate_keep`

How many rotated logs to keep. See logrotate documents.

Default: 12

###`disable_os_methods`

Whether this module should try and clean up OS native methods for automatic upgrades.

Default: false

###`pkgtosvcrestart`

Package to service mapping which will automatically restart services if package is upgraded. See Hiera example above.

**NOTE** Keys off current date. Will restart services every time run during matching day.

Default: undef

###`custom_commands`

Site specific commands which should be run *after* the upgrade process. See Hiera example above.

Default: undef

###`pkgtosystemreboot`

Array of site specific packages which should trigger a system reboot. Currently only supports rpm systems.

**NOTE** Only supports RPM-based systems, and keys off current date. Will reboot every time run during matching day.

Default: empty

###`custom_pre_commands`

Array of site specific commands which should be run *before* the upgrade process. Similar to custom_commands.

Default: empty

# Other

Please feel free to submit pull requests or file bugs/feature requests. I developed this
module for my purposes, but hope others will find it of use.
