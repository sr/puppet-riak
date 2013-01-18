# Configuration for Riak.
#
# Include riak instead of this class.
class riak::config {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/riak"
  $datadir    = "${boxen::config::datadir}/riak"
  $executable = "${boxen::config::home}/homebrew/bin/riak"
  $logdir     = "${boxen::config::logdir}/riak"
  $port       = 18098

  file { [$configdir, $datadir, $logdir]:
    ensure => directory
  }

  file { "${configdir}/app.config":
    content => template('riak/app.config.erb'),
#    notify  => Service['dev.riak']
  }

  file { '/Library/LaunchDaemons/dev.riak.plist':
    content => template('riak/dev.riak.plist.erb'),
    group   => 'wheel',
    owner   => 'root',
#    notify  => Service['dev.riak']
  }
}
