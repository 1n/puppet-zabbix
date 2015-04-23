define zabbix::template (
  $templ_name   = '',
  $templ_source = '',
) {

  zabbix::resources::template { $templ_name:
    template_name   => $templ_name,
    template_source => $templ_source,
  }
}