#
# Author:: Kyle Kelley <rgbkrk@gmail.com>
# Cookbook Name:: ipynb
# Recipe:: virtenv_launch
#
# Copyright:: 2013, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Create a full IPython installation along with standard scientific computing tools

include_recipe "supervisor"

ipython_settings_dir = File.join(node[:ipynb][:home_dir], ".ipython")

# Create the directory for storing notebooks
directory node[:ipynb][:notebook_dir] do
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   mode '0775'
   action :create
end

# Make sure the default profile exists, to deal with IPython bugs/strangeness
ipynb_profile 'default' do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
   ipython_settings_dir ipython_settings_dir
end

ipynb_profile node[:ipynb][:profile_name] do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
   ipython_settings_dir ipython_settings_dir
end

ipynb_mathjax "MathJax!" do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
   install_dir File.join(node[:ipynb][:virtenv], "lib", node[:ipynb][:py_version],
                         "site-packages/IPython/html/static/mathjax")
end

profile_dir = File.join(ipython_settings_dir,
                        "profile_" + node[:ipynb][:profile_name])

nb_config = File.join(profile_dir, "ipython_notebook_config.py")


# Set the password hash if the password is set
unless node[:ipynb][:NotebookApp][:password].nil?
   ipy_hash = IPythonAuth.ipython_hash(node[:ipynb][:NotebookApp][:password])
   node.set[:ipynb][:NotebookApp][:password_hash] = ipy_hash
end

# Write over the profile with our own built template
template nb_config do
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   mode 00644
   source "ipython_notebook_config.py.erb"
end

# Setup an IPython notebook service
supervisor_service node[:ipynb][:service_name] do
   user node[:ipynb][:linux_user]
   directory node[:ipynb][:home_dir]

   # IPython notebook should have access to the shell
   environment "HOME" => node[:ipynb][:home_dir],
               "SHELL" => "/bin/bash",
               "USER" => node[:ipynb][:linux_user],
               "PATH" => "#{node[:ipynb][:virtenv]}/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games",
               "VIRTUAL_ENV" => "#{node[:ipynb][:virtenv]}"

   # Make the path for the service be the virtualenvironment
   #environment "PATH" => (File.join(node[:ipynb][:virtenv], "bin") + ":$PATH")
   action :enable
   autostart true
   autorestart true

   # Start up the IPython notebook as a service
   command "#{node[:ipynb][:virtenv]}/bin/ipython notebook --profile=#{node[:ipynb][:profile_name]}"
   stopsignal "QUIT"
end

