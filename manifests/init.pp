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
  # command => "/bin/bash -c cd /tmp/openresty-${openresty_version}; ./configure --with-pcre --with-pcre-jit --with-lua51 --with-luajit --with-http_ssl_module --without-http_rewrite_module;",
  command => "/bin/bash -c cd /tmp/openresty-${openresty_version}; ./configure --with-openssl=/usr/include/openssl --with-pcre --with-pcre-jit --with-luajit --without-http_echo_module --without-http_xss_module --without-http_coolkit_module --without-http_set_misc_module --without-http_form_input_module --without-http_srcache_module --without-http_lua_module --without-http_lua_upstream_module --without-http_headers_more_module --without-http_array_var_module --without-http_memc_module --without-http_redis2_module --without-http_redis_module --without-http_rds_json_module --without-http_rds_csv_module --without-ngx_devel_kit_module --without-http_ssl_module --without-lua_cjson --without-lua_redis_parser --without-lua_rds_parser --without-lua_resty_dns --without-lua_resty_memcached --without-lua_resty_redis --without-lua_resty_mysql --without-lua_resty_upload --without-lua_resty_upstream_healthcheck --without-lua_resty_string --without-lua_resty_websocket --without-lua_resty_lock --without-lua_resty_lrucache --without-lua_resty_core --without-lua51 --without-select_module --without-poll_module --without-http_charset_module --without-http_gzip_module --without-http_ssi_module --without-http_userid_module --without-http_access_module --without-http_auth_basic_module --without-http_autoindex_module --without-http_geo_module --without-http_map_module --without-http_split_clients_module --without-http_referer_module --without-http_rewrite_module --without-http_proxy_module --without-http_fastcgi_module --without-http_uwsgi_module --without-http_scgi_module --without-http_memcached_module --without-http_limit_conn_module --without-http_limit_req_module --without-http_empty_gif_module --without-http_browser_module --without-http_upstream_ip_hash_module --without-http_upstream_least_conn_module --without-http_upstream_keepalive_module --without-http-cache --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module;",
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

