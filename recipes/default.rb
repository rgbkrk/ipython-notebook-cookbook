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
node[:ipynb][:system_packages].each do |pkg|
   package pkg do
      action :upgrade
   end
end

