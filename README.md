# ansible-collection-rapidpro
RapidPro Ansible Collection

## Requirements
This collection is tested on Ansible `2.10.6`

## Ansible-Galaxy requirements
This collection uses roles that depend on other external roles. Make sure to import them into your environment before using this collection

## Required variables

In order to use this collection, make sure the following variables are defined in your inventory. You can look at the example deployment for sample inventory values:

 - `rapidpro_setup_type`: The RapidPro deployment architecture. Possible values are `load-balanced`
- `rapidpro_domains`: List of RapidPro domains. Example:

```yaml
 rapidpro_domains:
  - example.com
  - www.example.com
```

- `rapidpro_admin_email`: Superuser account's Email address.
- `rapidpro_email`: Default Email address used to send flow Emails and support emails.

- `rapidpro_database_server_address`: Address of the PostgreSQL server
- `rapidpro_app_server_addresses`: Addresses of the RapidPro application servers
- `rapidpro_postgresql_password`: RapidPro PostgreSQL database password
- `rapidpro_monitoring_server_address`: Address of the monitoring server
- `deployment_owner`: Name of the deployment owner. For example `example-org`
- `slack_monit_endpoint`: A slack endpoint to be used to send alerts. set to `""` to disable sending alerts.
- `server_monitoring_opsgenie_api_key`: An Opsgenie api key, to be used to send alerts. set to `""` to disable sending alerts to opsgenie.
- `rapidpro_postgresql_ssl_domain`: The hostname/domain name to set as the common name in the TLS certificate
- `rapidpro_postgresql_ssl_ca_key`: An SSL certificate key used to encrypt PostgreSQL traffic. Check the section on [PostgreSQL TLS](#postgresql-tls) on how to generate a key
- `rapidpro_postgresql_ssl_ca_cert`: Check the section on [PostgreSQL TLS](#postgresql-tls) on how to generate the cert
- `rapidpro_backup_gpg_private_key`: Path in your playbooks to fetch the PGP private key. Refer to [docs/generating-gpg-key.md](./docs/generating-gpg-key.md) on how to generate a GPG key
- `rapidpro_backup_gpg_public_key`: Path in your playbooks to fetch the PGP public key
- `rapidpro_backup_gpg_trust_file`: Path in your playbooks containing the exported trust to grant the imported keypair

## Common optional variables
`rapidpro_version`: Version of RapidPro to setup. Note that you will need to update the version of mailroom and courier to use that will be compatible with the selected version by setting `rapidpro_mailroom_version`, `rapidpro_indexer_version` and `rapidpro_courier_version` when you change the default version.

`rapidpro_smtp_host`: SMTP host to use to send emails. For example `smtp.office365.com`
`rapidpro_smtp_port`: SMTP server port. Default is `587`
`rapidpro_smtp_user`: SMTP authentication username
`rapidpro_smtp_password`: SMTP authentication password
`rapidpro_smtp_use_tls`: Should the SMTP connection use TLS? Default is `true`

## PostgreSQL TLS

To generate your TLS root CA:

```sh
openssl req -new -nodes -text -out root.csr -keyout root.key -subj "/CN=root.yourdomain.com"

chmod og-rwx root.key

openssl x509 -req -in root.csr -text -days 3650 -extfile /etc/ssl/openssl.cnf -extensions v3_ca -signkey root.key -out root.crt
```