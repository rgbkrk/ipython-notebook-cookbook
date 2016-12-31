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

ipython_settings_dir = File.join(node['ipynb']['home_dir'], '.jupyter')

# Create the directory for storing notebooks
directory node['ipynb']['notebook_dir'] do
  owner node['ipynb']['linux_user']
  group node['ipynb']['linux_group']
  mode '0775'
  action :create
end

# Make sure the default profile exists, to deal with IPython bugs/strangeness
#  ipynb_profile 'default' do
#    action :create
#    owner node['ipynb']['linux_user']
#    ipython_path "#{node['ipynb']['virtenv']}/bin/jupyter"
#    ipython_settings_dir ipython_settings_dir
#  end

#  ipynb_profile node['ipynb']['profile_name'] do
#    action :create
#    owner node['ipynb']['linux_user']
#    ipython_path "#{node['ipynb']['virtenv']}/bin/jupyter"
#    ipython_settings_dir ipython_settings_dir
#  end

nb_config = File.join(ipython_settings_dir, 'jupyter_notebook_config.py')

# Set the password hash if the password is set
unless node['ipynb']['NotebookApp']['password'].nil?
  ipy_hash = IPythonAuth.ipython_hash(node['ipynb']['NotebookApp']['password'])
  node.set['ipynb']['NotebookApp']['password_hash'] = ipy_hash
end

directory "/home/#{node['ipynb']['linux_user']}/.jupyter" do
  owner node['ipynb']['linux_user']
  group node['ipynb']['linux_group']
end

# Write over the configuration with our own built template
template nb_config do
  owner node['ipynb']['linux_user']
  group node['ipynb']['linux_group']
  mode 00644
  source 'jupyter_notebook_config.py.erb'
end

poise_service node['ipynb']['service_name'] do
  user node['ipynb']['linux_user']
  command "#{node['ipynb']['virtenv']}/bin/jupyter notebook"
  directory node['ipynb']['home_dir']
  environment 'HOME' => node['ipynb']['home_dir'],
              'SHELL' => '/bin/bash',
              'USER' => node['ipynb']['linux_user'],
              'PATH' => "#{node['ipynb']['virtenv']}/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games",
              'VIRTUAL_ENV' => node['ipynb']['virtenv']
end
