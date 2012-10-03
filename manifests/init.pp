class riak {
  require riak::config

  $version = '1.1.2-x86_64-boxen1'

  package { 'boxen/brews/riak':
    ensure => $version,
#    notify => Service['com.boxen.riak']
  }

  # FIXME: re-enable service
  # service { 'com.boxen.riak':
  #   ensure  => running
  # }


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
