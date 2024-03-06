# Puppet script to create a custom HTTP header response

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
  before   => Exec['install Nginx'],
}

exec { 'install Nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
  before   => File['/etc/nginx/sites-available/custom_header'],
}

file { '/etc/nginx/sites-available/custom_header':
  ensure  => present,
  content => "server {
    listen 80;
    server_name _;
    rewrite /redirect_me https://google.com permanent;
    add_header X-Served-By $hostname;
  }",
  before   => Exec['enable_custom_header'],
}

exec { 'enable_custom_header':
  provider => shell,
  command  => 'sudo ln -sf /etc/nginx/sites-available/custom_header /etc/nginx/sites-enabled/',
  before   => Exec['restart Nginx'],
}

exec { 'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
  require  => Exec['enable_custom_header'],
}
