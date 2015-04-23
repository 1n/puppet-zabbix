define zabbix::template (
  $templ_name   = undef,
  $templ_source = undef,
) {

  zabbix::resources::template { "${template_name}":
    template_name   => $templ_name,
    template_source => $templ_source,
  }
}