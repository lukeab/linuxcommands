# linuxcommands
Little repo of funky commands, in development, bash python ruby or whatever. 

Tools still to come(idea list):
 * aws account cluster ssh wrapper (done):white_check_mark:
 * some zsh plugins for github
 
####Installation
Unless the system gets much more advanced I suggest just cloning the repo, then symlink scripts to your path( eg. ~/bin ) as needed.


##Tools

### mfatool:
Simple bash script, a utility to retrieve stored keys for multifactor authentication totp codes. Works much like google authenticator, tested with gmail, amazon aws, github, akamai luna, bitbucket. 
Should work with most services that use totp, time base code generation.
##### Dependencies: 
###### linux:
secret-tool, oathtool
###### Mac OsX
secret-tool and oathtool are available under homebrew
 - brew install oath-toolkit
 - brew install libsecret
(one issue run into is unwritable /usr/local so possible solutions suggested here
https://github.com/Homebrew/homebrew/issues/3930)


TODO: 
* test on Mac OsX - homebrew install and keychain functionality.
* add zsh or oh-my-zsh autocomplete functions for manage keys
* use better getopts in shell scripts.
* add Mac OsX vs linux detection for porting functionality 


### [list ec2 Instances](docs/listec2instances.md)
### [cluster ssh ec2](docs/clustersshec2.md)

