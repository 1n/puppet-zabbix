class zabbix::template (
  template_name = undef,
  template_source = undef,
  ) inherits zabbix::params {

  class { 'zabbix::resources::template':
    template_name   => $template_name,
    template_source => $template_source,
  }
}