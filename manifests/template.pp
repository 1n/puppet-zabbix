class zabbix::template (
  
  ) inherits zabbix::params {

    class { 'zabbix::resources::template':
      template_name   => $template_name,
      template_source => $template_ssource,
    }
  }
}