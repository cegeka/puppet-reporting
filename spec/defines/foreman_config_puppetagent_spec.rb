require 'spec_helper'

describe 'reporting::foreman::config::puppetagent' do

    let (:title) { 'foo' }

    it { should contain_augeas('configure reporting for puppet agent').with(
      :context => '/files/etc/puppet/puppet.conf/agent',
      :changes => [ 'set report true' ]
    )}

end
