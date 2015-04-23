define zabbix::template (
  $templ_name   = $zabbix::params::templ_name,
  $templ_source = $zabbix::params::templ_source,
  ) inherits zabbix::params {

  class { 'zabbix::resources::template':
    template_name   => $templ_name,
    template_source => $templ_source,
  }
}