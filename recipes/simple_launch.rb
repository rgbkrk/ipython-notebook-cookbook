#
# Cookbook Name:: ipynb-cookbook
# Recipe:: simple_launch
#
# Creates a simple setup of an IPython notebook server, creating a dummy user, a
# place to store IPython notebooks, and sets up IPython notebook as a service
#
# Copyright (C) 2013 Rackspace
#
# Licensed under the Apache 2.0 License.
#


node.default[:supervisor][:version] = "3.0b2"

include_recipe "supervisor"

# Create a group for the IPython notebook
group node[:ipynb][:linux_group] do
     group_name node[:ipynb][:linux_group]
     action :create
end

# Set up a user for IPython notebook, complete with a home directory
user node[:ipynb][:linux_user] do
  comment 'User for ipython notebook'
  gid node[:ipynb][:linux_group]
  home node[:ipynb][:home_dir]
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end

# Set up a simple place to store notebooks
directory node[:ipynb][:notebook_dir] do
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   mode '0775'
   action :create
end

# Launch IPython notebook as a service
supervisor_service "ipynb" do
   action :enable
   autostart true
   autorestart true
   user node[:ipynb][:linux_user]
   # For now simply support pylab inline, pick the port and assume broadcasting on all IPs
   command "ipython notebook --pylab inline --port=#{node[:ipynb][:NotebookApp][:port]} --ip=*"
   stopsignal "QUIT"
   directory node[:ipynb][:notebook_dir]
end

