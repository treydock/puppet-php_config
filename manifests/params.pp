# == Class: php_config::params
#
# The php_config configuration settings.
#
class php_config::params {

  case $::osfamily {
    'RedHat': {
      $apache_service_name  = 'httpd'
      $php_package_name     = 'php'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
