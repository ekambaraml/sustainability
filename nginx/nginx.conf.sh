# Configuration parameters
export SOURCE_CLUSTER_DOMAIN=ibmsmoc.cp.fyre.ibm.com
export SOURCE_MAXIMO_INSTANCE_WORKSPACE=dev

export TARGET_CLUSTER_DOMAIN=smoc.cp.fyre.ibm.com
export TARGET_MAXIMO_INSTANCE_WORKSPACE=dev

# Create nginx.conf

cat > nginx.conf << EOF
worker_processes auto;

pid /tmp/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
# include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}



http {

# These variables aren't currently being used, but if you have time you could use them when forming
# the domain names used later one, thus making this config easier to re-use.

    map '' $mas_domain {
                default  "${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}";
        }
   
    map '' $proxy_domain {
                default    "${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"";
        }


    server_names_hash_bucket_size  128;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    log_format  proxy_log  '$remote_addr - $remote_user [$time_local] '
                                                        '"request_uri" $request_uri '
                                                        '"request" $request '
                                                        '"status" $status '
                            '"host" $host '
                            '"origin" $http_origin '
                                                        '"proxy_host" $proxy_host '
                                                        '"upstream_addr" $upstream_addr '
                                                        '"http_location" $http_location '
                                                        '"upstream_http_location" $upstream_http_location '
                                                        '"upstream_http_set_cookie" $upstream_http_set_cookie '
                                                        '"args" $args';



    access_log  /tmp/access.log proxy_log;
    error_log   /tmp/error.log error;

    client_body_temp_path /tmp/nginx 1 2;
    proxy_temp_path /tmp/nginx-proxy;
    fastcgi_temp_path /tmp/nginx-fastcgi;
#   uwsgi_temp_path /tmp/nginx-uwsgi;
#   scgi_temp_path /tmp/nginx-scgi;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    #include /etc/nginx/conf.d/*.conf;

# Domains used in user-facing URLs
   server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;
        
        server_name admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;

        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://admin-dashboard.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-core.svc.cluster.local/;
            proxy_redirect https://admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://admin.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://auth.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_set_header Host admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
            proxy_cookie_domain ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            
            proxy_hide_header Content-Security-Policy;
            add_header Content-Security-Policy "default-src https://* 'self';font-src 'self' data: https://1.www.s81c.com *.walkme.com;img-src 'self' data: *.walkme.com s3.walkmeusercontent.com *.cloudfront.net/customers/IBM/ mp.s81c.com s3.us.cloud-object-storage.appdomain.cloud;style-src 'self' 'unsafe-inline' *.walkme.com;script-src 'self' 'unsafe-eval' 'sha256-G0d/YkJrr6akA75BrKl0r6pAC+2f5xjHTlC11qYbxkw=' 'sha256-Phm/goMXGJ3h9oEFMmEq0xPHqWcrZLj0l6m31gpK5B8=' 'sha256-nKfYhKkHDc3OG7ErvOaNtPs/GDxVHz2aOxbm082UAfg=' *.walkme.com;frame-src *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' localhost:* *.walkme.com;frame-ancestors *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' *.walkme.com;object-src *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' *.walkme.com" always;
        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
    
    server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;

        server_name home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;

        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://homepage.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-core.svc.cluster.local/;
            proxy_redirect https://admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://admin.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://auth.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN}
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_set_header Host home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_cookie_domain ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            
            proxy_hide_header Content-Security-Policy;
            add_header Content-Security-Policy "default-src https://* 'self';font-src 'self' data: https://1.www.s81c.com *.walkme.com;img-src 'self' data: *.walkme.com s3.walkmeusercontent.com *.cloudfront.net/customers/IBM/ mp.s81c.com s3.us.cloud-object-storage.appdomain.cloud;style-src 'self' 'unsafe-inline' *.walkme.com;script-src 'self' 'unsafe-eval' 'sha256-G0d/YkJrr6akA75BrKl0r6pAC+2f5xjHTlC11qYbxkw=' 'sha256-Phm/goMXGJ3h9oEFMmEq0xPHqWcrZLj0l6m31gpK5B8=' 'sha256-nKfYhKkHDc3OG7ErvOaNtPs/GDxVHz2aOxbm082UAfg=' *.walkme.com;frame-src *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' localhost:* *.walkme.com;frame-ancestors *.test.apps.${TARGET_CLUSTER_DOMAIN} 'self' *.walkme.com;object-src *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' *.walkme.com" always;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

    server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;
        
        server_name ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.mas-ml.cp.fyre.ibm.com;
        port_in_redirect off;

        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://navigator.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-core.svc.cluster.local/;
            proxy_redirect https://admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://admin.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://auth.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_set_header Host ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_cookie_domain ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            
            
            proxy_hide_header Content-Security-Policy;
            add_header Content-Security-Policy "default-src https://* 'self';font-src 'self' data: https://1.www.s81c.com *.walkme.com;img-src 'self' data: *.walkme.com s3.walkmeusercontent.com *.cloudfront.net/customers/IBM/ mp.s81c.com s3.us.cloud-object-storage.appdomain.cloud;style-src 'self' 'unsafe-inline' *.walkme.com;script-src 'self' 'unsafe-eval' 'sha256-G0d/YkJrr6akA75BrKl0r6pAC+2f5xjHTlC11qYbxkw=' 'sha256-Phm/goMXGJ3h9oEFMmEq0xPHqWcrZLj0l6m31gpK5B8=' 'sha256-nKfYhKkHDc3OG7ErvOaNtPs/GDxVHz2aOxbm082UAfg=' *.walkme.com;frame-src *.mastest.apps.mas-ml.cp.fyre.ibm.com 'self' localhost:* *.walkme.com;frame-ancestors *.mastest.apps.mas-ml.cp.fyre.ibm.com 'self' *.walkme.com;object-src *.mastest.apps.mas-ml.cp.fyre.ibm.com 'self' *.walkme.com" always;

        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
    
    
    
#  Domains used in URLs used internally (HTTP redirects or XHR requests)

    server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;
        
        server_name api.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;

        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://coreapi.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-core.svc.cluster.local/;
            
            # Match anything not empty
            if ($http_origin ~ '.+') {
              add_header 'Access-Control-Allow-Origin' "$http_origin" always;
              add_header 'Access-Control-Allow-Credentials' 'true' always;
              add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
              add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Requested-With' always;
            }

             
            sub_filter_types application/json;
            sub_filter_once off;
            sub_filter test.apps.mas-ml.cp.fyre.ibm.com mastest.apps.${TARGET_CLUSTER_DOMAIN};

        }
        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
    
    server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;
        
        server_name auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;
   
        location /login {
            proxy_ssl_server_name on;
            proxy_pass  https://coreidp-login.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-core.svc.cluster.local;
            proxy_set_header Host $host;
        }

        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://coreidp.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-core.svc.cluster.local/;
            proxy_set_header Host $host;
            proxy_redirect https://admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://admin.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://auth.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.home.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN}m;
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://maxinst.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://maxinst.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
}

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }

#manage related urls


    server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;

        server_name ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;

        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-manage.svc.cluster.local;
            proxy_redirect https://auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://auth.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://maxinst.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://maxinst.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_set_header Host ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
            proxy_cookie_domain ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};

            sub_filter_types application/json;
            sub_filter_once off;
            sub_filter test.apps.mas-ml.cp.fyre.ibm.com ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};


            proxy_hide_header Content-Security-Policy;
            add_header Content-Security-Policy "default-src https://* 'self';font-src 'self' data: https://1.www.s81c.com *.walkme.com;img-src 'self' data: *.walkme.com s3.walkmeusercontent.com *.cloudfront.net/customers/IBM/ mp.s81c.com s3.us.cloud-object-storage.appdomain.cloud;style-src 'self' 'unsafe-inline' *.walkme.com;script-src 'self' 'unsafe-eval' 'sha256-G0d/YkJrr6akA75BrKl0r6pAC+2f5xjHTlC11qYbxkw=' 'sha256-Phm/goMXGJ3h9oEFMmEq0xPHqWcrZLj0l6m31gpK5B8=' 'sha256-nKfYhKkHDc3OG7ErvOaNtPs/GDxVHz2aOxbm082UAfg=' *.walkme.com;frame-src *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' localhost:* *.walkme.com;frame-ancestors *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' *.walkme.com;object-src *.mastest.apps.${TARGET_CLUSTER_DOMAIN} 'self' *.walkme.com" always;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
   server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;

        server_name maxinst.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;


        location /erd {
            proxy_ssl_server_name on;
            proxy_pass  https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-maxinst.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-manage.svc.cluster.local;
            proxy_set_header Host $host;
        }

        location /toolsapi {
            proxy_ssl_server_name on;
            proxy_pass  https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-maxinst.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-manage.svc.cluster.local;
            proxy_set_header Host $host;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
   server {
        listen 9443 ssl http2;
        listen [::]:9443 ssl http2;
        ssl_certificate /etc/ssl/certs/nginx-cert/tls.crt;
        ssl_certificate_key /etc/ssl/certs/nginx-cert/tls.key;

        server_name ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN};
        port_in_redirect off;
        proxy_busy_buffers_size   512k;
        proxy_buffers   4 512k;
        proxy_buffer_size   256k;
        large_client_header_buffers 4 32k;
        location / {
            proxy_ssl_server_name on;
            proxy_pass  https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.mas-${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-manage.svc.cluster.local;
            proxy_redirect https://auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://auth.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://maxinst.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://maxinst.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_redirect https://${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} https://${TARGET_MAXIMO_INSTANCE_WORKSPACE}.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_set_header Host ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.manage.${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            proxy_cookie_domain ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};
            sub_filter_types application/json text/html text/xml;
            sub_filter_once off;
            proxy_set_header Accept-Encoding "";
            sub_filter ${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN} ${TARGET_MAXIMO_INSTANCE_WORKSPACE}.apps.${TARGET_CLUSTER_DOMAIN};

        
}

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }


}
EOF


