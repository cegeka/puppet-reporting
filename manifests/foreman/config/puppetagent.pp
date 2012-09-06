define reporting::foreman::config::puppetagent {

  augeas { 'configure reporting for puppet agent':
    context => '/files/etc/puppet/puppet.conf/agent',
    changes => [
      'set report true',
    ],
  }

}
