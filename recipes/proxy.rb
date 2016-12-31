
def cert_up(cert_file, cert_file_text)
  # If certificate file is passed as an attribute
  # Set a default spot for the certificate file
  file cert_file do
    owner 'root'
    group 'root'
    mode '0600'
    action :create
    content cert_file_text
    sensitive true
    not_if { cert_file_text.nil? }
  end
end

###########################################################################
# NGINX proxying
#
# nginx version must be greater than 1.4.x in order to support
# web sockets (for interacting with the IPython kernel)
#
###########################################################################

include_recipe 'nginx::source'

# Install certs
cert_up(node['ipynb']['ssl_certificate'], node['ipynb']['ssl_certificate_text'])
cert_up(node['ipynb']['ssl_certificate_key'], node['ipynb']['ssl_certificate_key_text'])

template "/etc/nginx/sites-available/#{node['ipynb']['proxy']['hostname']}" do
  source 'nginx-proxy.erb'
  notifies :restart, 'service[nginx]'
end

nginx_site 'default' do
  enable false
end

nginx_site node['ipynb']['proxy']['hostname'] do
  enable true
end
