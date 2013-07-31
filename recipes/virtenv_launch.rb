# Create a full IPython installation along with standard scientific computing tools

# Workaround due to the way pip was being installed.
node.default[:supervisor][:version] = "3.0b2"

include_recipe "supervisor"

# Group using the notebook files (*nix permissions)
group node[:ipynb][:group] do
     group_name node[:ipynb][:group]
     action :create
end

# User (also runs the IPython notebook)
user node[:ipynb][:user] do
  comment 'User for ipython notebook'
  gid node[:ipynb][:group]
  home node[:ipynb][:home_dir]
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end

# Decide where to store notebooks
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

# Setup an IPython notebook service
supervisor_service node[:ipynb][:service_name] do
   user node[:ipynb][:user]
   directory node[:ipynb][:home_dir]

   # Make the path for the service be the virtualenvironment
   environment "PATH" => (File.join(node[:ipynb][:virtenv], "bin"))
   action :enable
   autostart true
   autorestart true

   # Start up the IPython notebook as a service
   command "#{node[:ipynb][:virtenv]}/bin/ipython notebook --pylab inline --port=#{node[:ipynb][:NotebookApp][:port]} --ip=*"
   stopsignal "QUIT"
end

