# Class: ius
#
# This module manages IUS repo files
#
class ius {

  require epel

   yumrepo { 'ius':
        gpgcheck => '0',
        gpgkey => 'http://mirror.its.dal.ca/ius/IUS-COMMUNITY-GPG-KEY',
        descr => 'IUS Community Packages for Enterprise Linux 6 - $basearch',
        mirrorlist => 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el6&arch=$basearch',
        enabled => '1',
        require => File [ '/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY' ],
    }

    file { "/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/ius/IUS-COMMUNITY-GPG-KEY",
    }

    ius::rpm_gpg_key{ "ius":
      path => "/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY"
    }

}
