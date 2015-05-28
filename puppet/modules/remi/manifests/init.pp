# Class remi
#
# Actions:
#   Configure the proper repositories and import GPG keys
#
# Requires:
#   You should probably be on an Enterprise Linux variant. (Centos, RHEL, Scientific, Oracle, Ascendos, et al)
#
# Dependencies:
#   stahnma/epel module, version: '0.0.3'
#
# Sample Usage:
#   include remi
#

class remi {

  require epel

  if $::osfamily == 'RedHat' and $::operatingsystem != 'Fedora' {

    yumrepo { 'remi':
      descr          => "Les RPM de remi pour Enterprise Linux ${::is_maj_version} - ${::architecture}",
      mirrorlist     => "http://rpms.famillecollet.com/enterprise/${::os_maj_version}/remi/mirror",
      enabled        => '1',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi",
      exclude => "php53*, php54*, php*, php, php-common, php-common*, php54-common*, php-cli, php-cli*, php54-cli*",
    }

    yumrepo { 'remi-test':
      descr          => "Les RPM de remi pour Enterprise Linux 6 - ${::architecture}",
      mirrorlist     => "http://rpms.famillecollet.com/enterprise/${::os_major_version}/test/mirror",
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi",
    }

    yumrepo { 'remi-debuginfo':
      descr          => "Les RPM de remi pour Enterprise Linux ${::os_maj_version} - ${::architecture} - debuginfo",
      baseurl        => "http://rpms.famillecollet.com/enterprise/${::os_maj_version}/debug-remi/${::architecture}/",
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi",
    }

    yumrepo { 'remi-test-debuginfo':
      descr          => "Les RPM de remi en test pour Enterprise Linux ${::os_maj_version} - ${::architecture} - debuginfo",
      baseurl        => "http://rpms.famillecollet.com/enterprise/${::os_maj_version}/debug-test/${::architecture}/",
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi",
    }

    file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-remi":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/remi/RPM-GPG-KEY-remi",
    }

    remi::rpm_gpg_key{ "remi":
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-remi"
    }
  } else {
      notice ("Your operating system ${::operatingsystem} will not have the REMI repository applied")
  }
}
