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
  $pb_port    = 18097
  $version    = '1.2.1-x86_64-boxen1'
}
