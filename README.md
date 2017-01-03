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

![](http://m.memegen.com/952r4r.jpg)

## Runnning

Depending on requirements users can lanuch this proxy as standalone docker container or use openshift. 

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

> MBAAS_HOST_BASE `required`

OpenShift MbaaS hostname without subdomain part. 
If your app has route `https://appname.mbaas.net`  then `MBAAS_HOST_BASE` should be set to `mbaas.net`

>  MBAAS_PROTOCOL `optional`

MbaaS protocol. By default https. Added for debug purposes

> DNS_SERVER `optional`

DNS server that would be used to retrieve ips. 
For internal networks you would need to specify your local DNS server.

> ROOT_REDIRECT_URL `optional`

Full url that would be used when proxing without path (just hostname). For example: `https://yourdomain.net`
You can redirect to any internal website that would be used as main website for nginx domain.

