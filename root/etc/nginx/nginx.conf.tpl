daemon off;

http {
    include /etc/nginx/proxy.conf;
    include /etc/nginx/mime.types;

    server {
	    client_body_temp_path /tmp/nginx_client_temp 1 2;
        listen 8080 default_server;
        resolver ${DNS_SERVER};
        access_log /dev/stdout;

        ## Expose platform app init api
        location = /box/srv/1.1/app/init {
           proxy_pass ${ROOT_REDIRECT_URL}/$request_uri;
        }

        ## Redirect environment part of the hostname
        ## Example test.com/envid/appid/someurl
        location ~* ^/([^/]+)/([^/]+)(.*) {
            proxy_pass https://$1.${MBAAS_ROUTER_URL}/$2$3$is_args$args;
            proxy_redirect https://$1.${MBAAS_ROUTER_URL} /$1/$2;
            proxy_cookie_path / /$1/$2;
        }
        
        location = /favicon.ico {
            log_not_found off;
        }
    }
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
}

error_log  /dev/stdout ${LOG_LEVEL};
events {
    worker_connections  2048;
}
