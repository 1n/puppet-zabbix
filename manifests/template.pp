define zabbix::template (
  $templ_name   = undef,
  $templ_source = undef,
) {

  class { 'zabbix::resources::template':
    template_name   => $templ_name,
    template_source => $templ_source,
  }
}