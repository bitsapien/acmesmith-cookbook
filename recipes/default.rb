#
# Cookbook Name:: acmesmith
# Recipe:: default
#
# Copyright 2017, eLitmus Evaluations Pvt Ltd
#
# All rights reserved - Do Not Redistribute
#


chef_gem 'acmesmith' do
  action :install
  version node['acmesmith']['version']
  compile_time false if respond_to?(:compile_time)
end

template "#{node.default['acmesmith']['config']['path']}/acmesmith.yml" do
  source 'acmesmith.yml.erb'
  owner "root"
  group "root"
  mode 00644
  variables(
  	endpoint: node['acmesmith']['config']['endpoint'],
  	storage_type: node['acmesmith']['config']['storage_type'],
  	storage_config: node['acmesmith']['config']['storage'],
  	challenge_responder_type: node['acmesmith']['config']['challenge_responder_type'],
  	challenge_responder_config: node['acmesmith']['config']['challenge_responder'],
  	hosted_zone_map_domain_name: "#{node['acmesmith']['domain']}.",
  	hosted_zone_map_id: node['acmesmith']['config']['hosted_zone_map_id'],
  	post_issueing_hooks_create_lock_path: node['acmesmith']['config']['post_issueing_hooks_create_lock_path'],
  	account_key_passphrase: node['acmesmith']['config']['account_key_passphrase'],
  	certificate_key_passphrase: node['acmesmith']['config']['certificate_key_passphrase'],
  	common_name: node['acmesmith']['common_name']
  )
end

end

# check of certificate exists ?
# if yes, do nothing
# if not
unless ::File.exist?(node['acmesmith']['config']['post_issueing_hooks_create_lock_path'])
	execute 'add_acme_contact' do
	  command "acmesmith register #{node['acmesmith']['contact']}"
	end

	execute 'authorize_domain' do
	  command "acmesmith authorize #{node['acmesmith']['domain']}"
	end

	execute 'request_certificates' do
	  command "acmesmith request #{node['acmesmith']['common_name']}"
	end

	execute 'save_certificate' do
	  command "acmesmith save-certificate #{node['acmesmith']['common_name']} --output=#{node['acmesmith']['certificate_path']}"
	  command "acmesmith save-private-key #{node['acmesmith']['common_name']} --output=#{node['acmesmith']['private_key_path']}"
	  command "acmesmith save-pkcs12 #{node['acmesmith']['common_name']} --output=#{node['acmesmith']['pkcs12_path']}"
	end

	template "#{node['acmesmith']['renewal_script_path']}/acmesmith-renewal.sh" do
	  source 'acmesmith-renewal.sh.erb'
	  owner "root"
	  group "root"
	  mode 00755
	  variables(
	  	common_name: node['acmesmith']['common_name'],
	  	certificate_path: node['acmesmith']['certificate_path'],
	  	private_key_path: node['acmesmith']['private_key_path'],
	  	pkcs12_path: node['acmesmith']['pkcs12_path']
	  )
	end

	cron 'renew_ssl_certificates' do 
		command "./#{node['acmesmith']['renewal_script_path']}/acmesmith-renewal.sh &> /tmp/acmesmith-renewal.log"
		user 'root'
		hour 1
		minute 0
	end
end
