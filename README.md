# Deprecated - 2015/11/19 #

This Puppet type was one of my earlier public releases and while it does still work I'd highly recommend using
[https://forge.puppetlabs.com/puppetlabs/apt](https://forge.puppetlabs.com/puppetlabs/apt#add-an-apt-source-to-etcaptsourceslistd) 
instead.

I'd like to say thank you to all the people that have sent me nice emails about this chunk of code over the years.

## Puppet APT Source.list type ##

Manage Debian / Ubuntu source.list files under `/etc/apt/sources.list.d`


Usage:

    aptsourced { 'backports':
      uri          => 'http://www.backports.org/debian',
      distribution => $lsbdistcodename,
      components   => [ 'main', 'contrib' ],
    }

    aptsourced { 'internalrepo.list':
      ensure       => 'present',   # optional
      repotype     => 'deb-src',
      uri          => 'http://localhost/debian',
      distribution => $::lsbdistcodename,
      components   => [ 'main', 'nonfree' ],
    }

Copyright - [Dean Wilson](http://www.unixdaemon.net) dean.wilson@gmail.com

License: GPLv2
