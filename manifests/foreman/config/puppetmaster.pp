define reporting::foreman::config::puppetmaster($foreman_url = undef) {

  if $foreman_url == undef {
    fail("Reporting::Foreman::Config::Puppetmaster[${foreman_url}]: foreman_url must be defined")
  }

  if $foreman_url !~ /^https?:\/\/.*$/ {
    fail("Reporting::Foreman::Config::Puppetmaster[${foreman_url}]: foreman_url must be a valid URL")
  }

  augeas { 'configure reporting for puppet master':
    context => '/files/etc/puppet/puppet.conf/master',
    changes => [
      'set reports foreman',
    ]
  }

  file { '/usr/lib/ruby/site_ruby/1.8/puppet/reports/foreman.rb' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/foreman/reports/foreman.rb.erb"),
  }

}
