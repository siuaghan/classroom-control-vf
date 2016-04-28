class nginx {
  File {
    owner =>  'root',
    group =>  'root',
    mode  =>  '0664',
  }
  
  Package { 'nginx':
    ensure => present,
  }
  
  
  File { ['/var/www', '/etc/nginx/conf.d']:
    ensure => directory,
  }
  
  File { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  File { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  File { '/etc/nginx/conf.d/default.conf':
    source  => 'puppet:///modules/nginx/default.conf',
    notify  => Service['nginx'],
    require => Package['nginx'],
  }
  Service { 'nginx':
    ensure    => running,
    enable    => true,
  }
}
