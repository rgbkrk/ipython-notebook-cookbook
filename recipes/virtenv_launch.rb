# Create a full IPython installation along with standard scientific computing tools

# Workaround due to the way pip was being installed.
node.default[:supervisor][:version] = "3.0b2"

include_recipe "supervisor"

# Create a group for the IPython notebook
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

# Create a virtual environment
python_virtualenv node[:ipynb][:virtenv] do
   interpreter node[:ipynb][:py_version]
   owner node[:ipynb][:user]
   group node[:ipynb][:group]
   action :create
end

# Numpy must be first, due to the way it builds
python_pip "numpy" do
   virtualenv node[:ipynb][:virtenv]
   action :upgrade
end

# Dependencies for matplotlib + others
# Version for pytz is being fixed to account for the awkward issue with
# setuptools right now
["freetype-py", "PIL", "python-dateutil", "pytz==2013b", "six"].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      action :upgrade
   end
end

# More essential packages
["scipy", "pandas", "matplotlib"].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      action :upgrade
   end
end

# Time for IPython notebook goodness
["tornado", "pyzmq", "statsmodels", "ipython"].each do |pkg|
   python_pip pkg do
      virtualenv node[:ipynb][:virtenv]
      action :upgrade
   end
end

supervisor_service "ipynb" do
   user node[:ipynb][:user]
   directory node[:ipynb][:home_dir]
   environment "PATH" => (File.join(node[:ipynb][:virtenv], "bin"))
   action :enable
   autostart true
   autorestart true
   command "#{node[:ipynb][:virtenv]}/bin/ipython notebook --pylab inline --port=#{node[:ipynb][:port]} --ip=*"
   stopsignal "QUIT"
end

