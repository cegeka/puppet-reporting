include reporting

reporting::foreman::config::puppetmaster {'configure puppetmaster':
  foreman_url => 'http://localhost',
}

reporting::foreman::config::puppetagent { 'configure puppetagent':
}
