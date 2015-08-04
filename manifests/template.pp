# == Define zabbix::template
#
#  This will upload an Zabbix Template (XML format)
#
# === Requirements
#
# === Parameters
#
# [*templ_name*]
#  The name of the template. This name will be found in the Web interface
#
# [*templ_source*]
#  The location of the XML file wich needs to be imported.
#
# === Example
#
#  zabbix::template { 'Template App MySQL':
#    templ_source => 'puppet:///modules/zabbix/MySQL.xml'
#  }
#
# === Authors
#
# Author Name: vlad.tkatchev@gmail.com
#
# === Copyright
#
# Copyright 2015  Vladislav Tkatchev
#
define zabbix::template (
  $templ_name   = $name,
  $templ_source = '',
) {

  zabbix::resources::template { "${::hostname}_${name}":
    hostname        => $::fqdn,
    template_name   => $templ_name,
    template_source => $templ_source,
  }
}
