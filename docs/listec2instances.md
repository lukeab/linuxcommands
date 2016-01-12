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
server1     10.209.131.21   i-xxxxxxxx  eu-west-1a
server2     10.209.132.12   i-xxxxxxxx  eu-west-1b
server3     10.200.100.3    i-xxxxxxxx  eu-west-1c
```
