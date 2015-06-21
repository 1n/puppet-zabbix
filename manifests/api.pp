# == Class: zabbix::web
#
#  This will install the zabbix-web package and install an virtual host.
#
# === Requirements
#
#  The following is needed (or):
#   - puppetlabs-apache
#
# === Parameters
#
# [*zabbix_url*]
#   Url on which zabbix needs to be available. Will create an vhost in
#   apache. Only needed when manage_vhost is set to true.
#   Example: zabbix.example.com
#
# [*database_type*]
#   Type of database. Can use the following 2 databases:
#   - postgresql
#   - mysql
#
# [*zabbix_version*]
#   This is the zabbix version.
#   Example: 2.4
#
# [*zabbix_timezone*]
#   The current timezone for vhost configuration needed for the php timezone.
#   Example: Europe/Amsterdam
#
# [*zabbix_package_state*]
#   The state of the package that needs to be installed: present or latest.
#   Default: present
#
# [*manage_vhost*]
#   When true, it will create an vhost for apache. The parameter zabbix_url
#   has to be set.
#
# [*manage_resources*]
#   When true, it will export resources to something like puppetdb.
#   When set to true, you'll need to configure 'storeconfigs' to make
#   this happen. Default is set to false, as not everyone has this
#   enabled.
#
# [*apache_use_ssl*]
#   Will create an ssl vhost. Also nonssl vhost will be created for redirect
#   nonssl to ssl vhost.
#
# [*apache_ssl_cert*]
#   The location of the ssl certificate file. You'll need to make sure this
#   file is present on the system, this module will not install this file.
#
# [*apache_ssl_key*]
#   The location of the ssl key file. You'll need to make sure this file is
#   present on the system, this module will not install this file.
#
# [*apache_ssl_cipher*]
#   The ssl cipher used. Cipher is used from this website:
#   https://wiki.mozilla.org/Security/Server_Side_TLS
#
# [*apache_ssl_chain*}
#   The ssl chain file.
#
# [*apache_listenport*}
#   The port for the apache vhost.
#
# [*apache_listenport_ssl*}
#   The port for the apache SSL vhost.
#
# [*zabbix_api_user*]
#   Name of the user which the api should connect to. Default: Admin
#
# [*zabbix_api_pass*]
#   Password of the user which connects to the api. Default: zabbix
#
# [*database_host*]
#   Database host name.
#
# [*database_name*]
#   Database name.
#
# [*database_schema*]
#   Schema name. used for ibm db2.
#
# [*database_user*]
#   Database user. ignored for sqlite.
#
# [*database_password*]
#   Database password. ignored for sqlite.
#
# [*database_socket*]
#   Path to mysql socket.
#
# [*database_port*]
#   Database port when not using local socket. Ignored for sqlite.
#
# [*zabbix_server*]
#   The fqdn name of the host running the zabbix-server. When single node:
#   localhost
#
# [*zabbix_listenport*]
#   The port on which the zabbix-server is listening. Default: 10051
#
# [*apache_php_max_execution_time*]
#   Max execution time for php. Default: 300
#
# [*apache_php_memory_limit*]
#   PHP memory size limit. Default: 128M
#
# [*apache_php_post_max_size*]
#   PHP maximum post size data. Default: 16M
#
# [*apache_php_upload_max_filesize*]
#   PHP maximum upload filesize. Default: 2M
#
# [*apache_php_max_input_time*]
#   Max input time for php. Default: 300
#
# [*apache_php_always_populate_raw_post_data*]
#   Default: -1
#
# === Example
#
#   When running everything on a single node, please check
#   documentation in init.pp
#   The following is an example of an multiple host setup:
#
#   node 'wdpuppet02.dj-wasabi.local' {
#     class { 'apache':
#         mpm_module => 'prefork',
#     }
#     class { 'apache::mod::php': }
#     class { 'zabbix::web':
#       zabbix_url    => 'zabbix.dj-wasabi.nl',
#       zabbix_server => 'wdpuppet03.dj-wasabi.local',
#       database_host => 'wdpuppet04.dj-wasabi.local',
#       database_type => 'mysql',
#     }
#   }
#
# === Authors
#
# Author Name: ikben@werner-dijkerman.nl
#
# === Copyright
#
# Copyright 2014 Werner Dijkerman
#
class zabbix::api (
  $zabbix_url                               = '',
  $zabbix_version                           = $zabbix::params::zabbix_version,
  $manage_resources                         = $zabbix::params::manage_resources,
  $apache_use_ssl                           = $zabbix::params::apache_use_ssl,
  $zabbix_api_user                          = $zabbix::params::server_api_user,
  $zabbix_api_pass                          = $zabbix::params::server_api_pass,
) inherits zabbix::params {

  # So if manage_resources is set to true, we can send some data
  # to the puppetdb. We will include an class, otherwise when it
  # is set to false, you'll get warnings like this:
  # "Warning: You cannot collect without storeconfigs being set"

  if $manage_resources {
    include ruby::dev

    # Installing the zabbixapi gem package. We need this gem for
    # communicating with the zabbix-api. This is way better then
    # doing it ourself.
    package { 'zabbixapi':
      ensure   => "${zabbix_version}.0",
      provider => $::puppetgem,
      require  => Class['ruby::dev'],
    } ->
    class { 'zabbix::resources::web':
      zabbix_url     => $zabbix_url,
      zabbix_user    => $zabbix_api_user,
      zabbix_pass    => $zabbix_api_pass,
      apache_use_ssl => $apache_use_ssl,
    }
  }
}