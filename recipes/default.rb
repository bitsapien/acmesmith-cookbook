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
domain_name = node[app_name]['domain']
config_path = "#{node[app_name]['config']['path']}/#{app_name}-#{domain_name}.yml"

template config_path do
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
    hosted_zone_map_domain_name:            "#{domain_name}.",
    hosted_zone_map_id:                     node[app_name]['config']['hosted_zone_map_id'],
    storage_config:                         node[app_name]['config']['storage'],
    storage_type:                           node[app_name]['config']['storage_type'],
    acmesmith_path:                         app_path,
    config_path:                            config_path,
    certificate_path:                       node[app_name]['certificate_path'],
    private_key_path:                       node[app_name]['private_key_path']
  )
end

certificate_present = (::File.exist?(node.default['acmesmith']['certificate_path']) && ::File.exist?(node.default['acmesmith']['private_key_path']))

bash 'generate_certificates' do 
  cwd node['acmesmith']['bindir']
  code <<-EOH
    #{app_path} register         #{node[app_name]['contact']} -c #{config_path} 
    #{app_path} authorize        #{domain_name} -c #{config_path} 
    #{app_path} request          #{node[app_name]['common_name']} #{node[app_name]['sans'].join(' ')} -c #{config_path} 
    EOH
  not_if { certificate_present }
end


cron 'autorenew_ssl_certificates' do 
	command "#{app_path} autorenew -d#{node[app_name]['auto_renew_days']} -c #{config_path} &> #{node['acmesmith']['auto_renew_log_path']}" 
	hour 1
	minute 0
end
