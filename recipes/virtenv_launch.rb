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

#include_recipe "ipynb::profile"
include_recipe "ipynb"

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

ipynb_profile node[:ipynb][:profile_name] do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
end

# Setup an IPython notebook service
supervisor_service node[:ipynb][:service_name] do
   user node[:ipynb][:linux_user]
   directory node[:ipynb][:home_dir]

   # Make the path for the service be the virtualenvironment
   #environment "PATH" => (File.join(node[:ipynb][:virtenv], "bin") + ":$PATH")
   action :enable
   autostart true
   autorestart true

   # Start up the IPython notebook as a service
   command "#{node[:ipynb][:virtenv]}/bin/ipython notebook --pylab #{node[:ipynb][:NotebookApp][:pylab]} --port=#{node[:ipynb][:NotebookApp][:port]} --ip=#{node[:ipynb][:NotebookApp][:ip]}"
   stopsignal "QUIT"
end

