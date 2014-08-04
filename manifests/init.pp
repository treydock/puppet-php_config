# == Class: php_config
#
class php_config (
  $notify_apache  = true,
  $apache_service_name = $::php_config::params::apache_service_name,
  $php_package_name = $::php_config::params::php_package_name,
  $php_configs = {},
) inherits php_config::params {

  validate_bool($notify_apache)

  include ::apache
  include ::apache::mod::php

  # Ensure php5 package (ref: puppetlabs-apache) is installed before
  # php_config resources
  Package[$php_package_name] -> Php_config<| |>

  # Optionally restart Apache service if php_config resources are modified
  if $notify_apache {
    Php_config<| |> ~> Service[$apache_service_name]
  }

  create_resources('php_config', $php_configs)

}
