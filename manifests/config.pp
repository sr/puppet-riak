class riak::config {
  require github::config

  $configdir  = "${github::config::configdir}/riak"
  $datadir    = "${github::config::datadir}/riak"
  $executable = "${github::config::home}/homebrew/bin/riak"
  $logdir     = "${github::config::logdir}/riak"
  $port       = 18098

  file { [$configdir, $datadir, $logdir]:
    ensure => directory
  }

  file { "${configdir}/app.config":
    content => template('riak/app.config.erb'),
#    notify  => Service['com.github.riak']
  }

  file { '/Library/LaunchDaemons/com.github.riak.plist':
    content => template('riak/com.github.riak.plist.erb'),
    group   => 'wheel',
    owner   => 'root',
#    notify  => Service['com.github.riak']
  }
}
