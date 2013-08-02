#
# Cookbook Name:: ipynb-cookbook
# Recipe:: default
#
# Copyright (C) 2013 Rackspace
#
# Licensed under the Apache 2.0 License.
#

include_recipe "python"

# Make the package manager handle an initial install so that we
# have system dependencies, whether we run IPython from site-packages or a
# virtualenv.
node[:ipynb][:system_packages].each do |pkg|
   package pkg do
      action :upgrade
   end
end

# Create a virtual environment
python_virtualenv node[:ipynb][:virtenv] do
   interpreter node[:ipynb][:py_version]
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   action :create
end

# Install the entire scientific computing stack, including numpy, scipy,
# matplotlib, and pandas
node[:ipynb][:scientific_stack].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      action :upgrade
   end
end

# IPython notebook dependencies
node[:ipynb][:ipython_deps].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      action :upgrade
   end
end

# IPython proper
python_pip node[:ipynb][:ipython_package] do
   virtualenv node[:ipynb][:virtenv]
   action :upgrade
end

# Any additional packages to build into the same virtual environment
node[:ipynb][:extra_packages].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      action :upgrade
   end
end

