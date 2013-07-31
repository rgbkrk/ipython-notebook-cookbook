#!/usr/bin/env ruby

site :opscode

# Locking version of the python cookbook that uses setuptools instead of distribute
cookbook 'python',
   :git => 'https://github.com/opscode-cookbooks/python.git',
   :ref => '345c56acefdd8670938cd7d29a19fc5394aad9fc'
cookbook 'apt'
cookbook 'yum'
cookbook 'supervisor',
   :git => 'https://github.com/opscode-cookbooks/supervisor.git',
   :ref => '3bcf67b4541554a013c2d5a99ac204eb33fd9dd4'

metadata
