# Create a full IPython installation along with standard scientific computing tools

# Workaround due to the pip, setuptools, supervisor craziness these past few weeks.
node.default[:supervisor][:version] = "3.0"

include_recipe "supervisor"


# Create the directory for storing notebooks
directory node[:ipynb][:notebook_dir] do
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   mode '0775'
   action :create
end

# Setup an IPython notebook service
supervisor_service node[:ipynb][:service_name] do
   user node[:ipynb][:linux_user]
   directory node[:ipynb][:home_dir]

   # Make the path for the service be the virtualenvironment
   environment "PATH" => (File.join(node[:ipynb][:virtenv], "bin"))
   action :enable
   autostart true
   autorestart true

   # Start up the IPython notebook as a service
   command "#{node[:ipynb][:virtenv]}/bin/ipython notebook --pylab #{node[:ipynb][:NotebookApp][:pylab]} --port=#{node[:ipynb][:NotebookApp][:port]} --ip=#{node[:ipynb][:NotebookApp][:ip]}"
   stopsignal "QUIT"
end

