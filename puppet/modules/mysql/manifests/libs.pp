# == Class: mysql::libs
#
# We require mysql::libs as a dependency of postfix.
#
# === Parameters
#
# === Variables
#
# === Example
#
# === Authors
#
# === Copyright
#
# Copyright 2014
#
class mysql::libs {
  package { 'mysql-libs':
  ensure  =>  'installed',
  before  => [Class['postfix'], Class['mysql'], Class['mysql::server']],
  }
}