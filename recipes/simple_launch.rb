# Creates a simple setup of an IPython notebook server, creating a dummy user, a place to store IPython notebooks,

include_recipe "supervisor"

group 'ipynb' do
     group_name 'ipynb'
     action :create
end

# For now we'll make the user ipynb until we make it configurable
user 'ipynb' do
  comment 'User for ipython notebook'
  gid 'ipynb'
  home '/home/ipynb'
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end

directory '/home/ipynb/notebooks/' do
   owner 'ipynb'
   group 'ipynb'
   mode '0775'
   action :create
end

supervisor_service "ipynb" do
   action :enable
   autostart true
   autorestart true
   user "ipynb"
   command "ipython notebook --port=8888 --ip=*"
   stopsignal "QUIT"
   directory "/home/ipynb/notebooks"
end

