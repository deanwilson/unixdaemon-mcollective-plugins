Unixdaemon Mcollective Plugins
==============================

This repository contains some of my mcollective plugins.

Filemd5er
-----------

This simple agent will MD5 the given file on each node in the filter and
then aggregate the results. This can be helpful before you add a new file
to Puppet/Chef management, run this agent on the given file, investigate
the outliers and then add the common version to the management system.

You can now do something very similar in the filemgr agent, but that didn't
exist when I wrote mine.


Working Prototypes
==================

The plugins work but are a little rougher around the edges and often don't
have a utility command to run them, instead being invoked by the rpc
client.

Filecount
-----------

Show the number of files matching the glob.

mco rpc filecount filecount file='/tmp/*'


Locator
-----------

Run a locate on each node and show the results, either all the paths (in
the first example) or the count. It's amusing to see how many .old files
exist on a system.

mco rpc locator locator filename='/hosts$'
mco rpc locator count_located filename='/hosts$'

Resolver
-----------

Does basic DNS resolution. Currently only supports A and MX records. Under
the hood it uses the ruby resolv lib, which has a bad reputation.

mco rpc resolver resolve host=google.com type=MX
mco rpc resolver resolve host=google.com type=A


MySQL
-----------

Allows querying of global status and variables from running MySQL
instances.

In order to use this plugin you need a little bit of config. First you
should create a user in your mysql databases that can connect via 127.0.0.1
and run both 'SHOW GLOBAL STATUS;' and 'SHOW GLOBAL VARIABLES;'. Once this
is done you need to create, and deploy, a file containing the authentication
details that this plugin can use. The files contents should look like
"__default__::dbusername::dbpassword" and the location of your config files
should be specified as plugin.mysql.authfile = /path/to/your/file.conf in
your mcollective config files.

mco rpc mysql get_variable query=warning_count
mco rpc mysql get_setting  query=Slow_queries
