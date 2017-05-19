node.default['acmesmith']['version'] = '0.6.1'
node.default['acmesmith']['config']['path'] = '/tmp' # set this
node.default['acmesmith']['bindir'] = '/usr/local/bin'
node.default['acmesmith']['config']['endpoint'] = 'https://acme-staging.api.letsencrypt.org/' # set this

node.default['acmesmith']['config']['storage_type'] = 's3'

node.default['acmesmith']['config']['storage']['s3_region'] = 'us-east-1' # set this
node.default['acmesmith']['config']['storage']['s3_bucket_name'] = 'some-bucket' # set this
node.default['acmesmith']['config']['storage']['s3_prefix'] = ''
node.default['acmesmith']['config']['storage']['s3_access_key_id'] = '' # set this
node.default['acmesmith']['config']['storage']['s3_secret_access_key'] = '' # set this

node.default['acmesmith']['config']['storage']['filesystem_path'] = '/tmp/keys'




node.default['acmesmith']['config']['challenge_responders_type'] = 'route53'

node.default['acmesmith']['config']['challenge_responder']['route53_access_key_id'] = '' # set this
node.default['acmesmith']['config']['challenge_responder']['route53_secret_access_key'] = '' # set this
node.default['acmesmith']['config']['challenge_responder']['route53_session_token'] = '' # set this


node.default['acmesmith']['config']['hosted_zone_map_domain_name'] = ''
node.default['acmesmith']['config']['hosted_zone_map_id'] = ''

node.default['acmesmith']['config']['post_issueing_hooks_create_lock_path'] = '/tmp/certs-has-been-issued'

node.default['acmesmith']['config']['account_key_passphrase'] = 'password' # set this
node.default['acmesmith']['config']['certificate_key_passphrase'] = 'secret' # set this


node.default['acmesmith']['domain'] = '' # set this
node.default['acmesmith']['common_name'] = '' # set this
node.default['acmesmith']['contact'] = '' # set this

node.default['acmesmith']['certificate_path'] = '' 
node.default['acmesmith']['private_key_path'] = '' 
node.default['acmesmith']['pkcs12_path'] = ''

node.default['acmesmith']['renewal_script_path'] = '/usr/local/bin/'
