
# http://docs.puppetlabs.com/guides/style_guide.html
# Must use two-space soft tabs

Yumrepo <| |> -> Package <| provider != 'rpm' |>

include curl
include databases
include epel
include erlang
include firewall
include git
include ius
include motd
include mysql::libs
include nano
include postfix
include remi
include stdlib
include wget
#include vcsrepo

class { 'apache':
  sendfile        => 'Off',
}

apache::vhost { 'master':
  default_vhost   => true,
  port        => '80',
  docroot     => '/var/www/askeet/web',
  override    => 'All',
  log_level   => 'warn',
  scriptalias => '/var/www/cgi-bin',
  directories => [
    {
      'path' => '/var/www/askeet/web',
      'provider'          => 'directory',
      'allow'             => 'from all',
      'allow_override'    => ['All'],
      'options'           => ['Indexes', 'FollowSymLinks', 'MultiViews'],
    },
    {
      'path'              => '/var/www/cgi-bin',
      'provider'          => 'directory',
      'allow'             => 'from all',
      'allow_override'    => ['None'],
      'options'           => ['+ExecCGI', '-MultiViews', '+SymLinksIfOwnerMatch'],
    },
  ],
}

class { 'php::cli':
  ensure           => latest,
  cli_package_name => 'php56u-cli',
  require          => Yumrepo['ius'],
}

class { 'php::common':
  ensure              => latest,
  common_package_name => 'php56u-common',
  require             => Yumrepo['ius'],
}

class { 'php::mod_php5':
  ensure           => latest,
  inifile          => '/etc/httpd/conf/php.ini',
  php_package_name => 'php56u',
  require          => Yumrepo['ius'],
}

$phpmod = [ 'tidy', 'gd', 'pecl-xdebug', 'mcrypt', 'xml', 'mbstring', 'bcmath' ]

php::module { $phpmod:
  require => [Class['php::mod_php5'], Yumrepo['ius']],
}

php::ini { '/etc/php.ini':
  display_errors => 'On',
  memory_limit   => '256M',
  sendmail_path  => '/usr/sbin/sendmail -t -i',
  date_timezone  => 'America/Chicago',
  require        => [Yumrepo['ius'], Package['php56u-common']],
  before         => Package['php56u'],
}

php::ini { '/etc/httpd/conf/php.ini':
  mail_add_x_header => 'Off',
  require           => [Package['httpd'], Yumrepo['ius']],
  date_timezone  => 'America/Chicago',
}

php::module::ini { 'pecl-xdebug':
  zend     => '/usr/lib64/php/modules/',
  settings => {
  #'zend_extension'                 => '/usr/lib64/php/modules/xdebug.so',
    'xdebug.profiler_enable_trigger' => '1',
    'xdebug.profiler_enable'         => '0',
    'xdebug.profiler_output_dir'     => '/var/www/askeet',
    'xdebug.remote_enable'           => '1',
    'xdebug.remote_connect_back'     => '1',
  },
  require  => [Yumrepo['ius'], Class['php::common']],
}

# Hack central
file { 'duplicate_xdebug_ini':
  path => '/etc/php.d/15-xdebug.ini',
  ensure => 'absent',
  require => Php::Module::Ini['pecl-xdebug']
}

$pkgs = ['php56u-mysqlnd', 'php56u-devel', 'gcc', 'gcc-c++', 'autoconf', 'automake', 'php56u-intl']

package { $pkgs:
  ensure => installed,
}

class { 'mysql':
  package_ensure =>  latest,
  before         => Class['postfix'],
}

database_grant { 'root@localhost':
  privileges => ['all'],
}

class { 'mysql::server':
  config_hash    => { 'root_password' => 'root' },
  package_ensure =>  latest,
  before         => Class['postfix'],
}

class { 'pear':
  package => 'php56u-pear',
  require => Class['php::cli'],
}

pear::package { "symfony":
  version => "1.0.22",
  repository => "pear.symfony-project.com",
  require => Class['php::cli'],
}

# Removed since we won't have access to these when we upgrade production
# to PHP 5.4. You can enable this locally if you require SMTP although
# the vagrant provision will warn of xdebug already being installed.
#
#pear::package { 'Mail':
#  require => Pear::Package["Net_SMTP"],
#}
#
#pear::package { 'Net_SMTP':
#  require => Class['pear'],
#}

#pear::package { "Console_Table": }
#pear::package { 'HTTP-Request':
#  require => Pear::Package["PEAR"],
#  }
# 'php-pear-Mail-Mime', 'php-pear-Mail-mimeDecode', 'php-pear-Net-Socket',
# 'php-pear-Net-URL', 'php-pear-SOAP', 'php-pear-XML-Parser',
# 'php-pear-XML-Serializer']:
#  }

exec {
  'composer install':
    command => 'curl -sS https://getcomposer.org/installer | php',
    path    => '/usr/bin:/usr/local/bin:/usr/sbin:/sbin',
    creates => '/usr/local/bin/composer.phar',
    cwd     => '/usr/local/bin',
    require => [ Package[ 'curl' ], Class [ 'php::mod_php5' ] ],
}

class { 'phpunit':
  phar_uri     => 'https://phar.phpunit.de/phpunit.phar',
  install_path => '/usr/local/bin/phpunit',
}