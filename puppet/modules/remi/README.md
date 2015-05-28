# Configure remi repository

# About
This module basically just mimics the remi-release rpm.

The following repo will be setup and enabled by default:

  * remi

Other repositories that will setup but disabled (as per the remi-release setup)

  * remi-debuginfo
  * remi-test
  * remi-test-debuginfo

# Futher Information

* [remi website](http://rpms.famillecollet.com/)
* This code base based on code from http://github.com/stahnma/puppet-module-epel

# Testing

* This was tested using Puppet 3.1.x on Centos6
* I assume it will work on any RHEL variant

# License
Apache Software License 2.0
