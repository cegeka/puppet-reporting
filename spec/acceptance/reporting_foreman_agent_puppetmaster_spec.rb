require 'spec_helper_acceptance'

describe 'reporting::foreman::config::puppetmaster' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
      file { '/usr/local/scripts':
        ensure => directory
      }
      puppet::foreman::config::puppetmaster { 'configure master reporting':
        foreman_url => 'http://foreman.dummy.tld',
        require     => File['/usr/local/scripts']
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/usr/lib/ruby/site_ruby/1.8/puppet/reports/foreman.rb' do
      it { is_expected.to be_file }
    end

    describe file '/etc/puppet/puppet.conf' do
      it { is_expected.to be_file }
      its(:content) { should contain /foreman/ }
    end

  end
end

