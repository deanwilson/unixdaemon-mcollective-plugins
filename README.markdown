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
