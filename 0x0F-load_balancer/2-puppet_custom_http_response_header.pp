# Puppet script to create a custom HTTP header response

# Ensure the system is updated
exec { 'update':
  command  => '/usr/bin/apt-get -y update',
}

# Install Nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update'],
}

# Create the index.html page
file { '/var/www/html/index.html':
  content => 'Hello World!',
  ensure  => 'present',
}

# Create the 404.html page
file { '/var/www/html/404.html':
  content => 'Ceci n\'est pas une page',
  ensure  => 'present',
}

# Modify the Nginx configuration file
file { '/etc/nginx/sites-enabled/default':
  content => "server {
    server_name _;
    rewrite /redirect_me https://google.com permanent;
    add_header X-Served-By $hostname;
  }",
  ensure  => 'present',
  notify  => Service['nginx'],
}

# Ensure the Nginx service is running
service { 'nginx':
  ensure     => 'running',
  enable     => true,
  subscribe  => File['/etc/nginx/sites-enabled/default'],
}
