#
# Cookbook Name:: ipynb-cookbook
# Recipe:: default
#
# Copyright (C) 2013 Rackspace
#
# Licensed under the Apache 2.0 License.
#

include_recipe "python"

# python_pip "numpy"

# Make the package manager handle an initial install so that we
# have system dependencies, whether we run IPython from site-packages or a
# virtualenv.
%w{ipython ipython-notebook ipython-doc python-pandas ipython-qtconsole
   libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
   python-matplotlib python-numpy libjs-jquery-ui-docs python-egenix-mxdatetime
   libcurl4-gnutls-dev python-pycurl-dbg}.each do |pkg|
   package pkg do
      action :upgrade
   end
end

