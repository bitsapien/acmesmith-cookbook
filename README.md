# acmesmith Cookbook

Cookbook to get Acmesmith to manage SSL certificates

## Requirements

### Platforms

- Ubuntu 16.04

### Chef

- Chef 12.0 or later

## Attributes


### acmesmith::default

| Key | Type | Description | Default |
|-----|------|-------------|---------|
| ['acmesmith']['version'] |String |Version number of gem to be used. | '0.6.1' |
| ['acmesmith']['config']['path'] |String |Path of the config file | '/tmp' # set this |
| ['acmesmith']['bindir'] |String |Directory where the gem's executables will reside. | '/usr/local/bin' |
| ['acmesmith']['config']['endpoint'] |String |The ACME endpoint for authorization/request of SSL certificates. | 'https://acme-staging.api.letsencrypt.org/' # set this |
| ['acmesmith']['config']['storage_type'] |String (Possible values: 's3'(recommended) or 'filesystem') |Location repo for the requested certificates.  | 's3' |
| ['acmesmith']['config']['storage']['s3_region'] |String |S3 Region | 'us-east-1' # set this |
| ['acmesmith']['config']['storage']['s3_bucket_name'] |String |Name of the S3 bucket | 'some-bucket' # set this |
| ['acmesmith']['config']['storage']['s3_prefix'] |String |Prefix/Namespace under which the certificates will be stored on S# | '' |
| ['acmesmith']['config']['storage']['s3_access_key_id'] |String |AWS S3 Access Key ID | '' # set this |
| ['acmesmith']['config']['storage']['s3_secret_access_key'] |String |AWS S3 Access Secret | '' # set this |
| ['acmesmith']['config']['storage']['filesystem_path'] |String |Need to set if 'filesystem' is chosen as the storage_type | '/tmp/keys' |
| ['acmesmith']['config']['challenge_responder_type'] |String |Challenge responder, presently only 'route53' is available. | 'route53' |
| ['acmesmith']['config']['challenge_responder']['route53_access_key_id'] |String |AWS R53 Access Key ID | '' # set this |
| ['acmesmith']['config']['challenge_responder']['route53_secret_access_key'] |String |AWS R53 Access Secret | '' # set this |
| ['acmesmith']['config']['challenge_responder']['route53_session_token'] |String |AWS R53 Session Token | '' # set this |
| ['acmesmith']['config']['hosted_zone_map_domain_name'] |String |Hosted Zone Domain Name (eg: abc.com.) | '' |
| ['acmesmith']['config']['hosted_zone_map_id'] |String |Hosted Zone Map ID (eg: /hosted_zone/DEADBEEF) | '' |
| ['acmesmith']['config']['account_key_passphrase'] |String |Account Key Passphrase | 'password' # set this |
| ['acmesmith']['config']['certificate_key_passphrase'] |String |Cerificate Key Passphrase | 'secret' # set this |
| ['acmesmith']['domain'] |String |Domain for which SSL certificates need to be fetched (eg. abc.com) | '' # set this |
| ['acmesmith']['common_name'] |String |Common Name for which SSL certificates need to be fetched (eg. xyz.abc.com) | '' # set this |
| ['acmesmith']['contact'] |String |Email ID of owner (eg. someone@something.com) | '' # set this |
| ['acmesmith']['sans'] |Array of Strings |Comma seperated SANs (Subject Alternative Names) | [] |
| ['acmesmith']['certificate_path'] |String |Path where Certificate will be written to (Set this according to your web server's configuration) | '' # set this |
| ['acmesmith']['private_key_path'] |String |Path where Private Key will be written to (Set this according to your web server's configuration) | '' # set this |
| ['acmesmith']['auto_renew_days'] |String |Renew certificates which being expired soon | '5' |
| ['acmesmith']['auto_renew_log_path'] |String |Logs for cron that renews certificates | '/tmp/acmesmith-renewal.log' |

The below variables need to be set (where default values might fail) :

* ['acmesmith']['config']['storage']['s3_region']
* ['acmesmith']['config']['storage']['s3_bucket_name']
* ['acmesmith']['config']['storage']['s3_access_key_id']
* ['acmesmith']['config']['storage']['s3_secret_access_key']
* ['acmesmith']['config']['challenge_responder']['route53_access_key_id']
* ['acmesmith']['config']['challenge_responder']['route53_secret_access_key']
* ['acmesmith']['config']['challenge_responder']['route53_session_token']
* ['acmesmith']['config']['account_key_passphrase']
* ['acmesmith']['config']['certificate_key_passphrase']
* ['acmesmith']['domain']
* ['acmesmith']['common_name']
* ['acmesmith']['contact']
* ['acmesmith']['certificate_path']
* ['acmesmith']['private_key_path']

## Usage

### acmesmith::default


e.g.
Just include `acmesmith` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": ["recipe[acmesmith]"]
}
```



## Contributing

TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors:

- [bitsapien](https://github.com/bitsapien)

