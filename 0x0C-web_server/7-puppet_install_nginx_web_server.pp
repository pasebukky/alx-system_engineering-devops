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
file { '/etc/nginx/sites-enabled/default':
  ensure  => 'file',
  content => '
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location /redirect_me {
        return 301 https://www.google.com;
    }

}
',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
}
