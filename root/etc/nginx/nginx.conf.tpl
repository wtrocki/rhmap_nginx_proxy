daemon off;

http {
    include    /etc/nginx/proxy.conf;
    include    /etc/nginx/mime.types;

    server {
	    client_body_temp_path /tmp/nginx_client_temp 1 2;
        listen 8080 default_server;
        resolver ${DNS_SERVER};
        access_log /dev/stdout;

        ## Match every first element of the path and proxy to subdomain 
        ## https://test.net/value/test will proxy to https://value.test.net/test
        location ~* ^/([^/]+)(.*) {
            proxy_pass ${MBAAS_PROTOCOL}://$1.${MBAAS_HOST_BASE}/$2;
            proxy_cookie_path / /$1;
        }
        
        ## Match root to proxy to platform gui.
        location = / {
            proxy_pass ${CORE_SERVICE_URL};
        }
    }
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
}

error_log  /dev/stdout debug;
events {
    worker_connections  2048;
}