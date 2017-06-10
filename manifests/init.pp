#
# === Authors
#
# Arun Singh <arunsingh.in@gmail.com>
#
# === Copyright
#
# Copyright 2017 Arun Singh for Wingify.com, unless otherwise noted.
#

class openresty(
  $openresty_version='1.11.2.2'
)
{

  $package_dependency = $osfamily ? {
    'redhat' => ['pcre', 'pcre-devel', 'openssl', 'openssl-devel'],
    'debian' => ['libpcre3','libpcre3-dev', 'libssl-dev'],
    'default' => ['pcre','pcre-devel', 'openssl', 'openssl-devel'],
  }
  package { $package_dependency :
     ensure => installed,
  }

  exec {'download and untar openresty':
    cwd => '/tmp/',
    command => "wget https://openresty.org/download/openresty-${openresty_version}.tar.gz; tar -xvf openresty-${openresty_version}.tar.gz",
    creates => "/tmp/openresty-${openresty_version}.tar.gz",
    path    => ['/usr/bin', '/usr/sbin','/urs/local/sbin','/usr/local/bin','/bin','/sbin',],
 }


  exec {'configure openresty':
   cwd => "/tmp/openresty-${openresty_version}",
   command => "/bin/bash -c cd /tmp/openresty-${openresty_version}; ./configure --with-pcre --with-pcre-jit --with-lua51 --with-luajit --with-http_ssl_module --without-http_rewrite_module;",
   path => ['/usr/bin/env','/usr/bin', '/usr/sbin','/urs/local/sbin','/usr/local/bin','/bin','/sbin',],
   timeout => 0,
   logoutput => true,
   require => Package[$package_dependency]
 }


  exec {'install openresty':
   cwd => "/tmp/openresty-${openresty_version}",
   command => "/bin/bash -c cd /tmp/openresty-${openresty_version};make; make install",
   path => ['/usr/bin/env','/usr/bin', '/usr/sbin','/urs/local/sbin','/usr/local/bin','/bin','/sbin',],
   timeout => 0,
   logoutput => true,
 }

  Exec['download and untar openresty'] -> Exec['configure openresty']
  Exec['configure openresty'] -> Exec['install openresty']
}

