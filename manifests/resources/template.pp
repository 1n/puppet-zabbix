# == Class zabbix::resources::template
#
# This will create an resources into puppetdb
# for automatically configuring agent into
# zabbix front-end.
#
# === Requirements
#
# Nothing.
#
# When manage_resource is set to true, this class
# will be loaded from 'zabbix::template'. So no need
# for loading this class manually.
#
#
class zabbix::resources::template (
  $template_name   = undef,
  $template_source = undef,
) {

  @@zabbix_template { $template_name:
    template_source         => $template_source,
    zabbix_url     => '',
    zabbix_user    => '',
    zabbix_pass    => '',
    apache_use_ssl => '',
  }
}
