# Setup nginx server

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Set up the Hello World page
file { '/var/www/html/index.html':
  content => 'Hello World!',
  owner   => 'www-data',
  group   => 'www-data',
}

# Add location block for /redirect_me to Nginx configuration
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => template('nginx/nginx.conf.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
