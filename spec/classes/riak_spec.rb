require 'spec_helper'

describe 'riak' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen'
    }
  end

  it do
    should include_class('riak::config')

    should contain_package('boxen/brews/riak').
      with_ensure('1.1.2-x86_64-boxen1')

    should_not contain_package('boxen/brews/riak').
      with_notify('Service[com.boxen.riak]')

    should contain_file('/opt/boxen/env.d/riak.sh').with({
      :content => File.read('spec/fixtures/riak.sh'),
      :require => 'File[/opt/boxen/env.d]'
    })

    should contain_file('/opt/boxen/homebrew/Cellar/riak/1.1.2-x86_64-boxen1/libexec/etc/app.config').with({
      :ensure  => 'link',
      :force   => true,
      :target  => '/opt/boxen/config/riak/app.config',
      :require => [
        'Package[boxen/brews/riak]',
        'File[/opt/boxen/config/riak/app.config]'
      ]
    })
  end
end
