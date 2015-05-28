class postfix {
  package { 'postfix':
    ensure  => installed,
    before  => Exec['postfix'],
    require => Class['mysql'],
  }

  exec { 'postfix':
    command     => 'echo "postfix packages are installed"',
    path        => '/usr/sbin:/bin:/usr/bin:/sbin',
    logoutput   => true,
    refreshonly => true,
  }
  service { 'postfix':
    ensure  => 'running',
    require => Exec['postfix']
  }
}
