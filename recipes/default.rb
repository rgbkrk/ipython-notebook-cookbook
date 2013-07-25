#
# Cookbook Name:: ipynb-cookbook
# Recipe:: default
#
# Copyright (C) 2013 Kyle Kelley
#
# Licensed under the Apache 2.0 License.
#

include_recipe "python"

# python_pip "numpy"

# Make the package manager
%w{ipython ipython-notebook ipython-doc python-pandas ipython-qtconsole
   python-matplotlib python-numpy libjs-jquery-ui-docs python-egenix-mxdatetime
   libcurl4-gnutls-dev python-pycurl-dbg}.each do |pkg|
   package pkg do
      action :upgrade
   end
end

