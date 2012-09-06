require 'spec_helper'

describe 'reporting::foreman::config::puppetmaster' do

  context 'with no foreman_url given' do
    let (:title) { 'foo' }
    
    it {
      expect { subject }.to raise_error(
        Puppet::Error, /foreman_url must be defined/
    )}
  end

  context 'with an incorrect foreman_url' do
    let (:title) { 'foo' }
    let (:params) { { :foreman_url => 'test'  } }

    it {
      expect { subject }.to raise_error(
        Puppet::Error, /foreman_url must be a valid URL/
    )}
  end

  context 'with a correct foreman_url' do
    let (:title) { 'foo' }
    let (:params) { { :foreman_url => 'http://localhost' } }

    it { should contain_augeas('configure reporting for puppet master').with(
      :context => '/files/etc/puppet/puppet.conf/master',
      :changes => [ 'set reports foreman' ]
    )}

    it { should contain_file('/usr/lib/ruby/site_ruby/1.8/puppet/reports/foreman.rb').with(
      :ensure => 'file',
      :owner => 'root',
      :group => 'root',
      :mode => '0644'
    ).with_content(/^\$foreman_url='http:\/\/localhost'$/)}
  end

end
