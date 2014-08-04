# puppet-php_config

[![Build Status](https://travis-ci.org/treydock/puppet-php_config.png)](https://travis-ci.org/treydock/puppet-php_config)

TODO

## Usage

### Class: php_config

TODO

### Type: php_config

TODO

## Reference

Types:

* [php_config](#type-php_config)

### Type: php_config

This type provides the capability to manage values in */etc/php.ini*.

The name is in form of 'section/setting'.

####`ensure`

Can either be `present` or `absent`.  Defaults to `present`.

####`value`

The php_config value to set.

If *ensure* is `present` then value must be defined.

## Development

### Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

Run the tests from root of the source code:

    bundle exec rake test

You can also run acceptance tests:

    bundle exec rake beaker

## TODO

* 