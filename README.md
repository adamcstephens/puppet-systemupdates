puppet-systemupdates
====================

Puppet module for configuring systems for automatic updates. This module provides a custom update
mechanism which utilizes distribution package managers, allowing for a consistent update experience
across supported distributions.

The following distributions are known to be supported:

* CentOS/RHEL 5-7
* Ubuntu 14.04

# Usage

Default update mechanism is once a week on Wed at 4am. These can be customized
with class paramaters.

```
class { '::systemupdates':
  day => 'Wed',
  hour => '4',
  minute => fqdn_rand(59),
  auto_reboot => false,
}
```

# Other

Please feel free to submit pull requests or file bugs/feature requests. I developed this
module for my purposes, but hope others will find it of use.
