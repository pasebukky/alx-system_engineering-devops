# Puppet script to create a custom HTTP header response

exec { 'update':
  command  => '/usr/bin/apt-get -y update',
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update'],
}

exec { 'add_header':
  environment => ["HOST=${fqdn}"],
  command     => '/bin/sed -i "/server_name _/a add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-enabled/default',
  before      => Service['nginx'],
}

service { 'nginx':
  ensure     => 'running',
  enable     => true,
  subscribe  => Exec['add_header'],
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
  content => "server {\n\tserver_name _;\n\trewrite /redirect_me https://google.com permanent;\n}",
  notify  => Service['nginx'],
}
