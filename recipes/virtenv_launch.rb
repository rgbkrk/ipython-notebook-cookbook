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

# Create the directory for storing notebooks
directory node[:ipynb][:notebook_dir] do
   owner node[:ipynb][:linux_user]
   group node[:ipynb][:linux_group]
   mode '0775'
   action :create
end

# Make sure the default profile exists, to deal with strangeness
ipynb_profile 'default' do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
end

ipynb_profile node[:ipynb][:profile_name] do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
end

ipynb_mathjax "MathJax!" do
   action :create
   owner node[:ipynb][:linux_user]
   ipython_path "#{node[:ipynb][:virtenv]}/bin/ipython"
   install_dir File.join(node[:ipynb][:virtenv], "lib", node[:ipynb][:py_version],
                         "site-packages/IPython/html/static/mathjax")
end

profile_dir = File.join(node[:ipynb][:ipython_settings_dir],
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

def cert_up(cert_file, cert_file_text)
    # If certificate file is passed as an attribute
    unless node[:ipynb][cert_file_text].nil?
       # Set a default spot for the certificate file
       file node[:ipynb][cert_file] do
          owner node[:ipynb][:linux_user]
          group node[:ipynb][:linux_group]
          mode '0600'
          action :create
          content node[:ipynb][cert_file_text]
       end
    end
end

#include_recipe "firewall"

# Setup nginx forwarding if enabled
if node[:ipynb][:proxy][:enable]

   ###########################################################################
   # NGINX proxying
   #
   # nginx version must be greater than 1.4.x in order to support
   # web sockets (for interacting with the IPython kernel)
   #
   # Chef-solo is behaving oddly for setting these attributes in
   # attributes/default.rb, so I inject here
   #
   ###########################################################################

   node.set[:nginx][:default_site_enabled] = false

   node.set[:nginx][:version] = "1.5.3"
   node.set[:nginx][:source][:version] = "1.5.3"
   # The Chef checksum of a binary is determined by: shasum -a 256 FILE_NAME
   node.set[:nginx][:source][:checksum] = "edcdf2030750b4eb1ba8cd79365c16a3e33e6136b7fdd8a1a7b4082397f4e92b"
   node.set[:nginx][:source][:prefix] = "/opt/nginx-#{node[:nginx][:source][:version]}"
   node.set[:nginx][:source][:url] = "http://nginx.org/download/nginx-#{node[:nginx][:source][:version]}.tar.gz"
   node.set[:nginx][:source][:sbin_path] = "#{node[:nginx][:source][:prefix]}/sbin/nginx"

   node.set[:nginx][:source][:default_configure_flags] = [
     "--prefix=#{node[:nginx][:source][:prefix]}",
     "--conf-path=#{node[:nginx][:dir]}/nginx.conf",
     "--sbin-path=#{node[:nginx][:source][:sbin_path]}"
   ]
   node.set[:nginx][:init_style] = "runit"

   include_recipe "nginx::source"

   # Install certs
   cert_up(:ssl_certificate, :ssl_certificate_text)
   cert_up(:ssl_certificate_key, :ssl_certificate_key_text)

   template "/etc/nginx/sites-available/#{node[:ipynb][:proxy][:hostname]}" do
      source "nginx-proxy.erb"
      notifies :restart, "service[nginx]"
   end

   nginx_site "default" do
      enable false
   end

   nginx_site node[:ipynb][:proxy][:hostname] do
      enable true
   end

   #firewall_rule "http" do
   #   port 80
   #   action :allow
   #end

   #firewall_rule "https" do
   #   port 443
   #   action :allow
   #end

else
   #firewall_rule node[:ipynb][:service_name] do
   #   port node[:ipynb][:NotebookApp][:port]
   #   action :allow
   #end
end



