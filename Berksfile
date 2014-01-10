#!/usr/bin/env ruby

site :opscode

# Locking version of the python cookbook that uses setuptools instead of distribute
cookbook 'python',
    :git => 'https://github.com/comandrei/python.git',
    :ref => '2cc384b5d996ca8b701826af265334bda40d0201'
#   :git => 'https://github.com/poise/python.git',
#   :ref => '8ce88cd17b0d6c64e948f1580815b5884b3c0f26'

cookbook 'apt'
cookbook 'yum'

cookbook 'runit'

cookbook 'nginx',
   :git => 'https://github.com/opscode-cookbooks/nginx.git',
   :ref => 'd7a41ce15b30f91df95195b213d95bb9b3a6c4c3'

cookbook 'supervisor',
   :git => 'https://github.com/poise/supervisor.git',
   :ref => 'ffd88b59e3df97613b9ecfd53d489f6715551755'

metadata
