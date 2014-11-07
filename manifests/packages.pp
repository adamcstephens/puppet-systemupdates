# install pre-requisite packages
class systemupdates::packages {
  case $::osfamily {
    'Debian': {
      ensure_packages(['update-notifier-common'])
    }
    default: { }
  }
}
