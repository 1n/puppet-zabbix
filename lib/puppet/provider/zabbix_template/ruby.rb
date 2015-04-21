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
	        :templates => {
	            :createMissing => true,
	            :updateExisting => true
	        },
	        :items => {
	            :createMissing => true,
	            :updateExisting => true
	        }
	    },
	    :source => "<?xml version=\"1.0\" encoding=\"UTF-8\"?><zabbix_export><version>2.0</version><date>2015-04-20T10:54:33Z</date><groups><group><name>Templates</name></group></groups><templates><template><template>Template role_apache</template><name>Template role_apache</name><description/><groups><group><name>Templates</name></group></groups><applications/><items/><discovery_rules/><macros/><templates/><screens/></template></templates></zabbix_export>"
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