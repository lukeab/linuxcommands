# listec2instances

This script connects to aws and lists the instances in your aws vpc.
It's a very simple script right now and maybe needs some improving.

## Instalation
make sure you have awscli setup and create the `$HOME/.aws/credentials` and `$HOME/.aws/config` setup so you can refer to your environments by config name.

edit the script or set env vars(lets use posix style default setters in the script) setting the ENVPREFIX value to what you like, or leave it blank and write the full aws config name each time.

### Dependencies
packages 
* jq - general tool allowing cli parsing of json returns from web services
* python
* pip
 
PIP library
* awscli
 
## Usage
```
listec2instances [envname]
```
eg
```
listec2instances itv-dotcom-sit
```
output:
```
bastion     10.209.131.59   i-1fdecfb5  eu-west-1a
bastion     10.209.132.89   i-90399c3d  eu-west-1b
bastion     10.209.133.182  i-e7da0a4b  eu-west-1c
dockerhost  10.209.135.119  i-197babe0  eu-west-1b
fetd        10.209.135.186  i-f37bad0a  eu-west-1b
fetd        10.209.136.18   i-20169d8a  eu-west-1c
fetdqa      10.209.134.26   i-7056dcc9  eu-west-1a
fetdqa      10.209.136.139  i-1a22f1a3  eu-west-1c
graphite    10.209.134.185  i-a634792d  eu-west-1a
graphite    10.209.135.29   i-6bd7bdd3  eu-west-1b
jenkins     10.209.136.195  i-fc65e556  eu-west-1c
logstash    10.209.134.79   i-d3eeec6a  eu-west-1a
logstash    10.209.135.70   i-2eda60a3  eu-west-1b
logstash    10.209.136.83   i-1266c6ab  eu-west-1c
mcorabbit   10.209.134.119  i-5e2a6dd5  eu-west-1a
qawebapp    10.209.134.252  i-0a1a2ea0  eu-west-1a
qawebapp    10.209.135.181  i-d595442c  eu-west-1b
qawebapp    10.209.136.94   i-dde06877  eu-west-1c
rabbitmq    10.209.134.77   i-2ce6d086  eu-west-1a
rabbitmq    10.209.135.215  i-b57bab4c  eu-west-1b
rabbitmq    10.209.136.10   i-eacd5340  eu-west-1c
webapp      10.209.134.214  i-1a5b74b0  eu-west-1a
webapp      10.209.135.102  i-5927efa0  eu-west-1b
webapp      10.209.136.219  i-6f65e5c5  eu-west-1c
```
