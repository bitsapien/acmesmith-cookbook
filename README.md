# acmesmith Cookbook

Cookbook to get Acmesmith to manage SSL certificates

## Requirements

### Platforms

- Ubuntu 16.04

### Chef

- Chef 12.0 or later

## Attributes


### acmesmith::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['acmesmith']['version']</tt></td>
    <td>String</td>
    <td>Version number of gem to be used.</td>
    <td><tt>'0.6.1'</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['path']</tt></td>
    <td>String</td>
    <td>Path of the config file</td>
    <td><tt>'/tmp' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['bindir']</tt></td>
    <td>String</td>
    <td>Directory where the gem's executables will reside.</td>
    <td><tt>'/usr/local/bin'</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['endpoint']</tt></td>
    <td>String</td>
    <td>The ACME endpoint for authorization/request of SSL certificates.</td>
    <td><tt>'https://acme-staging.api.letsencrypt.org/' # set this</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['config']['storage_type']</tt></td>
    <td>String (Possible values: 's3'(recommended) or 'filesystem')</td>
    <td>Location repo for the requested certificates. </td>
    <td><tt>'s3'</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['config']['storage']['s3_region']</tt></td>
    <td>String</td>
    <td>S3 Region</td>
    <td><tt>'us-east-1' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['storage']['s3_bucket_name']</tt></td>
    <td>String</td>
    <td>Name of the S3 bucket</td>
    <td><tt>'some-bucket' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['storage']['s3_prefix']</tt></td>
    <td>String</td>
    <td>Prefix/Namespace under which the certificates will be stored on S#</td>
    <td><tt>''</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['storage']['s3_access_key_id']</tt></td>
    <td>String</td>
    <td>AWS S3 Access Key ID</td>
    <td><tt>'' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['storage']['s3_secret_access_key']</tt></td>
    <td>String</td>
    <td>AWS S3 Access Secret</td>
    <td><tt>'' # set this</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['config']['storage']['filesystem_path']</tt></td>
    <td>String</td>
    <td>Need to set if 'filesystem' is chosen as the storage_type</td>
    <td><tt>'/tmp/keys'</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['config']['challenge_responders_type']</tt></td>
    <td>String</td>
    <td>Challenge responder, presently only 'route53' is available.</td>
    <td><tt>'route53'</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['config']['challenge_responder']['route53_access_key_id']</tt></td>
    <td>String</td>
    <td>AWS R53 Access Key ID</td>
    <td><tt>'' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['challenge_responder']['route53_secret_access_key']</tt></td>
    <td>String</td>
    <td>AWS R53 Access Secret</td>
    <td><tt>'' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['challenge_responder']['route53_session_token']</tt></td>
    <td>String</td>
    <td>AWS R53 Session Token</td>
    <td><tt>'' # set this</tt></td>
  </tr>


  <tr>
    <td><tt>['acmesmith']['config']['hosted_zone_map_domain_name']</tt></td>
    <td>String</td>
    <td>Hosted Zone Domain Name (eg: abc.com.)</td>
    <td><tt>''</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['hosted_zone_map_id']</tt></td>
    <td>String</td>
    <td>Hosted Zone Map ID (eg: /hosted_zone/DEADBEEF)</td>
    <td><tt>''</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['config']['account_key_passphrase']</tt></td>
    <td>String</td>
    <td>Account Key Passphrase</td>
    <td><tt>'password' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['config']['certificate_key_passphrase']</tt></td>
    <td>String</td>
    <td>Cerificate Key Passphrase</td>
    <td><tt>'secret' # set this</tt></td>
  </tr>


  <tr>
    <td><tt>['acmesmith']['domain']</tt></td>
    <td>String</td>
    <td>Domain for which SSL certificates need to be fetched (eg. abc.com)</td>
    <td><tt>'' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['common_name']</tt></td>
    <td>String</td>
    <td>Common Name for which SSL certificates need to be fetched (eg. xyz.abc.com)</td>
    <td><tt>'' # set this</tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['contact']</tt></td>
    <td>String</td>
    <td>Email ID of owner (eg. someone@something.com)</td>
    <td><tt>'' # set this</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['certificate_path']</tt></td>
    <td>String</td>
    <td>Path where Certificate will be written to (Set this according to your web server's configuration)</td>
    <td><tt>'' </tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['private_key_path']</tt></td>
    <td>String</td>
    <td>Path where Private Key will be written to (Set this according to your web server's configuration)</td>
    <td><tt>'' </tt></td>
  </tr>
  <tr>
    <td><tt>['acmesmith']['pkcs12_path']</tt></td>
    <td>String</td>
    <td>Path where PKCS12 will be written to (Set this according to your web server's configuration)</td>
    <td><tt>''</tt></td>
  </tr>

  <tr>
    <td><tt>['acmesmith']['renewal_script_path']</tt></td>
    <td>String</td>
    <td>Path where the renewal script will reside</td>
    <td><tt>'/usr/local/bin/'</tt></td>
  </tr>
</table>

## Usage

### acmesmith::default


e.g.
Just include `acmesmith` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[acmesmith]"
  ]
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

