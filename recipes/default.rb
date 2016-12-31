# Cookbook Name:: ipynb
# Recipe:: default
#
# Copyright (C) 2013 Rackspace
#
# Licensed under the Apache 2.0 License.
#

# include build-essential
include_recipe 'build-essential::default'

# Unless the paths got overridden, we set them up here
if node['ipynb']['home_dir'].nil? || node['ipynb']['home_dir'].empty?
  node.default['ipynb']['home_dir'] = File.join('/home/', node['ipynb']['linux_user'])
end

if node['ipynb']['notebook_dir'].nil? || node['ipynb']['notebook_dir'].empty?
  node.default['ipynb']['notebook_dir'] = File.join(node['ipynb']['home_dir'],
                                          'notebooks')
end

if node['ipynb']['virtenv'].nil? || node['ipynb']['virtenv'].empty?
  node.default['ipynb']['virtenv'] = File.join(node['ipynb']['home_dir'], '.ipyvirt')
end

# Make the package manager handle an initial install so that we
# have system dependencies, whether we run IPython from site-packages or a
# virtualenv.
node['ipynb']['system_packages'].each do |pkg|
  package pkg do
    action :install
  end
end

# Group running the IPython notebook (*nix permissions)
group node['ipynb']['linux_group'] do
  group_name node['ipynb']['linux_group']
  action :create
end

# User (also runs the IPython notebook)
user node['ipynb']['linux_user'] do
  comment 'User for ipython notebook'
  gid node['ipynb']['linux_group']
  home node['ipynb']['home_dir']
  shell '/bin/bash'
  manage_home true
  action :create
end

# Ensure the requested python version is available
python_runtime 'notebook_interpreter' do
  version node['ipynb']['py_version']
end

# Create a virtual environment
python_virtualenv node['ipynb']['virtenv'] do
  python 'notebook_interpreter'
  user node['ipynb']['linux_user']
  group node['ipynb']['linux_group']
  action :create
  system_site_packages true
end

# Make sure uwsgi gets installed
# python_package 'uwsgi' do
#   virtualenv node['ipynb']['virtenv']
#   user node['ipynb']['linux_user']
#   group node['ipynb']['linux_group']
#   action :install
# end

# Install the entire scientific computing stack
node[:ipynb][:scientific_stack].each do |pkg, version|
  python_package pkg do
    version version unless version.nil?
    virtualenv node['ipynb']['virtenv']
    user node['ipynb']['linux_user']
    group node['ipynb']['linux_group']
    action :install
  end
end

# IPython proper
python_package node['ipynb']['ipython_package'] do
  version node['ipynb']['ipython_package_version'] unless node['ipynb']['ipython_package_version'].nil?
  virtualenv node['ipynb']['virtenv']
  user node['ipynb']['linux_user']
  group node['ipynb']['linux_group']
  action :install
end

# Any additional packages to build into the same virtual environment
node[:ipynb][:extra_packages].each do |pkg, version|
  python_package pkg do
    version version unless version.nil?
    virtualenv node['ipynb']['virtenv']
    user node['ipynb']['linux_user']
    group node['ipynb']['linux_group']
    action :install
  end
end
