# RHMAP nginx proxy

Universal RHMAP platform proxy that can be used to map core and 
mbaas requests outside OpenShift environment.

## Purpose of this repository

Provide mapping and proxy between public nginx proxy and
mbaas and core components running on openshift platform.
By default proxy would use single hostname for every mbaas application.

## Runnning

Depending on requirements users can lanuch this proxy as standalone docker container or use openshift. 

### OpenShift 

To install proxy on openshift use supplied template

    oc new-app -f openshift/rhmap-nginx-proxy.json

> Note: When running this template security context constraint should allow to run pods as users with UID bellow 1000 

### Docker

Proxy can be launched on any operating system that supports docker (Windows, Linux and MacOSX)

To run service pull image from registry:

    docker pull wtrocki/nginx-proxy:direct

Run downloaded image 

    docker run -it -p 80:8080 -e ROOT_REDIRECT_URL=http://yourserver.feedhenry.com wtrocki/nginx-proxy:centos7


## Environment variables

> MBAAS_ROUTER_URL `required`

OpenShift MbaaS router URL prefix.
 
> DNS_SERVER `optional`

DNS server that would be used to retrieve ips. 
For internal networks you would need to specify your local DNS server.
> ROOT_REDIRECT_URL `optional`

Full url that would be used when proxing without path (just hostname). For example: `https://yourdomain.net`
You can redirect to any internal website that would be used as main website for nginx domain.
