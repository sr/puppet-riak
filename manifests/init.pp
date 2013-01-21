# Installs custom Riak from homebrew. Auto-requires riak::config.
#
# Usage:
#
#     include riak
class riak {
  require riak::config

  $version = '1.1.2-x86_64-boxen1'

  package { 'boxen/brews/riak':
    ensure => $version,
    notify => Service['dev.riak']
  }

  service { 'dev.riak':
    ensure  => 'stopped',
    require => Package['boxen/brews/riak']
  }

  service { 'com.boxen.riak': # replaced by dev.riak
    before => Service['dev.riak'],
    enable => false
  }

  file { "${boxen::config::envdir}/riak.sh":
    content => template('riak/env.sh.erb'),
    require => File[$boxen::config::envdir]
  }

  file { "${boxen::config::homebrewdir}/Cellar/riak/${version}/libexec/etc/app.config":
    ensure  => link,
    force   => true,
    target  => "${riak::config::configdir}/app.config",
    require => [Package['boxen/brews/riak'],
      File["${riak::config::configdir}/app.config"]]
  }
}
