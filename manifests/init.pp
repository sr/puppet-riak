class riak {
  require riak::config

  $version = '1.1.2-x86_64-github1'

  package { 'github/brews/riak':
    ensure => $version,
#    notify => Service['com.github.riak']
  }

  # service { 'com.github.riak':
  #   ensure  => running,
  #   require => Package['github/brews/riak']
  # }


  file { "${github::config::envdir}/riak.sh":
    content => template('riak/env.sh.erb'),
    require => File[$github::config::envdir]
  }

  file { "${github::config::homebrewdir}/Cellar/riak/${version}/libexec/etc/app.config":
    ensure  => link,
    force   => true,
    target  => "${riak::config::configdir}/app.config",
    require => [Package['github/brews/riak'],
      File["${riak::config::configdir}/app.config"]]
  }
}
