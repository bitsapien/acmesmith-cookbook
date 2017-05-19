#
# Cookbook Name:: acmesmith
# Recipe:: default
#
# Copyright 2017, eLitmus Evaluations Pvt Ltd
#
# All rights reserved - Do Not Redistribute
#

app_name = 'acmesmith'


gem_package app_name do
  action :install
  options "--bindir #{node['acmesmith']['bindir']}"
  version node[app_name]['version']
end

app_path = "#{node['acmesmith']['bindir']}/#{app_name}"

template "#{node[app_name]['config']['path']}/#{app_name}.yml" do
  source "#{app_name}.yml.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
    account_key_passphrase:                 node[app_name]['config']['account_key_passphrase'],
    certificate_key_passphrase:             node[app_name]['config']['certificate_key_passphrase'],
    challenge_responder_config:             node[app_name]['config']['challenge_responder'],
    challenge_responder_type:               node[app_name]['config']['challenge_responder_type'],
    common_name:                            node[app_name]['common_name'],
    endpoint:                               node[app_name]['config']['endpoint'],
    hosted_zone_map_domain_name:            "#{node[app_name]['domain']}.",
    hosted_zone_map_id:                     node[app_name]['config']['hosted_zone_map_id'],
    storage_config:                         node[app_name]['config']['storage'],
    storage_type:                           node[app_name]['config']['storage_type']
  )
end

end

# check of certificate exists ?
# if yes, do nothing
# if not
certificate_present = ::File.exist?(node.default['acmesmith']['certificate_path']) && ::File.exist?(node.default['acmesmith']['private_key_path']) && ::File.exist?(node.default['acmesmith']['pkcs12_path'])


bash 'generate_certificates' do 
  cwd node['acmesmith']['bindir']
  code <<-EOH
    #{app_path} register         #{node[app_name]['contact']}
    #{app_path} authorize        #{node[app_name]['domain']}
    #{app_path} request          #{node[app_name]['common_name']}
    #{app_path} save-certificate #{node[app_name]['common_name']} --output=#{node[app_name]['certificate_path']}
    #{app_path} save-private-key #{node[app_name]['common_name']} --output=#{node[app_name]['private_key_path']}
    #{app_path} save-pkcs12      #{node[app_name]['common_name']} --output=#{node[app_name]['pkcs12_path']}
    EOH
  not_if certificate_present
end

cookbook_file "#{}/#{app_name}-renewal-bot.sh"
  source "#{app_name}-renewal-bot.sh"
  mode 00755
  action :create_if_missing
end

	cron 'renew_ssl_certificates' do 
		command "#{node[app_name]['renewal_script_path']}/#{app_name}-renewal-bot.sh &> /tmp/#{app_name}-renewal.log" 
		hour 1
		minute 0
	end
end
