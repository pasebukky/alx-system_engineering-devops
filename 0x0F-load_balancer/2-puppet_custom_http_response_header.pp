# Puppet script to create a custom HTTP header response

package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
  ensure  => 'present',
}

file { '/var/www/html/404.html':
  content => 'Ceci n\'est pas une page',
  ensure  => 'present',
}

file { '/etc/nginx/sites-enabled/default':
  ensure  => 'present',
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
}

# Custom HTTP header configuration
file { '/etc/nginx/sites-enabled/default':
  ensure  => 'present',
  content => "server_name _;\n\tadd_header X-Served-By $hostname;\n\trewrite /redirect_me https://google.com permanent;",
  notify  => Service['nginx'],
}
