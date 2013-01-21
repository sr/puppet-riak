require 'spec_helper'

describe 'riak::config' do
  let(:boxen_home) { '/opt/boxen' }
  let(:configdir)  { "#{boxen_home}/config/riak" }
  let(:facts) do
    {
      :boxen_home => boxen_home,
      :luser      => 'wfarr'
    }
  end

  it do
    should include_class('boxen::config')

    should contain_file("#{boxen_home}/config/riak").with_ensure('directory')
    should contain_file("#{boxen_home}/data/riak").with_ensure('directory')
    should contain_file("#{boxen_home}/log/riak").with_ensure('directory')

    should contain_file("#{configdir}/app.config").with_content(File.read("spec/fixtures/app.config"))
    should_not contain_file("#{configdir}/app.config").with_notify('Service[dev.riak]')

    should contain_file('/Library/LaunchDaemons/dev.riak.plist').with({
      :content => File.read('spec/fixtures/riak.plist'),
      :group   => 'wheel',
      :owner   => 'root'
    })
    should_not contain_file('/Library/LaunchDaemons/dev.riak.plist').with_notify('Service[dev.riak]')
  end
end
