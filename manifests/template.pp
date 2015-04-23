class zabbix::template (
  $zabbix_url              = '',
  $apache_use_ssl          = $zabbix::params::apache_use_ssl,
  $zabbix_api_user         = $zabbix::params::server_api_user,
  $zabbix_api_pass         = $zabbix::params::server_api_pass,
  $templ_name              = $zabbix::params::templ_name,
  $templ_source            = $zabbix::params::templ_source,
  ) inherits zabbix::params {

  class { 'zabbix::resources::template':
    template_name   => $templ_name,
    template_source => $templ_source,
    zabbix_url      => $zabbix_url,
    zabbix_user     => $zabbix_api_user,
    zabbix_pass     => $zabbix_api_pass,
    apache_use_ssl  => $apache_use_ssl,
  }
}