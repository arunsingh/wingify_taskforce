<b> Problem Statement</b><br>
*We use a custom build of Nginx called Openresty. You have to write a Puppet module for installing Openresty on a Linux server.  OpenResty needs to be compiled from source. OpenResty comes with a lot of 3rd party modules. Not all of them are useful.

*For the scope of this problem, compile OpenResty with the following modules (i.e. don't compile all the other modules that are bundled with OpenResty): - HTTP SSL - Lua JIT - PCRE and PCRE JIT  Expectations are that running this module will just make a machine ready to deploy with OpenResty.  


*When you are done, please publish the module on Github and share the link of the repo with us.  



<b>Openresty Puppet Module Install from Source</b> <br>
* This Puppet module is used to configure and install openresty from source with custom or third party modules.

* It will install following modules:

*HTTP SSL
*Lua JIT
*PCRE and PCRE JIT

<b>How to run</b><br>

<i>on standalone puppet agent:</i>
* Place the module "openresty" in /etc/puppet/modules folder
* Run command : puppet apply --modulepath=/etc/puppet/modules -e "include openresty" --debug

<i>on Master-agent Architecture:</i>
* Use the module on master server, 
* sync the agent with master
* run puppet agent command on Agent Node Server.

<b>Dependencies</b><br>
* In case of dependency failure, Update the package manager(yum/apt) used on Agent node server
