#!/usr/bin/env ruby

site :opscode

# Locking version of the python cookbook that uses setuptools instead of distribute
cookbook 'python',
   :git => 'https://github.com/opscode-cookbooks/python.git',
   :ref => '345c56acefdd8670938cd7d29a19fc5394aad9fc'
cookbook 'apt'
cookbook 'yum'

cookbook 'firewall',
   :git => 'https://github.com/opscode-cookbooks/firewall.git',
   :ref => '34b9f28ad74bdfcc853661ff5d7bc5868d5610d3'

cookbook 'nginx',
   :git => 'https://github.com/opscode-cookbooks/nginx.git',
   :ref => '38c231ef10d8512422f66311ac2f2b175459ec27'

cookbook 'supervisor',
   :git => 'https://github.com/opscode-cookbooks/supervisor.git',
   :ref => '3bcf67b4541554a013c2d5a99ac204eb33fd9dd4'

metadata
