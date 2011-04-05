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

