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

%w{ipython ipython-notebook ipython-doc python-pandas ipython-qtconsole python-matplotlib python-numpy apache2 httpd libjs-jquery-ui-docs python-egenix-mxdatetime mysql-server-5.1 mysql-server python-mysqldb-dbg libcurl4-gnutls-dev python-pycurl-dbg mysql-client postgresql-client}.each do |pkg|
   package pkg do
      action :upgrade
   end
end



