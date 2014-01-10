# Cookbook Name:: ipynb
# Recipe:: default
#
# Copyright (C) 2013 Rackspace
#
# Licensed under the Apache 2.0 License.
#

include_recipe "python"

# Unless the paths got overridden, we set them up here
if node[:ipynb][:home_dir].nil? || node[:ipynb][:home_dir].empty?
    node.set[:ipynb][:home_dir] = File.join("/home/", node[:ipynb][:linux_user])
end

if node[:ipynb][:notebook_dir].nil? || node[:ipynb][:notebook_dir].empty?
    node.set[:ipynb][:notebook_dir] = File.join(node[:ipynb][:home_dir],
                                            "notebooks")
end

if node[:ipynb][:virtenv].nil? || node[:ipynb][:virtenv].empty?
    node.set[:ipynb][:virtenv] = File.join(node[:ipynb][:home_dir], ".ipyvirt")
end

# Make the package manager handle an initial install so that we
# have system dependencies, whether we run IPython from site-packages or a
# virtualenv.
node[:ipynb][:system_packages].each do |pkg|
   package pkg do
      action :install
   end
end

# Group running the IPython notebook (*nix permissions)
group node[:ipynb][:linux_group] do
     group_name node[:ipynb][:linux_group]
     action :create
end

# User (also runs the IPython notebook)
user node[:ipynb][:linux_user] do
  comment 'User for ipython notebook'
  gid node[:ipynb][:linux_group]
  home node[:ipynb][:home_dir]
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end

# Create a virtual environment
python_virtualenv node[:ipynb][:virtenv] do
   interpreter node[:ipynb][:py_version]
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   action :create
end

# Make sure uwsgi gets installed
python_pip "uwsgi" do
   virtualenv node[:ipynb][:virtenv]
   user node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   action :install
end

# Install the entire scientific computing stack
node[:ipynb][:scientific_stack].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      user node[:ipynb][:linux_user]
      group node[:ipynb][:linux_group]
      action :install
   end
end

# IPython proper
python_pip node[:ipynb][:ipython_package] do
   virtualenv node[:ipynb][:virtenv]
   user node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   action :install
end

# Any additional packages to build into the same virtual environment
node[:ipynb][:extra_packages].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      user node[:ipynb][:linux_user]
      group node[:ipynb][:linux_group]
      action :install
   end
end

