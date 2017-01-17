# RHMAP nginx proxy

Universal RHMAP platform proxy that can be used to map core and 
mbaas requests outside OpenShift environment.

## Purpose of this repository

Provide mapping and proxy between public nginx proxy and
mbaas and core components running on openshift platform.
By default proxy would use single hostname for every mbaas application 
and I would map first element of the path into subdomain internally.

> For example request to https://feedhenryplatform.net/yourapp/endpoint?test=3 will proxy to https://yourapp.feedhenryplatform.net/endpoint?test=3

Proxy root path (https://feedhenryplatform.net) would redirect to platform GUI

## Running

Depending on requirements users can launch this proxy as standalone docker container or use openshift. 

### OpenShift 

To install proxy on openshift use supplied template

    oc new-app -f openshift/rhmap-nginx-proxy.json

> Note: When running this template security context constraint should allow to run pods as users with UID bellow 1000 

### Docker

Proxy can be launched on any operating system that supports docker (Windows, Linux and MacOSX)

To run service pull image from registry:

    docker pull wtrocki/nginx-proxy:centos7

Run downloaded image 

    docker run -it -p 80:8080 -e MBAAS_HOST_BASE=yourserver.feedhenry.com wtrocki/nginx-proxy:centos7


## Environment variables

>  BASE_HOST `optional`

Full base host url that would be used to proxy to the mbaas, core and apps.
It represents openshift router dns without wildcard.

> DNS_SERVER `optional`

DNS server that would be used to retrieve ips. 
For internal networks you would need to specify your local DNS server.

> LOG_LEVEL `optional` 

Nginx log level. By default it's INFO.