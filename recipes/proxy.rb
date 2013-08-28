
def cert_up(cert_file, cert_file_text)
    # If certificate file is passed as an attribute
    unless node[:ipynb][cert_file_text].nil?
       # Set a default spot for the certificate file
       file node[:ipynb][cert_file] do
          owner 'root'
          group 'root'
          mode '0600'
          action :create
          content node[:ipynb][cert_file_text]
       end
    end
end

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

