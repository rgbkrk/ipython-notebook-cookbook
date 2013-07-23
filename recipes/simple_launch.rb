# Creates a simple setup of an IPython notebook server, creating a dummy user, a place to store IPython notebooks, and sets up IPython notebook as a service

include_recipe "supervisor"

group node[:ipynb][:group] do
     group_name node[:ipynb][:group]
     action :create
end

# For now we'll make the user ipynb until we make it configurable
user node[:ipynb][:user] do
  comment 'User for ipython notebook'
  gid node[:ipynb][:group]
  home node[:ipynb][:home_dir]
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end

directory node[:ipynb][:notebook_dir] do
   owner node[:ipynb][:user]
   group node[:ipynb][:group]
   mode '0775'
   action :create
end

supervisor_service "ipynb" do
   action :enable
   autostart true
   autorestart true
   user node[:ipynb][:user]
   command "ipython notebook --pylab inline --port=#{node[:ipynb][:port]} --ip=*"
   stopsignal "QUIT"
   directory node[:ipynb][:notebook_dir]
end

