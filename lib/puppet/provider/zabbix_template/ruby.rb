require File.expand_path(File.join(File.dirname(__FILE__), '..', 'zabbix'))
Puppet::Type.type(:zabbix_template).provide(:ruby, :parent => Puppet::Provider::Zabbix) do

	def create 
    zabbix_url = @resource[:zabbix_url]

    if zabbix_url != ''
        self.class.require_zabbix
    end
        
    # Set some vars
    template_name = @resource[:template_name]
    template_source = @resource[:template_source]
    zabbix_url = @resource[:zabbix_url]
    zabbix_user = @resource[:zabbix_user]
    zabbix_pass = @resource[:zabbix_pass]
    apache_use_ssl = @resource[:apache_use_ssl]

    # Connect to zabbix api
    zbx = self.class.create_connection(zabbix_url,zabbix_user,zabbix_pass,apache_use_ssl)
=begin
    # Get the template ids.
    template_array = Array.new
    if templates.kind_of?(Array)
        templates.each do |template|
            template_id = self.class.get_template_id(zbx, template)
            template_array.push template_id
        end
    else
        template_array.push self.class.get_template_id(zbx, templates)
    end
=end
    zbx.configurations.import(
      :format => "xml",
      :rules => {
          :applications => {
            :createMissing => true,
            :updateExisting => true
          },
          :discoveryRules => {
            :createMissing => true,
            :updateExisting => true
          },
          :graphs =>{
            :createMissing => true,
            :updateExisting => true
          },
          :groups => {
            :createMissing => true
          },
          :image => {
            :createMissing => true,
            :updateExisting => true
          },
          :items => {
            :createMissing => true,
            :updateExisting => true
          },
          :maps => {
            :createMissing => true,
            :updateExisting => true
          },
          :screens => {
            :createMissing => true,
            :updateExisting => true
          },
          :templateLinkage => {
            :createMissing => true
          },
          :templates => {
            :createMissing => true,
            :updateExisting => true
          },
          :templateScreens => {
            :createMissing => true,
            :updateExisting => true
          },
          :triggers => {
            :createMissing => true,
            :updateExisting => true
          }
      },
      :source => template_source
    )
  end

  def exists?
    zabbix_url = @resource[:zabbix_url]

    if zabbix_url != ''
        self.class.require_zabbix
    end

    template_name = @resource[:template_name]
    template_source = @resource[:template_source]
    zabbix_user = @resource[:zabbix_user]
    zabbix_pass = @resource[:zabbix_pass]
    apache_use_ssl = @resource[:apache_use_ssl]

    #zbx = self.class.create_connection(zabbix_url,zabbix_user,zabbix_pass,apache_use_ssl)
    #template_id = self.class.get_template_id(zbx, template_name)
    return false    
  end

end